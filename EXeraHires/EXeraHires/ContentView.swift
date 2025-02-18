//
//  ContentView.swift
//  EXeraHires
//
//  Created by Arjun Sarkar on 2025-02-01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            JobsView()
                .tabItem {
                    Label("Jobs", systemImage: "briefcase.fill")
                }
                .tag(0)
            
            CandidatesView()
                .tabItem {
                    Label("Candidates", systemImage: "person.2.fill")
                }
                .tag(1)
            
            InterviewsView()
                .tabItem {
                    Label("Interviews", systemImage: "checkmark.circle.fill")
                }
                .tag(2)
            
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.bar.fill")
                }
                .tag(3)
        }
        .accentColor(colorScheme == .dark ? .mint : .blue)
    }
}

struct JobsView1: View {
    @State private var searchText = ""
    @State private var showingNewJobSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Active Jobs")) {
                    ForEach(0..<3) { _ in
                        JobRowView1()
                    }
                }
            }
            .navigationTitle("Jobs")
            .searchable(text: $searchText, prompt: "Search jobs...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingNewJobSheet.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct JobRowView1: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Senior iOS Developer")
                .font(.headline)
            Text("Engineering • San Francisco")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Label("12 candidates", systemImage: "person.fill")
                Spacer()
                Label("4.2 DEI Score", systemImage: "star.fill")
                    .foregroundColor(.green)
            }
            .font(.caption)
        }
        .padding(.vertical, 8)
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
