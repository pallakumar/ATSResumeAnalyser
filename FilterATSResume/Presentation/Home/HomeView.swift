//
//  FilterATSResumeApp.swift
//  HomeView
//
//  Created by Lakshmi Kumar on 29/05/26.
//

import SwiftUI
import UniformTypeIdentifiers

struct HomeView: View {

    @StateObject private var viewModel = ResumeViewModel()
    @State private var showPicker = false

    var body: some View {

        NavigationView {

            ZStack {

                LinearGradient(
                    colors: [
                        Color.blue,
                        Color.purple
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 25) {

                        // Header
                        VStack(spacing: 10) {

                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.system(size: 65))
                                .foregroundColor(.white)

                            Text("ATS Resume Analyzer")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)

                            Text("Optimize your resume for recruiters")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.top, 30)
                        

                        // ATS Score Card
                        VStack(spacing: 15) {

                            Text("ATS SCORE")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            ZStack {

                                Circle()
                                    .stroke(
                                        Color.gray.opacity(0.2),
                                        lineWidth: 12
                                    )

                                Circle()
                                    .trim(
                                        from: 0,
                                        to: CGFloat(viewModel.atsScore) / 100
                                    )
                                    .stroke(
                                        Color.green,
                                        style: StrokeStyle(
                                            lineWidth: 12,
                                            lineCap: .round
                                        )
                                    )
                                    .rotationEffect(.degrees(-90))

                                VStack {

                                    Text("\(viewModel.atsScore)")
                                        .font(.system(size: 38, weight: .bold))

                                    Text("%")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .frame(width: 150, height: 150)
                        }
                        .padding(25)
                        .frame(maxWidth: 250)
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(
                            color: .black.opacity(0.1),
                            radius: 10,
                            x: 0,
                            y: 5
                        )

                        // Upload Button
                        Button {

                            showPicker = true

                        } label: {

                            HStack(spacing: 10) {

                                Image(systemName: "arrow.up.doc.fill")

                                Text("Upload Resume")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [
                                        .green,
                                        .blue
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                        .frame(maxWidth: 250)


                        // Suggestions
                        VStack(alignment: .leading, spacing: 15) {

                            HStack {

                                Image(systemName: "sparkles")
                                    .foregroundColor(.yellow)

                                Text("AI Suggestions")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                            }

                            ForEach(viewModel.suggestions, id: \.self) { suggestion in

                                HStack(alignment: .top, spacing: 12) {

                                    Image(systemName: "lightbulb.fill")
                                        .foregroundColor(.orange)

                                    Text(suggestion)

                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(
                                    color: .black.opacity(0.08),
                                    radius: 4
                                )
                            }
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.top, 0)
                }
            }
            .navigationBarHidden(true)
        }
        .fileImporter(
            isPresented: $showPicker,
            allowedContentTypes: [.pdf]
        ) { result in

            switch result {

            case .success(let url):
                viewModel.uploadPDF(url)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



