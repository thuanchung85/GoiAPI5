//
//  File.swift
//  GoiAPI2
//
//  Created by SWEET HOME (^0^)!!! on 20/10/2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct QRCodeMakerView_ForReceiveCoin: View {
   
    @State var currentWalletAddress:String = ""
    @State var currentWalletName:String = ""
    
     var width:CGFloat?
     var height:CGFloat?
    
    public init(width:CGFloat,  height:CGFloat) {
       
        self.width = width
        self.height = height
       
    }
    
    public var body: some View{
        NavigationView{
         
            VStack() {
                Text(self.currentWalletName )
                    .font(.title)
                
                Image(uiImage: generateQRCode(from: self.currentWalletAddress))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("Wallet address: ")
                    .font(.title)
                Text(currentWalletAddress)
                    .font(.footnote)
                
               //nút copy address
                Button(action: {
                    print("Copy Button was tapped save to clipbroad")
                    UIPasteboard.general.setValue(currentWalletAddress ,forPasteboardType: UTType.plainText.identifier)
                }) {
                    HStack{
                        Text("Copy")
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
           
        }
    }
    
    
    func generateQRCode(from string:String)-> UIImage{
         let context = CIContext()
         let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage{
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}//end struct

