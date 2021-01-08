//
//  HeroRowView.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import SwiftUI

struct HeroRowView: View {
    var hero : records // modelo del heroe
    
    
    var body: some View {
        #if os(tvOS)
            HeroRowVuewtvOs(hero: hero)
        #else
            HeroRowVuewIOSMac(hero: hero)
        #endif
        

    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroRowView(hero: MarvelHerosViewModel(testData: true).getTestHero())
           
        } //inyecto un modelo
        let _ =  PhotoViewModel().loadImage(urlString: MarvelHerosViewModel(testData: true).getTestHero().thumbnail.getURLDownloadImage())
        
    }
}



struct HeroRowVuewtvOs: View {
    // tamaños por tipo dispositivo del frame de la imafen
    
    var width : CGFloat = 200
    var height : CGFloat = 200
    
    
    @StateObject var viewModel = PhotoViewModel()
    var hero : records
    
    var body: some View {
        HStack{
            
            if let foto = viewModel.photo {
                foto
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .padding()
                
            }
            else{
                Image(systemName: "photo")
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .frame(width: width, height: height)
                    .foregroundColor(.gray)
                // call to download
                let _ = self.viewModel.loadImage(urlString: self.hero.thumbnail.getURLDownloadImage(type: photoType.landscape))
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



struct HeroRowVuewIOSMac: View {
    // tamaños por tipo dispositivo del frame de la imafen

    var width : CGFloat = .infinity
   var height : CGFloat = .infinity
    
    @StateObject var viewModel = PhotoViewModel()
    var hero : records
    
    var body: some View {
        VStack{
            
            if let foto = viewModel.photo {
                foto
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .padding()
                
            }
            else{
                Image(systemName: "photo")
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .foregroundColor(.gray)
                // call to download
                let _ = self.viewModel.loadImage(urlString: self.hero.thumbnail.getURLDownloadImage(type: photoType.landscape))
            }
            Text("\(hero.name!)")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .bold()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.4))
        )
        
    }
}
