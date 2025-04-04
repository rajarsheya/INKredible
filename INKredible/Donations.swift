//
//  Donations.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import SwiftUI

struct Donations: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("amount") var amount = ""
    
    var body: some View {
        
            ScrollView{
            VStack{
                Image("Logo")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100, height: 100, alignment: .center)
                  .padding()
                Text("Liked our Service? Please consider donation")
                .font(.largeTitle)
                .bold()
                .padding()
                HStack(alignment: .center) {
                    Text("Amount : $")
                    .font(.callout)
                    .bold()
                            TextField("Enter Amount...", text: $amount, onEditingChanged: { (changed) in
                                print("Username onEditingChanged - \(changed)")
                            }){
                                print("Username onCommit")
                            }
                            .foregroundColor(Color.blue)
                            .background(Color.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                }.padding()

                Text("Amount: $\(amount)").padding()
                HStack{
                    NavigationLink(destination: Payments(amount:self.$amount)){
                Text("ACCEPT")
                    .padding()
                    .frame(width: 100, height: 100, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(150)
                }.padding()
                
                Button("DENY"){
                        presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.red)
                .cornerRadius(150)
                }
            }
            .navigationBarTitle("INKredible",displayMode: .inline)
            .navigationViewStyle(.stack)
                
            }
    }
}

struct Donations_Previews: PreviewProvider {
    static var previews: some View {
        Donations()
    }
}
