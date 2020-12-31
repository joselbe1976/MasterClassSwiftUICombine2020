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
    
    
    func getTestSerie() -> records{
          return  records(id: 1009146, name: "", description: "he flagship X-Men comic for over 40 years, Uncanny X-Men delivers action, suspense, and a hint of science fiction month in and month out. Follow the adventures of Professor Charles Xavier's team of mutants as they attempt to protect a world that hates and fears them.", title: "Moon Girl and Devil Dinosaur (2015 - 2019)", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/e0/56d0caf175be0", thumbnailExtension: Extension.jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146")
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


