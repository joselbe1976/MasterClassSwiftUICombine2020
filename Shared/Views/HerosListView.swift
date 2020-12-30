//
//  CharectersListView.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import SwiftUI

struct HerosListView: View {
    @EnvironmentObject var viewModel : MarvelHerosViewModel
    
    var body: some View {
        NavigationView{
            List{
                ForEach((self.viewModel.dataMarvel?.data?.results!)! ,id:\.self){ hero in
                   /* Añadir log desde SwiftUI
                        let _ = print(hero.thumbnail.getURLDownloadImage())
                      */
                    NavigationLink(
                        destination: DetailHeroView(hero: hero),
                        label: {
                            HeroRowView(hero: hero)
                        })
                }
            }
            .navigationBarTitle("Heros Marvel")
        }
        
    }
}

struct CharectersListView_Previews: PreviewProvider {
    static var previews: some View {
        HerosListView()
            .environmentObject(MarvelHerosViewModel(testData: true))
    }
}
