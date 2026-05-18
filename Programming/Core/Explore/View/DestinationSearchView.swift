//
//  DestinationSearchView.swift
//  Programming
//
//  Created by Bobur Sobirjanov on 5/16/26.
//

import SwiftUI

enum DestinationSearchOptions {
    case location
    case dates
    case guestes
}

struct DestinationSearchView: View{
    
    @Binding var show: Bool
    @StateObject var vm: ExploreViewModel
    @State private var selectedOption: DestinationSearchOptions = .location
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var numGuestes = 0
    
    
    var body: some View{
        VStack{
            
            HStack{
                Button{
                    withAnimation(.snappy){
                        vm.updatedListingForLocation()
                        
                        show.toggle()
                    }
                } label:  {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                if !vm.searchLocation.isEmpty{
                    Button("Clear"){
                        vm.searchLocation = ""
                        vm.updatedListingForLocation()
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .padding()
            
            
            VStack(alignment: .leading){
                if selectedOption == .location {
                    Text("Where to? ")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .imageScale(.small)
                        
                        TextField("Search Destinations", text: $vm.searchLocation)
                            .font(.subheadline)
                            .onSubmit {
                                vm.updatedListingForLocation()
                                show.toggle()
                            }
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color(.systemGray4))
                    }
                } else {
                  CollapsedPickerView(title: "Where", description: "Add destination")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .location ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy){
                    selectedOption = .location
                }
            }
            
            // date selection view
                
            VStack(alignment: .leading){
                if selectedOption == .dates {
                    Text("When's your trip?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    VStack{
                        DatePicker("From", selection: $startDate, displayedComponents: .date)
                        
                        Divider()
                        
                        DatePicker("To", selection: $endDate, displayedComponents: .date)
                    }
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                } else {
                    CollapsedPickerView(title: "When", description: "Add Dates")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .dates ? 180 : 64)
            .onTapGesture {
                withAnimation(.snappy){
                    selectedOption = .dates
                }
            }
            
            // num guest view
            
            VStack{
                if selectedOption == .guestes {
                    
                    Text("Who's coming?")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Stepper{
                        Text("\(numGuestes) Adults")
                    } onIncrement: {
                        numGuestes += 1
                    } onDecrement: {
                        guard numGuestes > 0 else {return}
                        numGuestes -= 1
                    }
                        

                } else {
                    CollapsedPickerView(title: "Who", description: "Add Guests")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .guestes ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy){
                    selectedOption = .guestes
                }
            }

        }
        
        Spacer()
    }
}


#Preview {
    DestinationSearchView(show: .constant(false),
                          vm: ExploreViewModel(service: ExploreService()))
}

struct CollapsibleDestinationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
    }
}


struct CollapsedPickerView: View{
    
    let title: String
    let description: String
    var body: some View{
        VStack{
            HStack{
                Text(title)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(description)
            }
            .fontWeight(.semibold)
            .font(.subheadline)
        }
    }
}
