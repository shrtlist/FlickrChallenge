//
//  ImageDetailView.swift
//  FlickrChallenge
//
//  Created by Marco Abundo on 11/20/24.
//

import SwiftUI

struct ImageDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let image: FlickrImage

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Display the image
                    AsyncImage(url: URL(string: image.media.m)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        default:
                            ProgressView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Display the title
                    Text(image.title.isEmpty ? "Untitled" : image.title)
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    // Render the description as styled text
                    if let attributedDescription = htmlToAttributedString(image.description) {
                        Text(attributedDescription)
                            .font(.body)
                    } else {
                        Text("No description available.")
                            .font(.body)
                    }
                    
                    // Display the author
                    Text("Author:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(image.author)
                    
                    // Display the formatted published date
                    Text("Published:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(formatPublishedDate(image.dateTaken))
                        .font(.body)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Image Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    /// Converts an HTML string to an `AttributedString`
        private func htmlToAttributedString(_ html: String) -> AttributedString? {
            guard let data = html.data(using: .utf8) else { return nil }

            do {
                let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)

                return AttributedString(attributedString)
            } catch {
                print("Failed to convert HTML to AttributedString: \(error)")
                return nil
            }
        }

    /// Formats the published date string
    private func formatPublishedDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}
