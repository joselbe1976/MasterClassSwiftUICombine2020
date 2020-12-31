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
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .frame(width: 90 , height: 120)
                    .padding()
            }
            else{
                Image(systemName: "photo")
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .frame(width: 90 , height: 120)
                    .foregroundColor(.gray)
                // call to download
                let _ = self.viewModel.loadImage(urlString: self.hero.thumbnail.getURLDownloadImage())
            }
            Text("\(hero.name!)")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .bold()
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.4))
        )
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: MarvelHerosViewModel(testData: true).getTestHero()) //inyecto un modelo
        let _ =  PhotoViewModel().loadImage(urlString: MarvelHerosViewModel(testData: true).getTestHero().thumbnail.getURLDownloadImage())
        
    }
}
