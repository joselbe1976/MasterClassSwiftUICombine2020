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
    @Published var photo:UIImage?{
        didSet{
            //print("Asignada Imagen nueva")
        }
    }
    

    // subscriptor de any Cancelable
    //var subscribers = Set<AnyCancellable>()
   // var subscribers : AnyCancellable?
    var subscribers = Set<AnyCancellable>()
    
    // Download the Image URL
    func loadImage(urlString:String){
                
        print("photo: \(urlString)")
        let url = URL(string: urlString)!
 
            URLSession.shared
                   .dataTaskPublisher(for: url)
                   .map {
                        UIImage(data: $0.data)
                   }
                   .replaceError(with: nil)
                   .receive(on: DispatchQueue.main)
                   .sink {
                        self.photo = $0
                   }
                   .store(in: &subscribers)
    }
    
    // Cancel
    func CancelAllSubcribers(){
       
    }
}
