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
    
    //===INIT====//
    public init(isBack:Binding<Bool>) {
       
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
                VStack{
                    Text("To:")
                        .font(.custom("Arial Bold", size: 15))
                        .padding(.top,15)
                        .padding(.horizontal,20)
                    TextField("Enter wallet address", text: self.$recipientWalletAddress)
                        .frame(height: 60)
                        .foregroundColor(Color.black)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.horizontal], 20)
                       
                }
            }
            Spacer()
            HStack{
                VStack{
                    HStack{
                        Text("BTC")
                            .font(.body)
                    }
                    HStack{
                        Text("0000000")
                            .font(.title)
                    }
                    HStack{
                        //nút copy address
                         Button(action: {
                             print("get max coin in wallet")
                           
                         }) {
                             HStack{
                                 Text("Max")
                                     .foregroundColor(Color.white)
                                     .font(.custom("Arial", size: 20))
                                     .padding(.horizontal,5)
                             }
                             .frame(maxWidth: .infinity, minHeight: 60 ,maxHeight: 60)
                             .background(Color.green)
                             .cornerRadius(30)
                             .padding(.horizontal,20)
                             
                         }
                    }
                }
            }
            
            HStack{
                Image("Account")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                Text("BTC")
                    .font(.body)
                Spacer()
                Text("00")
                    .font(.body)
            }
            Spacer()
            //nút copy address
             Button(action: {
                 print("open recipient list")
                 self.isShowSheet_RecipientList = true
             }) {
                 HStack{
                     Text("Open recipient list")
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
        
        //show sheet về các địa chỉ ví khác đã lưu
        .sheet(isPresented: $isShowSheet_RecipientList,
                content: {
           RecipientWalletListView(isBack: $isShowSheet_RecipientList)
           
         })//end sheet
    }//end body
}//end struct
