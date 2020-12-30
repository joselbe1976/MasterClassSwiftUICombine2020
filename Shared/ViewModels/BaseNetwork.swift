//
//  BaseNetwork.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import Foundation

let server = "https://gateway.marvel.com"
let apiKey = "22d302f0ef346d40da2a5b755e93818f"
let ts = "1"
let hash = "b2efe3602963e3578019bdad185e9366"
/*
 Informacion: https://developer.marvel.com/documentation/authorization
 el Hash = md5(ts+privateKey+publicKey)
 */

enum endpoints : String {
    case characters = "/v1/public/characters"
}


struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"
}

struct BaseNetwork {

    private func getURLEndPoint(endPoint:String, subpath:String = "") -> String {
        var urlCad = server
        urlCad += "\(endPoint)\(subpath)"
        urlCad += "?apikey=\(apiKey)"
        urlCad += "&ts=\(ts)"
        urlCad += "&hash=\(hash)"
        return urlCad
    }

    private func getCommonHeaders( request : URLRequest) -> URLRequest{
        var request = request // convert to mutable
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-Type")
        return (request)
    }
    
    // retturno a URL Request Object
    func getSessionMarvelCharacters() -> URLRequest {
        let urlCad = getURLEndPoint(endPoint: endpoints.characters.rawValue) + "&orderBy=-modified"
        let url = URL(string: urlCad)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = HTTPMethods.get
        request = self.getCommonHeaders(request: request) // Headers
        return (request)
    }
    
    func getSessionMarvelSeries(idHero:Int) -> URLRequest {
        let urlCad = getURLEndPoint(endPoint: endpoints.characters.rawValue, subpath: "/\(idHero)/series") + "&orderBy=-modified"
        print(urlCad)
        let url = URL(string: urlCad)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = HTTPMethods.get
        request = self.getCommonHeaders(request: request) // Headers
        return (request)
    }
   
    
}
