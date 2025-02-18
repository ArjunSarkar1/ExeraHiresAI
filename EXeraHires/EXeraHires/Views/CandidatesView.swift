import SwiftUI

struct CandidatesView: View {
    @State private var searchText = ""
    
    let pendingCandidates = [
        CandidateData(id: "A7392", position: "Senior iOS Developer", matchScore: 98, deiScore: 4.8),
        CandidateData(id: "B1458", position: "Data Scientist", matchScore: 95, deiScore: 4.6),
        CandidateData(id: "C9023", position: "UX Research Lead", matchScore: 92, deiScore: 4.7),
        CandidateData(id: "D5671", position: "Product Marketing Manager", matchScore: 89, deiScore: 4.4),
        CandidateData(id: "E3489", position: "HR Business Partner", matchScore: 94, deiScore: 4.9)
    ]
    
    let shortlistedCandidates = [
        CandidateData(id: "F8234", position: "Senior iOS Developer", matchScore: 99, deiScore: 4.9, isAnonymized: true),
        CandidateData(id: "G9156", position: "Data Scientist", matchScore: 97, deiScore: 4.8, isAnonymized: true),
        CandidateData(id: "H4721", position: "UX Research Lead", matchScore: 96, deiScore: 4.7, isAnonymized: true)
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pending Review")) {
                    ForEach(pendingCandidates, id: \.id) { candidate in
                        CandidateRowView(candidate: candidate, isAnonymized: true)
                    }
                }
                
                Section(header: Text("Shortlisted")) {
                    ForEach(shortlistedCandidates, id: \.id) { candidate in
                        CandidateRowView(candidate: candidate, isAnonymized: true)
                    }
                }
            }
            .navigationTitle("Candidates")
            .searchable(text: $searchText, prompt: "Search candidates...")
        }
    }
}

struct CandidateData {
    let id: String
    let position: String
    let matchScore: Int
    let deiScore: Double
    var isAnonymized: Bool = true
}

struct CandidateRowView: View {
    let candidate: CandidateData
    var isAnonymized: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Candidate #\(candidate.id)")
                .font(.headline)
            Text(candidate.position)
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Label("\(candidate.matchScore)% Match", systemImage: "checkmark.circle.fill")
                    .foregroundColor(candidate.matchScore >= 95 ? .green : .orange)
                Spacer()
                Label(String(format: "%.1f DEI Score", candidate.deiScore), systemImage: "star.fill")
                    .foregroundColor(candidate.deiScore >= 4.5 ? .green : .orange)
            }
            .font(.caption)
        }
        .padding(.vertical, 8)
    }
} 