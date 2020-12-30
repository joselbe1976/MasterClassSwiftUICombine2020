//
//  ContentView.swift
//  Shared
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 28/12/20.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel : MarvelHerosViewModel
    
    var body: some View {
        
        switch self.viewModel.estado {
            case Estados.none:
                Text("Estado none")
            case Estados.error:
                Text("Error. Revise las credenciales")
                    .bold()
                    .foregroundColor(.red)
            case Estados.loaded:
                HerosListView() // lista Heros
            case Estados.loading:
                LoadingView()
            }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MarvelHerosViewModel(testData: true))
    }
}
