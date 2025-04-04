//
//  ContentView.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var stateManager: AppStateManager
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    
    
    var body: some View {
        NavigationView{
            VStack{
                Image("Logo")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 70, height: 70, alignment: .center)
                  .padding()
                VStack{
                    if texts.count > 0{
                        List{
                            ForEach(texts){text in
                                NavigationLink(
                                    destination:
                                        ScrollView{
                                            Text(text.content)
                                            NavigationLink(destination:
                                                            SecondUIView(temptext:self.$texts)
                                            ){
                                            Text("Download")
                                                .padding()
                                                .frame(width: 120, height: 120, alignment: .center)
                                                .background(Color.black)
                                                .cornerRadius(150)
                                            }
                                        }
                                        .navigationViewStyle(.stack)
                                        .navigationBarTitle("INKredible",displayMode: .inline)
                                    ,
                                    label: {
                                        Text(text.content).lineLimit(1)
                                    })
                            }
                        }
                    }
                    else{
                        Text("No scans yet").font(.title)
                    }
                }
                .navigationTitle("INKredible")
                    .navigationBarItems(trailing:
                                            Button(action: {
                        self.showScannerSheet = true
                    }, label: {
                                Text("SCAN")
                                Image(systemName: "doc.text.viewfinder")
                            .font(.title)
                    }).sheet(isPresented: $showScannerSheet, content: {
                            makeScannerView()
                    })
                    )
                VStack{
                    NavigationLink(destination: Donations()){
                    Text("Donate")
                        .padding()
                        .frame(width: 120, height: 120, alignment: .center)
                        .background(Color.black)
                        .cornerRadius(150)
                    }
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarTitle("INKredible",displayMode: .inline)
            }
            //.blur(radius: stateManager.showBlur ? 100 : 0)
            .navigationTitle("INKredible")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showScannerSheet = true
            }, label: {
                        Text("SCAN")
                        Image(systemName: "doc.text.viewfinder")
                    .font(.title)
            }).sheet(isPresented: $showScannerSheet, content: {
                    makeScannerView()
            })
            )
    }
    
     private func makeScannerView()-> ScannerView{
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stateManager: AppStateManager.shared)
    }
}
