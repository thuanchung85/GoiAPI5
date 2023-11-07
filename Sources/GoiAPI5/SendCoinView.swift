import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct SendCoinView: View {
    
    @State var isShowSheet_RecipientList = false
    
    public var body: some View{
        VStack{
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
        }
        
        //show sheet về các địa chỉ ví khác đã lưu
        .sheet(isPresented: $isShowSheet_RecipientList,
                content: {
           RecipientWalletListView(isBack: $isShowSheet_RecipientList)
           
         })//end sheet
    }//end body
}//end struct
