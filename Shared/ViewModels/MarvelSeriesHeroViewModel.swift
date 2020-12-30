//
//  MarvelSeriesHeroViewModel.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import SwiftUI
import Combine

class MarvelSeriesHeroViewModel : ObservableObject {


    @Published var dataMarvel:MarvelModel?
    @Published var estado = Estados.none


    
    // Subscriptor
    var subscribers = Set<AnyCancellable>()
    
    // Load Data from Marvel Api Rest
    func loadMarvelDataSeries(idHero:Int){
        
        self.estado = Estados.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionMarvelSeries(idHero: idHero))
            .tryMap (tryMapClosure(statusCode: 200))
            .decode(type: MarvelModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR load marvel data Series: \(error)")
                    self.estado = Estados.error
                case .finished:
                    print("finish Load Marvel data Series")
                    self.estado = Estados.loaded
                }
            } receiveValue: { data in
                self.dataMarvel = data
               
            }
            .store(in: &subscribers)
    }
    
    
    func tryMapClosure(statusCode:Int) -> ((data:Data, response:URLResponse)) throws -> Data {
        let closure:((data:Data, response:URLResponse)) throws -> Data = {
            guard let response = $0.response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            if response.statusCode == statusCode {
                return $0.data
            } else {
                throw URLError(.init(rawValue: response.statusCode))
            }
        }
        return closure
    }
    
}


