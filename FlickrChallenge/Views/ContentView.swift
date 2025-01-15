//
//  ContentView.swift
//  FlickrChallenge
//
//  Created by Marco Abundo on 11/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    @State private var selectedImage: FlickrImage? = nil
    private let size = 100.0

    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.images.isEmpty {
                    ContentUnavailableView.init("No results", systemImage: "photo.circle")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.images) { image in
                                AsyncImage(url: URL(string: image.media.m)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                    default:
                                        ProgressView()
                                            .scaleEffect(2.0, anchor: .center)
                                    }
                                }
                                .frame(width: size, height: size)
                                .onTapGesture {
                                    selectedImage = image
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Flickr Search")
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .sheet(item: $selectedImage) { image in
                ImageDetailView(image: image)
            }
        }
    }
}

#Preview {
    ContentView()
}
