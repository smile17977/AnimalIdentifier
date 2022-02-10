//
//  AnimalsView.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 01.02.2022.
//

import SwiftUI

struct AnimalsView: View {
    @StateObject var viewModel = AnimalsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.models) { image in
                    NavigationLink(
                        destination: AnimalCheckView(
                            viewModel: AnimalCheckViewModel(
                                imageVM: viewModel.getImageVM(for: image.src.large)
                            )
                        )
                    ) {
                        AsyncImage(
                            viewModel: viewModel.getImageVM(for: image.src.large)
                        )
                        .id(image.src.large)
                        .scaledToFill()
                    }
                }
                
                if !viewModel.models.isEmpty {
                    HStack {
                        Button(action: viewModel.loadNextPage) {
                            Text("load more?")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.primary)
                                .font(.body)
                                .padding()
                                .background(Capsule().foregroundColor(.gray))
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle(Text("Animals"))
        }
    }
}
