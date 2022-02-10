//
//  AnimalCheckView.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 02.02.2022.
//

import SwiftUI

struct AnimalCheckView: View {
    @ObservedObject var viewModel: AnimalCheckViewModel
    
    var body: some View {
        ScrollView {
            viewModel.imageVM.image.map {
                Image(uiImage: $0)
                    .resizable()
                    .frame(maxHeight: 400)
            }
            
            viewModel.results.map { results in
                VStack {
                    ForEach(results, id: \.self) { result in
                        HStack {
                            Text(result.identifier)
                            
                            Spacer()
                            
                            value(for: result.confidence)
                        }
                        .font(.title2)
                        .foregroundColor(.primary)
                    }
                }
                .padding(.top)
            }
        }
        .padding(.horizontal)
        .onAppear(perform: viewModel.onAppear)
    }
    
    private func value(for confidence: Float) -> some View {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        let value = (confidence * 100)
    
        return Text("\(formatter.string(for: value) ?? "0") %")
    }
}
