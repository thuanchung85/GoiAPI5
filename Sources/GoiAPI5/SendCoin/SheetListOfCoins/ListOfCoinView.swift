import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct Coin_Data_OfUser: Identifiable, Hashable {
  var id = UUID()
  var name: String
  var imgIcon: String
var currentBalanceOfCoin_for_Address: String? = "0"
    var CoinSymbol: String? = "..."
}



//======STRUCT=======//
public struct ListOfCoinView: View {
    
    @Binding var isBack:Bool
    
    let arr_OrtherNetwork = [
       Coin_Data_OfUser(name: "BSC", imgIcon: "BSC", CoinSymbol: "BNB"),
       Coin_Data_OfUser(name: "BSC Testnest", imgIcon: "BSC", CoinSymbol: "TBNB"),
       Coin_Data_OfUser(name: "Ethereum", imgIcon: "Ethereum", CoinSymbol: "ETH"),
       Coin_Data_OfUser(name: "Goerli Testnet", imgIcon: "Ethereum", CoinSymbol: "ETH"),
       Coin_Data_OfUser(name: "Polygon", imgIcon: "Polygon", CoinSymbol: "MATIC"),
       Coin_Data_OfUser(name: "Pools", imgIcon: "Pools", CoinSymbol: "Pools"),
       Coin_Data_OfUser(name: "Pools Testnest", imgIcon: "Pools", CoinSymbol: "Pools"),
       Coin_Data_OfUser(name: "Fantom", imgIcon: "Fantom", CoinSymbol: "FTM"),
       Coin_Data_OfUser(name: "Avalanche", imgIcon: "Avalanche", CoinSymbol: "AVAX"),
       Coin_Data_OfUser(name: "Cronos", imgIcon: "Cronos", CoinSymbol: "CRO"),
       Coin_Data_OfUser(name: "Arbitrum", imgIcon: "Arbitrum", CoinSymbol: "ARB")
        ]
    
    //======BODY====///
    public var body: some View{
        ScrollView{
            VStack{
                ForEach(self.arr_OrtherNetwork, id: \.self)
                { i in //section data
                    
                    HStack{
                        Image(i.imgIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .padding(15)
                        Text(i.name)
                            .font(.custom("Arial", size: 12))
                            .padding(12)
                        Spacer()
                    }
                    //khi user chọn network cu thể thì load số coin và quy ra tiền
                    .onTapGesture(perform: {
                        print(i.name)
                        self.isBack = false
                    })
                    .padding(.horizontal,15)
                    
                    
                    
                }
            }
        }
    }//end body
    
}//end struct
