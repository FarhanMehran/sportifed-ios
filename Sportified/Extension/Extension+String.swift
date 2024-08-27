//
//  Extension+String.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation
extension String {
   
    var encryptPhoneNumber: String {
        let string = self
        var substring = string.prefix(7)
        let index = substring.index(substring.startIndex, offsetBy: 4)
        substring.insert(" ", at: index)
        return "\(substring) ********"
    }
    
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    var formattedDateTime: String {
        let givendate = self.prefix(19)
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: "\(givendate).0Z") else {
            return "Invalid date format"
        }
        let dateFormatter = DateFormatter()
               dateFormatter.locale = Locale(identifier: "en_US_POSIX")
               dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Convert to desired date and time format
        dateFormatter.dateFormat = "E MMM yyyy, hh:mm a" // Adjust to your preferred format
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var dateFormat: String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy:MM:dd"
        guard let date = inputFormatter.date(from: self) else {
            return ""
        }
        inputFormatter.dateFormat = "E MMM yyyy"
        return inputFormatter.string(from: date)
    }
    
   
    
    var timeFormat: String {
        let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm:ss"
           formatter.locale = Locale(identifier: "en_US_POSIX")
           guard let parsedDate = formatter.date(from: self) else {
               return "nil" // Return nil if the date string couldn't be parsed
           }
           formatter.dateFormat = "hh:mm a"
           return formatter.string(from: parsedDate)
   }
    //2024-12-10T10:10:10
    var uploadDateFormate: String{
        
        let date = self
        
        return date
    }
    
    var to12HourFormat: String? {
        var dateFom = String(self.prefix(19))
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        // Convert the string to a Date object
        if let date = inputFormatter.date(from: String(dateFom)) {
            let datef = DateFormatter()
            datef.dateFormat = "h:mm a"
            datef.locale = Locale(identifier: "en_US_POSIX")
            datef.timeZone = TimeZone.current // Use the current timezone

            dateFom = datef.string(from: date)
          
        }
          
          // Convert the Date object to the desired string format
        return dateFom
      }
    
    func extractMinutes() -> String? {
           let dateFormatter = ISO8601DateFormatter()
           dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
           
           if let date = dateFormatter.date(from: self) {
               let calendar = Calendar.current
               let minutes = calendar.component(.minute, from: date)
               return String(format: "%02d", minutes)
           }
           return nil
       }
    
    var  sortListOnTime: String? {
          // Define the date formatter to parse the original string
          let inputFormatter = DateFormatter()
          inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
          inputFormatter.locale = Locale(identifier: "en_US_POSIX")
          inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
          
          // Convert the string to a Date object
          guard let date = inputFormatter.date(from: self) else {
              return nil
          }
          
          // Define the output date formatter
          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = "h:mm a"
          outputFormatter.locale = Locale(identifier: "en_US_POSIX")
          outputFormatter.timeZone = TimeZone.current
          
          // Convert the Date object to the desired string format
          return outputFormatter.string(from: date)
      }
}
