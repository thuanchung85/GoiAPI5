import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct SendCoinView: View {
    @Binding var isBack:Bool
    @State var isShowSheet_RecipientList = false
    
    //biến input địa chỉ ví người nhận
    @State var recipientWalletAddress:String = ""
    @State var CoinSymbol = ""
    @State var currentNetWork_name = ""
    @State var amountCoinWantToSend:String = ""
    @State var currentBalanceCoinsOfThisAddress = ""
    
    //biến show sheet người dùng chọn coin khác
    @State var isShowSheet_PickOtherCoinForSend = false
    
    //===INIT====//
    public init(isBack:Binding<Bool>,CoinSymbol:String, currentNetWork_name:String, currentBalanceCoinsOfThisAddress:String) {
        self.CoinSymbol = CoinSymbol
        self.currentNetWork_name = currentNetWork_name
        self.currentBalanceCoinsOfThisAddress = currentBalanceCoinsOfThisAddress
        self._isBack = isBack
    }
    
    //====BODY===/
    public var body: some View{
        VStack{
            VStack(){
                //khu title và nut back
                HStack{
                    ZStack{
                        //nut thoat khoi view này
                        HStack{
                            Button(action: {
                                self.isBack = false
                            }) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.green)
                            }
                            Spacer()
                        }
                        
                        //tiêu đề
                        HStack{
                            Spacer()
                            Text("Send Coin")
                                .font(.custom("Arial Bold", size: 20))
                                .padding(.top,10)
                            Spacer()
                        }
                    }
                }
                .padding()
                
               
                
            }//end Vstack
            HStack{
                VStack(alignment: .leading){
                    Text("To:")
                        .font(.custom("Arial Bold", size: 15))
                        .padding(.top,15)
                        .padding(.horizontal,20)
                    TextField("Enter wallet address", text: self.$recipientWalletAddress)
                        .multilineTextAlignment(.center)
                        .scaledToFit()
                        .minimumScaleFactor(0.02)
                        .frame(height: 60)
                        .foregroundColor(Color.black)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.horizontal], 20)
                    //nút vào recipient list
                     Button(action: {
                         print("open recipient list")
                         self.isShowSheet_RecipientList = true
                     }) {
                         HStack{
                             Text("Recipient list")
                                 .foregroundColor(Color.white)
                                 .font(.custom("Arial", size: 20))
                                 .padding(.horizontal,5)
                         }
                         .frame(maxWidth: .infinity, minHeight: 30 ,maxHeight: 50)
                         .background(Color.green)
                         .cornerRadius(10)
                         .padding(.horizontal,20)
                         
                     }
                     .padding(5)
                }
            }
          Spacer()
            HStack{
                VStack{
                    HStack{
                        Text(self.CoinSymbol)
                            .font(.body)
                    }
                    HStack{
                        TextField("0", text: self.$amountCoinWantToSend)
                            .keyboardType(.numberPad)
                            .font(.custom("Arial Bold", size: 40))
                            .scaledToFill()
                            .minimumScaleFactor(0.02)
                            .multilineTextAlignment(.center)
                            .frame(height: 60)
                            .foregroundColor(Color.black)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding([.horizontal], 4)
                            .cornerRadius(10)
                            //.overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1)))
                            .padding([.horizontal], 20)
                    }
                    HStack{
                        //nút copy address
                         Button(action: {
                             print("get max coin in wallet")
                           
                         }) {
                             HStack{
                                 Text("Max")
                                     .foregroundColor(Color.green)
                                     .font(.custom("Arial", size: 20))
                                     .padding(.horizontal,5)
                             }
                             .frame(width: 60 ,height: 60)
                             .background(Color(hex: 0xFFD6AD))
                             .cornerRadius(30)
                             .padding(.horizontal,20)
                             
                         }
                    }
                }
            }
            Spacer()
            
            //khu hiện trong ví user có bao nhieu coin thuộc loai này
            HStack{
               
                Image(return_CoinSymbol_Image_By_NetworkName(currentNetWork_name: self.currentNetWork_name)[0])
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                Text(return_CoinSymbol_Image_By_NetworkName(currentNetWork_name: self.currentNetWork_name)[1])
                    .font(.body)
                Spacer()
                Text(self.currentBalanceCoinsOfThisAddress)
                    .font(.body)
                    .padding(.trailing,20)
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(25)
            .padding(.horizontal,20)
            .onTapGesture(perform: {
                print("gọi sheet để user chọn coin khác:")
                self.isShowSheet_PickOtherCoinForSend = true
            })
            
            
            
            Spacer()
            //nút copy address
            if(Int(self.amountCoinWantToSend) ?? 0 > 0) && (self.amountCoinWantToSend <= self.currentBalanceCoinsOfThisAddress){
                Button(action: {
                    print("NEXT send COIN")
                    
                }) {
                    HStack{
                        Text("NEXT")
                            .foregroundColor(Color.white)
                            .font(.custom("Arial", size: 20))
                            .padding(.horizontal,5)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60 ,maxHeight: 60)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal,20)
                    
                }
                .padding(20)
            }
        }
        
        //show sheet về các địa chỉ ví khác đã lưu
        .sheet(isPresented: $isShowSheet_RecipientList,
                content: {
            RecipientWalletListView(isBack: $isShowSheet_RecipientList, recipientWalletAddress: $recipientWalletAddress
                                    )
           
         })//end sheet
        
        //show sheet về các các đồng coin khác user đang có
        .sheet(isPresented: self.$isShowSheet_PickOtherCoinForSend,
               content: {
            
            ListOfTokenBelongNetworkView(isBack: self.$isShowSheet_PickOtherCoinForSend)
                
        })//end sheet
        
    }//end body
}//end struct






func return_CoinSymbol_Image_By_NetworkName(currentNetWork_name:String) ->[String]
{
    var currentCoinSymbol:String = ""
    var currentCoinName:String = ""
    switch(currentNetWork_name)
    {
    case "BSC":
        currentCoinSymbol = "BSC"
        currentCoinName = "BNB"
    case "BSC Testnest":
        currentCoinSymbol="BSC"
        currentCoinName = "TBNB"
    case "Goerli Testnet":
        currentCoinSymbol="Ethereum"
        currentCoinName = "ETH"
    case "Ethereum":
        currentCoinSymbol="Ethereum"
        currentCoinName = "ETH"
    case "Polygon":
        currentCoinSymbol="Polygon"
        currentCoinName = "MATIC"
    case "Pools":
        currentCoinSymbol="Pools"
        currentCoinName = "Pools"
    case "Pools Testnest":
        currentCoinSymbol="Pools"
        currentCoinName = "Pools"
    case "Fantom":
        currentCoinSymbol="Fantom"
        currentCoinName = "FTM"
    case "Avalanche":
        currentCoinSymbol="Avalanche"
        currentCoinName = "AVAX"
    case "Cronos":
        currentCoinSymbol="Cronos"
        currentCoinName = "CRO"
    case "Arbitrum":
        currentCoinSymbol="Arbitrum"
        currentCoinName = "ARB"
    default:
        currentCoinSymbol="Pools"
        currentCoinName = "Pools"
    }
    return [currentCoinSymbol,currentCoinName]
}




extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
