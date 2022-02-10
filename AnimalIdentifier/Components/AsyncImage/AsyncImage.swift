//
//  AsyncImage.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 02.02.2022.
//

import SwiftUI

struct AsyncImage: View {
    @StateObject private var viewModel: AsyncImageViewModel
    
    init(viewModel: AsyncImageViewModel) {
        _viewModel =  StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
        }
    }
}
