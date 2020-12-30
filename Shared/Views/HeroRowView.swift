//
//  HeroRowView.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import SwiftUI

struct HeroRowView: View {
    var hero : records // modelo del heroe
    @StateObject var viewModel = PhotoViewModel()
    
    var body: some View {
        HStack{
            if let foto = viewModel.photo {
                Image(uiImage: foto)
                    .resizable()
                    .frame(width: 90 , height: 120)
                    .padding()
            }
            else{
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 90 , height: 120)
                    .padding()
                    .foregroundColor(.pink)
                // call to download
                let _ = self.viewModel.loadImage(urlString: self.hero.thumbnail.getURLDownloadImage())
            }
            VStack{
                Text("\(hero.name!)")
                    .foregroundColor(.black)
                    .bold()
                Text("\(hero.id)")
            }
            
        }
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: MarvelHerosViewModel(testData: true).getTestHero()) //inyecto un modelo
        let _ =  PhotoViewModel().loadImage(urlString: MarvelHerosViewModel(testData: true).getTestHero().thumbnail.getURLDownloadImage())
        
    }
}
