//
//  WebImageView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    
    var image:String
    var placeholder =  Image.ic_User
    var body: some View {
        WebImage(url: URL(string: "http://3.83.13.164\(image)")) { image in
              image.resizable()
          } placeholder: {
              placeholder.resizable()
                  .aspectRatio(contentMode: .fit)
          }
          // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
          .onSuccess { image, data, cacheType in
              // Success
              // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
          }
          .indicator(.activity) // Activity Indicator
          .transition(.fade(duration: 0.5)) // Fade Transition with duration
      
    }
}
