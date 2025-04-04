//
//  Payments.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import SwiftUI
//import PassKit

//typealias PaymentCompletionHandler = (Bool) -> Void

struct Payments: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("fullname") var fullname = ""
    @AppStorage("Account Number") var acnumber = ""
    @AppStorage("Routing Number") var rnumber = ""
    
    @State private var selected = 1
    @State private var displayPopupMessage: Bool = false
    
    @Binding var amount: String
    
    var body: some View {
        
            ScrollView{
            VStack{
                Image("Logo")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100, height: 100, alignment: .center)
                Text("Choose Payment Options:")
                .font(.largeTitle)
                .bold()
                .padding()
                Picker(selection: $selected, label: Text("Payment Options:")) {
                                Text("Apple Pay").tag(1)
                                Text("PayPal").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                    
                /*HStack{
                        Text("PayPal")
                        Text("Apple Pay")
                }.padding()*/
                Group{
                HStack(alignment: .center) {
                            Text("Full Name")
                            .font(.callout)
                            .bold()
                            TextField("Enter Full Name...", text: $fullname, onEditingChanged: { (changed) in
                                print("Username onEditingChanged - \(changed)")
                            }){
                                print("Username onCommit")
                            }
                            .foregroundColor(Color.blue)
                            .background(Color.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                }.padding()
                HStack(alignment: .center) {
                    Text("Account Number")
                    .font(.callout)
                    .bold()
                            TextField("Enter Account Number...", text: $acnumber, onEditingChanged: { (changed) in
                                print("Username onEditingChanged - \(changed)")
                            }){
                                print("Username onCommit")
                            }
                            .foregroundColor(Color.blue)
                            .background(Color.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                }.padding()
                HStack(alignment: .center) {
                            Text("Routing Number")
                            .font(.callout)
                            .bold()
                            TextField("Enter Routing Number...", text: $rnumber, onEditingChanged: { (changed) in
                                print("Username onEditingChanged - \(changed)")
                            }){
                                print("Username onCommit")
                            }
                            .foregroundColor(Color.blue)
                            .background(Color.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                }.padding()
                Text("Your Full Name: \(fullname)").padding()
                Text("Your Account Number: \(acnumber)").padding()
                Text("Your Routing Number: \(rnumber)").padding()
                Text("Amount: $\(amount)").padding()
                }
                if (selected == 1) {
                        Button("PAY WITH  APPLE"){
                            displayPopupMessage = true
                        }
                        .padding(10)
                        .frame(width: 100, height: 100, alignment: .center)
                        .background(Color.green)
                        .cornerRadius(150)
                        .foregroundColor(Color.white)
                        .alert(isPresented: $displayPopupMessage){
                            Alert(
                                            title: Text("Coming Soon!"),
                                            message: Text("Payment functionality will come soon!")
                            )
                        }
                }
                else {
                        Button("PAY WITH PAYPAL"){
                            displayPopupMessage = true
                        }
                        .padding(10)
                        .frame(width: 100, height: 100, alignment: .center)
                        .background(Color.green)
                        .cornerRadius(150)
                        .foregroundColor(Color.white)
                        .alert(isPresented: $displayPopupMessage){
                            Alert(
                                title: Text("Coming Soon!"),
                                message: Text("Payment functionality will come soon!")
                            )
                        }
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
    }
}

struct Payments_Previews: PreviewProvider {
    static var previews: some View {
        Payments(amount: .constant(""))
    }
}

// APPLE PAY INTEGRATION
/*
class PaymentHandler: NSObject {

static let supportedNetworks: [PKPaymentNetwork] = [
    .amex,
    .masterCard,
    .visa
]

var paymentController: PKPaymentAuthorizationController?
var paymentSummaryItems = [PKPaymentSummaryItem]()
var paymentStatus = PKPaymentAuthorizationStatus.failure
var completionHandler: PaymentCompletionHandler?

func startPayment(completion: @escaping PaymentCompletionHandler) {

    let amount = PKPaymentSummaryItem(label: "Amount", amount: NSDecimalNumber(string: "8.88"), type: .final)
    let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "1.12"), type: .final)
    let total = PKPaymentSummaryItem(label: "ToTal", amount: NSDecimalNumber(string: "10.00"), type: .pending)

    paymentSummaryItems = [amount, tax, total];
    completionHandler = completion

    // Create our payment request
    let paymentRequest = PKPaymentRequest()
    paymentRequest.paymentSummaryItems = paymentSummaryItems
    paymentRequest.merchantIdentifier = "merchant.com.YOURDOMAIN.YOURAPPNAME"
    paymentRequest.merchantCapabilities = .capability3DS
    paymentRequest.countryCode = "US"
    paymentRequest.currencyCode = "USD"
    paymentRequest.requiredShippingContactFields = [.phoneNumber, .emailAddress]
    paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks

    // Display our payment request
    paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
    paymentController?.delegate = self
    paymentController?.present(completion: { (presented: Bool) in
        if presented {
            NSLog("Presented payment controller")
        } else {
            NSLog("Failed to present payment controller")
            self.completionHandler!(false)
         }
     })
  }
}

/*
    PKPaymentAuthorizationControllerDelegate conformance.
*/
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {

    // Perform some very basic validation on the provided contact information
    if payment.shippingContact?.emailAddress == nil || payment.shippingContact?.phoneNumber == nil {
        paymentStatus = .failure
    } else {
        // Here you would send the payment token to your server or payment provider to process
        // Once processed, return an appropriate status in the completion handler (success, failure, etc)
        paymentStatus = .success
    }

    completion(paymentStatus)
}

func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
    controller.dismiss {
        DispatchQueue.main.async {
            if self.paymentStatus == .success {
                self.completionHandler!(true)
            } else {
                self.completionHandler!(false)
            }
        }
    }
}

}
*/

// PAYPAL INTEGRATION
/*
 Enable the SDK :-
 Log into your PayPal Developer Dashboard.

 Select your app from the My Apps & Credentials page on the Developer Dashboard.

 Under Sandbox App Setting, select the Log in with PayPal checkbox.

 Step result
 The SDK is enabled.
 
 Add the SDK to your app :-
 https://github.com/paypal/paypalcheckout-ios.git
*/
/*
 func triggerPayPalCheckout() {
     Checkout.start(
         createOrder: { createOrderAction in

             let amount = PurchaseUnit.Amount(currencyCode: .usd, value: "10.00")
             let purchaseUnit = PurchaseUnit(amount: amount)
             let order = OrderRequest(intent: .capture, purchaseUnits: [purchaseUnit])

             createOrderAction.create(order: order)

         }, onApprove: { approval in

             approval.actions.capture { (response, error) in
                 print("Order successfully captured: \(response?.data)")
             }

         }, onCancel: {

             // Optionally use this closure to respond to the user canceling the paysheet

         }, onError: { error in

             // Optionally use this closure to respond to the user experiencing an error in
             // the payment experience

         }
     )
 }
 
 class CheckoutView: UIView, PaymentButtonDelegate {

     var payPalButton = PayPalButton()

     func configurePayPalButton() {
         payPalButton.delegate = self
     }

     func onButtonStart(_ button: PaymentButton) {
         // Invoked when the button is selected, before the checkout process begins.
     }

     func onButtonFinish(_ button: PaymentButton) {
         // Invoked when the checkout process has finished
     }

     func button(_ button: PaymentButton, changedEligibilityStatus status: PaymentButtonEligibilityStatus) {
         // Invoked when the eligibility status of the button has changed
     }
 }
 
 */
 
