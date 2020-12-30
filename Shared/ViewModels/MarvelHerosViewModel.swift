//
//  MarvelVuewModel.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import Combine
import SwiftUI

enum Estados {
    case none, loading, loaded, error
}

final class MarvelHerosViewModel : ObservableObject {


    @Published var dataMarvel:MarvelModel?
    @Published var estado = Estados.none

    
    
    // Subscriptor
    var subscribers = Set<AnyCancellable>()
    
    init(testData:Bool = false) {
        if !testData {
            // load data from marvel Api
            loadMarvelData()
        }
        else{
            // Data Test
            let foto1 = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: Extension.jpg)
           
            let char1 = records(id: 1011334, name: "3-D Man", description: "", title: "", thumbnail: foto1, resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334")
            let foto2 = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", thumbnailExtension: Extension.jpg)
            let char2 = records(id: 1009146, name: "Abomination (Emil Blonsky)", description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.", title: "", thumbnail: foto2, resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146")
            
            let data = DataMarvel(offset: 0, limit: 0, total: 2, count: 2, results: [char1,char2])
            
            dataMarvel = MarvelModel(code: 200, status: "success", copyright: "2020", attributionText: "", attributionHTML: "", etag: "", data: data)
            self.estado = Estados.loading
        }
    }
    
    func getTestHero() -> records{
        let foto2 = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", thumbnailExtension: Extension.jpg)
        let char2 = records(id: 1009146, name: "Abomination (Emil Blonsky)", description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.", title: "", thumbnail: foto2, resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146")

        return char2
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
    
    // Load Data from Marvel Api Rest
    func loadMarvelData(){
        
        self.estado = Estados.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionMarvelCharacters())
            .tryMap (tryMapClosure(statusCode: 200))
            .decode(type: MarvelModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR load marvel datra: \(error)")
                    self.estado = Estados.error
                case .finished:
                    print("finish Load Marvel data")
                    self.estado = Estados.loaded
                }
            } receiveValue: { data in
                self.dataMarvel = data
               
            }
            .store(in: &subscribers)
    }
    
}


