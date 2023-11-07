import Foundation
import SwiftUI
import AVKit

public struct RecipientWalletListView: View {
    @Binding var isBack:Bool
    @State var searchText:String = ""
    
    
    @State var ListOfRecipientWalletAddress : [RecipientWalletItem] = []
    
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
                                .frame(width: 120, height: 120)
                            Text( "\(item.walletname)")
                                .font(.custom("Arial Bold", size: 20))
                                .foregroundColor(Color.black)
                                .padding(5)
                        }
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




//=========================//

import Foundation
import CoreData


struct RecipientWalletItem: Identifiable {
    var id = UUID()
    var imgAvata:String? = ""
    var walletname: String = ""
    var walletAddress: String = ""
}


//==THANH SEARCH BAR===///
struct SearchBar: View {
    @Binding var text: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
