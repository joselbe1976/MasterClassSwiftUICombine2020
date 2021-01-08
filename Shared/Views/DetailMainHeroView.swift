//
//  DetailMainHeroView.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 31/12/20.
//

import SwiftUI

struct DetailMainHeroView: View {
    @StateObject private var viewModelPhoto = PhotoViewModel()
    var serie : records
    
    // tamaños por tipo dispositivo del frame de la imafen
    #if os(tvOS)
        var width : CGFloat = 600
        var height : CGFloat = 400
    
    #else
        var width : CGFloat = .infinity
        var height : CGFloat = .infinity
    #endif
    
    var body: some View {
        VStack{
            ZStack{
                // Image Serie
               if let foto = viewModelPhoto.photo {
                        foto
                        .resizable()
                        .opacity(0.3)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
               }
               else{
                    Image(systemName: "photo")
                        .resizable()
                        .opacity(0.3)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
                
                    // Call  foto Download
                   let _ = viewModelPhoto.loadImage(urlString: serie.thumbnail.getURLDownloadImage())
               }
                
                // Tittle Serie
                Text("\(serie.title!)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .bold()
           } // Zstacks
            if let descrip = serie.description {
                    Text("\(descrip)")
                         .foregroundColor(Color.gray)
                         .font(.body)
                     
            }else{
                    Text("No desciption")
                        .foregroundColor(Color.gray)
                        .font(.body)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.4))
        )
    }
}

struct DetailMainHeroView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMainHeroView(serie: MarvelSeriesHeroViewModel().getTestSerie())
    }
}
