import Foundation
import SwiftUI
import AVKit

public struct RecipientWalletListView_NoReturnData: View {
    @Binding var isBack:Bool
    
   
    @State var searchText:String = ""
    
    
    @State var ListOfRecipientWalletAddress : [RecipientWalletItem] = []
    
    
    public init(isBack:Binding<Bool>) {
      
        self._isBack = isBack
    }
    //===BODY==//
    public var body: some View {
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
                        Text("Recipient List")
                            .font(.custom("Arial ", size: 20))
                            .padding(.top,10)
                        Spacer()
                    }
                }
            }
            .padding()
            
            SearchBar(text: $searchText)
                .padding(.vertical, 15)
            
            //list of recipent đã save trươc đó
            List(ListOfRecipientWalletAddress.filter({ searchText.isEmpty ? true : $0.walletname.contains(searchText) })) { item in
                HStack{
                    VStack{
                        HStack{
                            Image("Account")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                            Spacer()
                            Text( "\(item.walletname)")
                                .font(.custom("Arial Bold", size: 20))
                                .foregroundColor(Color.black)
                                .padding(5)
                        }.padding(.horizontal,10)
                        Text( "\(item.walletAddress)")
                            .font(.custom("Arial", size: 18))
                            .foregroundColor(Color.gray)
                            .padding(5)
                    }
                    .frame(width:350,height: 200)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.1), .green.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                        )
                    .cornerRadius(10)
                    .padding(.horizontal,15)
                }
                .padding(5)
                .onTapGesture(perform: {
                    print("CHỌN wallet address NAY active:")
                 
                    self.isBack = false
                })
            } .listRowBackground(Color.gray.opacity(0.1))
            
        }//end Vstack
        
        .onAppear(){
           let soluongRecipentSaved =  Int(UserDefaults.standard.string(forKey: "numberOfRecipientWallet") ?? "0")
            if soluongRecipentSaved != nil {
                if(soluongRecipentSaved! > 0){
                    for i in 1...(soluongRecipentSaved!){
                        let rg = UserDefaults.standard.string(forKey: "recipient\(i)") ?? "0"
                        let arr = rg.components(separatedBy: "+|Receiver@Wallet|+")
                        let newRecipient = RecipientWalletItem(walletname:arr[0],walletAddress:arr[1])
                        ListOfRecipientWalletAddress.append(newRecipient)
                    }
                    print(ListOfRecipientWalletAddress)
                }
            }
        }
    }//end body
}//end struct



