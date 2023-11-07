import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct SendCoinView: View {
    @Binding var isBack:Bool
    @State var isShowSheet_RecipientList = false
    
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
                                .font(.custom("Arial ", size: 20))
                                .padding(.top,10)
                            Spacer()
                        }
                    }
                }
                .padding()
                
               
                
            }//end Vstack
            
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
