//
//  Utility.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation
import UIKit
import AVFoundation

class Utility: NSObject {
    
    static let mobileNoPatternRemove = [" "]
    static let mobileNoPattern = "### ### ####"
    static let mobileNoPatternReplace: Character = "#"
    
    //MARK: - Date Format
    /**Change Date Format*/
    static func changeDateFormatReturnString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    static func getCurrentDate() ->String{
      
        let currentDate = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current

        return formatter.string(from: currentDate)
    }
    
    static func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            // Camera access already granted, you can proceed with camera operations
            completion(true)
        case .notDetermined:
            // Request camera access
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            // Camera access denied
            completion(false)
        }
    }
    
    public static func secondsToMinutesSeconds(_ seconds: Int) -> String {
        let minutes = seconds / 60 % 60
        let seconds = seconds % 60
        return String(format:"%02i : %02i", minutes, seconds)
    }
    
    static func isValidEmail(emailStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func getRegionCountryCode() -> [RegionCountryCode]  {
        var regionCountryCode: [RegionCountryCode] = []
        if let fileURL = Bundle.main.url(forResource: "CountriesList", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                regionCountryCode = try decoder.decode([RegionCountryCode].self, from: jsonData)
            } catch {
                print("Error loading JSON data: \(error.localizedDescription)")
            }
        } else {
            print("JSON file not found.")
        }
        return regionCountryCode
    }
    
}
