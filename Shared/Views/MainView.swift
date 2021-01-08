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
                
                #if os(iOS) || os(watchOS) || os(tvOS)
                    HerosListView() // lista Heros
                #elseif os(OSX)
                    HerosListView() // lista Heros
                        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                #endif
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
