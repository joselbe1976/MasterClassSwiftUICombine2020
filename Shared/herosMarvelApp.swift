//
//  herosMarvelApp.swift
//  Shared
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 28/12/20.
//

import SwiftUI

@main
struct herosMarvelApp: App {
    
    @StateObject var viewModel = MarvelHerosViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel) //inyectamos el viewmodel dentro del contectView
        }
    }
}
