//
//  WebSocketManager.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 10/07/2024.
//

import Foundation
import UIKit

enum WebSocketMessage {
    case string(String)
    case data(Data)
}
let PREFERENCE = UserDefaults.standard

protocol WebSocketManagerDelegate: AnyObject {
    func didConnect()
    func didDisconnect()
    func didFail(withError error: Error)
    func didReceiveMessage(_ message: String)
    func didReceiveData(_ data: Data)
    func didReceiveSocketData(_ data: SocketModel)
    
}

extension WebSocketManagerDelegate {
    func didConnect() {
        print("didConnect")
    }
    
    func didDisconnect() {
        print("didConnect")
    }
    
    func didFail(withError error: any Error) {
        print("didConnect")
    }
    
    func didReceiveMessage(_ message: String) {
        print("didConnect")
    }
    
    func didReceiveData(_ data: Data) {
        print("didConnect")
    }
    
    func didReceiveSocketData(_ data: SocketModel) {
        print("didConnect")
    }
    
    
}


class WebSocketManager: NSObject, URLSessionTaskDelegate {
    
    private let socketQueue = DispatchQueue(label: "com.sportified.Sportified")
    private let semaphore = DispatchSemaphore(value: 1) // For synchronization
    
    weak var delegate: WebSocketManagerDelegate?
    static let shared = WebSocketManager()
    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession?
    private var messageQueue: [WebSocketMessage] = []
    private var isSendingData = false
    private var sendCompletionHandler: ((Error?) -> Void)?
    private var retryTimer: Timer?
    var isSocketConnected: Bool = false
    
    // MARK: - Connect To Websocket with Url
    func connect() {
        let socketURLString = "ws://3.83.13.164/ws/chat/"
        let url = URL(string: socketURLString)!
        socketQueue.async {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                print("Attempting to connect to URL: \(url)")
                
    //            guard !self.isSocketConnected,
    //                  self.isInternetAvailable(),
    //                  UIApplication.shared.applicationState == .active,
    //                  PREFERENCE.bool(forKey: "isLogin")
    //            else {
    //                return
    //            }
                
                let isActive = UIApplication.shared.applicationState == .active
                
                let backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {})
                let sessionDelegateQueue = OperationQueue()
                sessionDelegateQueue.qualityOfService = .utility
                
                let configuration = URLSessionConfiguration.default
                
                if !isActive {
                    configuration.sessionSendsLaunchEvents = true
                    configuration.isDiscretionary = true
                }
                
                // Retrieve the token
                let token = UserDefaultsManager.shared.authToken
                
                // Append the token as a query parameter
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = [
                    URLQueryItem(name: "token", value: token)
                ]
                
                guard let urlWithToken = urlComponents?.url else {
                    print("Failed to construct URL with token.")
                    UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
                    return
                }
                
                self.urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: sessionDelegateQueue)
                
                self.webSocketTask = self.urlSession?.webSocketTask(with: urlWithToken)
                self.webSocketTask?.resume()
                
                self.receive()
                
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
    }

    
    // MARK: - Disconnect active websocket connection
    func disconnect() {
        socketQueue.async {
            self.webSocketTask?.cancel()
        }
    }
    
    // MARK: - Retrying to connect to socket
    func retryConnection() {
        socketQueue.async {
            DispatchQueue.main.async {
                guard !self.isSocketConnected,
                      UIApplication.shared.applicationState == .active
                else {
                    return
                }
            }
            self.startSocketTimer()
        }
    }
    
    // MARK: - Starting timer for retrying socket to connect
    func startSocketTimer() {
        socketQueue.async {
            self.stopSocketTimer()
            
            self.retryTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.attemptConnection), userInfo: nil, repeats: true)
            self.retryTimer?.fire()
        }
    }
    
    // MARK: - Stopping timer for retrying socket to connect
    func stopSocketTimer() {
        socketQueue.async {
            self.retryTimer?.invalidate()
            self.retryTimer = nil
        }
    }
    
    // MARK: - Main Logic For attempting to connect to socket when retrying
    @objc private func attemptConnection() {
        socketQueue.async {
            DispatchQueue.main.async {
                guard !self.isSocketConnected,
                      let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                      UIApplication.shared.applicationState == .active
                else {
                    return
                }
             //   appDelegate.connect()
            }
        }
    }
    
    // MARK: - Main logic to check if socket is in running state
    func checkWebSocketConnected() -> Bool {
        var connected = false
        
        socketQueue.sync {
            guard let webSocketTask = self.webSocketTask,
                  webSocketTask.state == .running
            else {
                return
            }
            
            connected = true
        }
        
        return connected
    }
    
    // MARK: - Main logic to check if user has an active internet connection
    private func isInternetAvailable() -> Bool {
        var isConnected = false
        
        print("Checking internet connection status")
        isConnected = Reachability.isConnectedToNetwork()
        
        return isConnected
    }
    
    // MARK: - Adding data to queue to process one by one while sending via socket
    func sendData(_ data: Data, completion: @escaping (Error?) -> Void) {
        socketQueue.async {
            self.messageQueue.append(WebSocketMessage.data(data))
            self.sendCompletionHandler = completion
            
            if !self.isSendingData {
                self.sendNextData()
            }
        }
    }
    
    // MARK: - Processing queue data to send via socket
    private func sendNextData() {
        socketQueue.async {
            guard let webSocketTask = self.webSocketTask,
                  webSocketTask.state == .running,
                  let nextData = self.messageQueue.first
            else {
                self.isSendingData = false
                return
            }
            
            self.isSendingData = true
            
            switch nextData {
            case .data(let data):
                let webSocketMessage = URLSessionWebSocketTask.Message.data(data)
                webSocketTask.send(webSocketMessage) { [weak self] error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        self.sendCompletionHandler?(error)
                    } else {
                        self.sendCompletionHandler?(nil)
                    }
                    
                    self.socketQueue.async {
                        if !self.messageQueue.isEmpty {
                            self.messageQueue.removeFirst()
                            self.sendNextData()
                        } else {
                            self.isSendingData = false
                        }
                    }
                }
            case .string:
                // Handle string messages if needed
                break
            }
        }
    }
    
    // MARK: - Receive Socket data to process
    private func receive() {
        socketQueue.async {
            guard let webSocketTask = self.webSocketTask else {
                return
            }
            
            webSocketTask.receive { [weak self] result in
                switch result {
                case .success(let message):
                    self?.handleReceivedMessage(message)
                    self?.receive()
                case .failure(let error):
                    self?.socketQueue.async {
                        self?.isSocketConnected = false
                        self?.delegate?.didFail(withError: error)
                    }
                }
            }
        }
    }
    
    // MARK: - Processing received socket data
    private func handleReceivedMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .data(let data):
            // Handle binary data message
            print("Received binary message: \(data)")
            // If your app uses binary data, process it accordingly
        case .string(let text):
            // Handle text message
            // Convert the JSON string into SocketModel
            if let data = text.data(using: .utf8) {
                do {
                    let socketModel = try JSONDecoder().decode(SocketModel.self, from: data)
                    // Now you have a SocketModel instance
                    print("Decoded SocketModel: \(socketModel)")
                    // Handle the SocketModel instance as needed
                    delegate?.didReceiveSocketData(socketModel)
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            } else {
                print("Failed to convert text to Data.")
            }
        @unknown default:
            // Handle future cases if Apple adds new message types
            print("Received an unknown message type.")
        }
    }


}

// MARK: - URLSessionWebSocketDelegate Methods
extension WebSocketManager: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        socketQueue.async {
            self.isSocketConnected = true
            self.stopSocketTimer()
            self.delegate?.didConnect()
        }
    }
    
  
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        socketQueue.async {
            
            if let error = error {
                print("WebSocket connection error: \(error.localizedDescription)")
            } else {
                print("WebSocket connection completed successfully.")
            }
            self.isSocketConnected = false
            
            if let error = error {
                self.delegate?.didFail(withError: error)
                self.retryConnection()
            } else {
                self.delegate?.didDisconnect()
            }
        }
    }
}

