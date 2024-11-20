//
//  FlickrViewModel.swift
//  FlickrChallenge
//
//  Created by Marco Abundo on 11/20/24.
//

import Foundation
import Combine

class FlickrViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchQuery: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard !query.isEmpty else {
                    self?.images = []
                    return
                }
                self?.fetchImages(for: query)
            }
            .store(in: &cancellables)
    }

    func fetchImages(for query: String) {
        let tags = query.replacingOccurrences(of: ",", with: "%2C")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)"

        guard let url = URL(string: urlString) else { return }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: FlickrResponse.self, decoder: decoder)
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$images)
    }
}
