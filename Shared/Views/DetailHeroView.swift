//
//  DetailHeroView.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import SwiftUI
import Combine

struct DetailHeroView: View {
    @State var hero : records // modelo del heroe
    @StateObject var viewModelSeries = MarvelSeriesHeroViewModel()
    
    var body: some View {
        Group{
            switch viewModelSeries.estado {
            case Estados.none:
                VStack{
                    Text("Nada. Se lanza la carga")
                    let _ = viewModelSeries.loadMarvelDataSeries(idHero: hero.id)
                }
            case Estados.loading:
                LoadingView()
            case Estados.loaded:
                // Aqui pintamos la UI. LIsta de Series
                
                List{
                    ForEach((viewModelSeries.dataMarvel?.data?.results!)! ,id:\.self){ serieModel in
                        DetailMainHeroView(serie: serieModel)
                    }
                }
                .navigationBarTitle("Series of \(hero.name!)")
            
            case Estados.error:
                Text("Error al cargar")
                    .foregroundColor(.red)
                    .bold()
            }
        }
        .onReceive(viewModelSeries.$dataMarvel, perform: { data in
            //print("Recibidos los datos por Combine...: \(String(describing: data?.data?.results?.count))")
        })
    }
}

struct DetailHeroView_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeroView(hero: MarvelHerosViewModel(testData: true).getTestHero())
    }
}



// Detalle row de la Serie

struct DetailMainHeroView: View {
    @StateObject var viewModelPhoto = PhotoViewModel()
    var serie : records
    
    var body: some View {
       
                     VStack{
                        Text("\(serie.title!)")
                            .bold()
                            .padding()
                        
                        if let foto = viewModelPhoto.photo {
                            Image(uiImage: foto)
                                .resizable()
                                .frame(width: 200 , height: 200)
                                .padding()
                        }
                        else{
                            let _ = viewModelPhoto.loadImage(urlString: serie.thumbnail.getURLDownloadImage())
                        }
                        
                            
                        if let descrip = serie.description {
                                Text("\(descrip)")
                        }else{
                                Text("No desciption")
                        }
                        
                    }
 
    }
    
}

