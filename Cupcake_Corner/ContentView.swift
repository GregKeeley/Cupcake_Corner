//
//  ContentView.swift
//  Cupcake_Corner
//
//  Created by Gregory Keeley on 9/18/20.
//

import Combine
import SwiftUI

class Order: ObservableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    static let types = ["Vanilla", "Choclate", "Strawberry", "Rainbow"] 
    var type = 0 { didSet { update() } }
    var quantity = 3 { didSet { update() } }
    var extraFrosting = false { didSet { update() } }
    var addSprinkles = false { didSet { update() } }
    func update() {
        didChange.send()
    }
    
}

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $order.type, label: Text("Select your cake type")) {
                        ForEach(0 ..< Order.types.count) {
                            Text(Order.types[$0]).tag($0)
                        }
                    }
                    Stepper(value:  $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.extraFrosting) {
                        Text("Add extra frosting")
                    }
                    Toggle(isOn: $order.addSprinkles, label: {
                        Text("Add extra sprinkles")
                    })
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
