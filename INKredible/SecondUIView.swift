//
//  SecondUIView.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import SwiftUI

struct SecondUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var temptext : [ScanData]
    
    
    @State private var Index: Int = 0
    
    @State private var selection = "PDF(.pdf)"
        let format = ["PDF(.pdf)", "Text(.txt)", "MarkDown(.md)"]
    
    var body: some View {
        //ScrollView{
        VStack{
            Image("Logo")
              .resizable()
              .scaledToFit()
              .frame(width: 70, height: 70, alignment: .center)
            
            Text("Choose the File Format: ")
                .padding()
                //.frame(width: 300, height: 500, alignment: .center)
                .background(Color.white)
                .foregroundColor(Color.black)
            
            HStack{
            Text("Select a Format")
                    .padding()
                    .frame(width: 100, height: 100, alignment: .center)
            
            Picker("File Format: ", selection: $selection) {
                                ForEach(format, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
            }.padding()
            
            List{
                ForEach(temptext){text in
                            ScrollView{
                                Text(text.content)
                            }
                }
            }.padding()
            
            VStack{
            Text("Please provide the correct index of the file(within the range of number of files available)!")
            }
            
            HStack{
            Text("Index(starting from 1)")
                .font(.callout)
                .bold()
            TextField("Index of file", text: Binding(
                get: { String(Index) },
                set: { Index = Int($0) ?? 0 }
            )).border(Color.black)
            }.padding()
            
            if(selection == "PDF(.pdf)") {
                Button(action: createPdf){
                    Text("DOWNLOAD")
                }
                .padding(10)
                .frame(width: 120, height: 120, alignment: .center)
                .background(Color.green)
                .cornerRadius(150)
                .foregroundColor(Color.white)
            }
            else if(selection == "Text(.txt)") {
                Button(action: createText){
                    Text("DOWNLOAD")
                }
                .padding(10)
                .frame(width: 120, height: 120, alignment: .center)
                .background(Color.green)
                .cornerRadius(150)
                .foregroundColor(Color.white)
            }
            else if(selection == "MarkDown(.md)") {
                Button(action: createMd){
                    Text("DOWNLOAD")
                }
                .padding(10)
                .frame(width: 120, height: 120, alignment: .center)
                .background(Color.green)
                .cornerRadius(150)
                .foregroundColor(Color.white)
            }
            
            
            Button("BACK"){
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .navigationBarTitle("INKredible",displayMode: .inline)
        .navigationViewStyle(.stack)
    }
    
    func createPdf() {

            let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("MyPDFFile.pdf")
            let title = "\n"
            
            let text = String(temptext[Index-1].content)
            /*let text = String(repeating: "Your string row from List View or ScrollView \n ", count: 2000)*/

            let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
            let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]

            let formattedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
            let formattedText = NSAttributedString(string: text, attributes: textAttributes)
            formattedTitle.append(formattedText)

            // 1. Create Print Formatter with your text.

            let formatter = UISimpleTextPrintFormatter(attributedText: formattedTitle)

            // 2. Add formatter with pageRender

            let render = UIPrintPageRenderer()
            render.addPrintFormatter(formatter, startingAtPageAt: 0)

            // 3. Assign paperRect and printableRect

            let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
            let printable = page.insetBy(dx: 0, dy: 0)

            render.setValue(NSValue(cgRect: page), forKey: "paperRect")
            render.setValue(NSValue(cgRect: printable), forKey: "printableRect")

            // 4. Create PDF context and draw
            let rect = CGRect.zero

            let pdfData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, rect, nil)

            for i in 1...render.numberOfPages {

                UIGraphicsBeginPDFPage();
                let bounds = UIGraphicsGetPDFContextBounds()
                render.drawPage(at: i - 1, in: bounds)
            }

            UIGraphicsEndPDFContext();

            // 5. Save PDF file

            do {
                try pdfData.write(to: outputFileURL, options: .atomic)
                    print("wrote PDF file with multiple pages to: \(outputFileURL.path)")
            } catch {
                    print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    
    func createText() {
        let file = "MyTextfile.txt" //this is the file. we will write to and read from it

        let text = String(temptext[Index-1].content)
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)

            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("Could not create Text file: \(error.localizedDescription)")
            }

        }
    }
    
    func createMd() {
        // Coming Soon
    }

}

struct SecondUIView_Previews: PreviewProvider {
    static var previews: some View {
        SecondUIView(temptext: .constant([]))
    }
}
