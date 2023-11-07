import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct TOKEN_Data_OfUser: Identifiable, Hashable {
  var id = UUID()
  var name: String
  var imgIcon: String

  
}



//======STRUCT=======//
public struct ListOfTokenBelongNetworkView: View {
    
    @Binding var isBack:Bool
  
    
    let arr_TokenofThisNetwork = [
        TOKEN_Data_OfUser(name: "Binance USD", imgIcon: "BUSD"),
        TOKEN_Data_OfUser(name: "USD Coin", imgIcon: "USDC"),
        TOKEN_Data_OfUser(name: "Tether", imgIcon: "USDT")
        
        ]
    
    //======BODY====///
    public var body: some View{
        ScrollView{
            VStack{
                ForEach(self.arr_TokenofThisNetwork, id: \.self)
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
                        Text("0")
                            .font(.custom("Arial", size: 12))
                            .padding(12)
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
