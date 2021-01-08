//
//  MarvelPhotoViewModel.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import Combine
import SwiftUI

/*
  Download foto of Hero with a URL

// Deve ser una clase Siempre.
 */

class PhotoViewModel : ObservableObject {
    @Published var photo:Image?{
        didSet{
            //print("Asignada Imagen nueva")
        }
    }

    var subscribers = Set<AnyCancellable>()
    
    // Download the Image URL
    #if os(iOS) || os(watchOS) || os(tvOS)
        func loadImage(urlString:String){
                    
            print("photo: \(urlString)")
            let url = URL(string: urlString)!
     
                URLSession.shared
                       .dataTaskPublisher(for: url)
                       .map {
                            UIImage(data: $0.data)
                       }
                       .map { data -> Image in
                            Image(uiImage: data!)
                       }
                       .replaceError(with: nil)
                       .receive(on: DispatchQueue.main)
                       .sink {
                            self.photo = $0
                       }
                       .store(in: &subscribers)
        }
    #elseif os(OSX)
        func loadImage(urlString:String){
                    
            print("photo: \(urlString)")
            let url = URL(string: urlString)!
     
                URLSession.shared
                       .dataTaskPublisher(for: url)
                       .map {
                           return  NSImage(data: $0.data)
                       }
                       .replaceError(with: nil)
                       .receive(on: DispatchQueue.main)
                      .sink {
                        if let data =  $0{
                            self.photo = Image(nsImage: data)
                        }
                            
                       }
                       .store(in: &subscribers)
        }
    #endif
    // Cancel
    func CancelAllSubcribers(){
       
    }
}
