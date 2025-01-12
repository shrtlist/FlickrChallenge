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

    let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.images.isEmpty {
                    ContentUnavailableView.init("No results", systemImage: "photo.circle")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.images) { image in
                                AsyncImage(url: URL(string: image.media.m)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .onTapGesture {
                                    selectedImage = image
                                }
                            }
                        }
                        .padding()
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
