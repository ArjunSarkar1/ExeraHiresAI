import SwiftUI

struct InterviewsView: View {
    @State private var searchText = ""
    @State private var selectedInterview: InterviewData?
    
    let interviews = [
        InterviewData(
            type: "Technical Interview",
            candidateId: "A7392",
            candidateName: "Alex Thompson",
            candidateGender: "Non-Binary",
            position: "Senior iOS Developer",
            time: "Today, 2:00 PM",
            duration: "45 min",
            transcript: "Interviewer: Could you walk me through your experience with iOS development?\nCandidate: I've been developing iOS applications for 7 years, focusing on accessibility and performance optimization...",
            biasAnalysis: BiasAnalysis(
                discriminationScore: 0.2,
                detectedBiases: [
                    BiasDetection(type: "Language Bias", severity: "Low", context: "Consider using 'experience' instead of 'years' to avoid potential age bias"),
                    BiasDetection(type: "Technical Assumption", severity: "Low", context: "Ensure questions don't assume specific background knowledge")
                ],
                recommendations: [
                    "Focus more on problem-solving approach rather than years of experience",
                    "Ask about specific projects and outcomes rather than timeline",
                    "Include questions about collaborative experiences"
                ]
            )
        ),
        InterviewData(
            type: "Cultural Fit",
            candidateId: "B1458",
            candidateName: "Sarah Chen",
            candidateGender: "Female",
            position: "Data Scientist",
            time: "Tomorrow, 10:30 AM",
            duration: "30 min",
            transcript: "Interviewer: How do you handle working in fast-paced environments?\nCandidate: I thrive in dynamic environments where I can apply my analytical skills...",
            biasAnalysis: BiasAnalysis(
                discriminationScore: 0.1,
                detectedBiases: [
                    BiasDetection(type: "Cultural Bias", severity: "Low", context: "Question might favor certain work styles")
                ],
                recommendations: [
                    "Rephrase questions to focus on specific situations and outcomes",
                    "Include questions about different working styles and approaches"
                ]
            )
        ),
        InterviewData(
            type: "Final Round",
            candidateId: "C9023",
            candidateName: "Jordan Rivera",
            candidateGender: "Male",
            position: "UX Research Lead",
            time: "Tomorrow, 3:15 PM",
            duration: "60 min",
            transcript: "Interviewer: How do you ensure your research methods are inclusive?\nCandidate: I prioritize diverse participant recruitment and accessible research methods...",
            biasAnalysis: BiasAnalysis(
                discriminationScore: 0.0,
                detectedBiases: [],
                recommendations: [
                    "Continue focusing on inclusive research practices",
                    "Maintain balanced question distribution"
                ]
            )
        )
    ]
    
    let interviewQuestions: [String: [String]] = [
        "Senior iOS Developer": [
            "1. Can you describe a complex UI challenge you faced in iOS development and how you solved it while maintaining accessibility?",
            "2. How do you approach memory management in iOS, and what strategies do you use to prevent memory leaks?",
            "3. Describe your experience with Swift concurrency and how you've implemented async/await in a recent project.",
            "4. How do you ensure your iOS applications are inclusive and accessible to users with different abilities?",
            "5. Tell me about a time when you had to optimize an iOS app's performance. What metrics did you use?"
        ],
        
        "Data Scientist": [
            "1. How do you ensure your data models account for potential biases in training data?",
            "2. Describe a situation where you had to communicate complex statistical findings to non-technical stakeholders.",
            "3. What methods do you use to validate the fairness of your machine learning models?",
            "4. How do you approach feature selection while ensuring you're not inadvertently introducing discriminatory variables?",
            "5. Tell me about a time when you had to modify your analysis approach to ensure inclusive results."
        ],
        
        "UX Research Lead": [
            "1. How do you ensure your research participants represent diverse user groups?",
            "2. Describe your approach to creating inclusive user personas and journey maps.",
            "3. How do you modify your research methodologies to accommodate participants with different abilities?",
            "4. Tell me about a time when research findings led to a more inclusive product design.",
            "5. How do you ensure cultural sensitivity in your research protocols and analysis?"
        ]
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Upcoming Interviews")) {
                    ForEach(interviews, id: \.candidateId) { interview in
                        InterviewRowView(interview: interview)
                            .onTapGesture {
                                selectedInterview = interview
                            }
                    }
                }
                
                ForEach(Array(interviewQuestions.keys.sorted()), id: \.self) { position in
                    Section(header: Text("Example Interview Questions: \(position)")) {
                        ForEach(interviewQuestions[position] ?? [], id: \.self) { question in
                            Text(question)
                                .font(.subheadline)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Interviews")
            .searchable(text: $searchText, prompt: "Search interviews...")
            .sheet(item: $selectedInterview) { interview in
                InterviewAnalysisView(interview: interview)
            }
        }
    }
}

struct InterviewData: Identifiable {
    let id = UUID()
    let type: String
    let candidateId: String
    let candidateName: String
    let candidateGender: String
    let position: String
    let time: String
    let duration: String
    let transcript: String
    let biasAnalysis: BiasAnalysis
}

struct BiasAnalysis {
    let discriminationScore: Double
    let detectedBiases: [BiasDetection]
    let recommendations: [String]
}

struct BiasDetection {
    let type: String
    let severity: String
    let context: String
}

struct InterviewAnalysisView: View {
    let interview: InterviewData
    @Environment(\.dismiss) var dismiss
    @State private var isAnalyzing = true
    @State private var showContent = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if isAnalyzing {
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("AI Analyzing Transcript...")
                            .font(.headline)
                    }
                } else if showContent {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Success Message
                            Text("Analysis Complete!")
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                                .transition(.opacity)
                            
                            // Candidate Details Card
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Candidate Details")
                                    .font(.headline)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Name:")
                                            .foregroundColor(.secondary)
                                        Text(interview.candidateName)
                                            .bold()
                                    }
                                    
                                    HStack {
                                        Text("ID:")
                                            .foregroundColor(.secondary)
                                        Text("#\(interview.candidateId)")
                                    }
                                    
                                    HStack {
                                        Text("Gender:")
                                            .foregroundColor(.secondary)
                                        Text(interview.candidateGender)
                                    }
                                    
                                    HStack {
                                        Text("Position:")
                                            .foregroundColor(.secondary)
                                        Text(interview.position)
                                    }
                                }
                                .font(.subheadline)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            
                            // Discrimination Score Card
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Discrimination Score")
                                    .font(.headline)
                                
                                HStack {
                                    Text(String(format: "%.1f", interview.biasAnalysis.discriminationScore))
                                        .font(.system(size: 48, weight: .bold))
                                    Text("/ 1.0")
                                        .font(.title2)
                                        .foregroundColor(.secondary)
                                }
                                
                                ProgressView(value: interview.biasAnalysis.discriminationScore, total: 1.0)
                                    .tint(discriminationColor)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            
                            // Transcript Analysis
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Interview Transcript")
                                    .font(.headline)
                                
                                Text(interview.transcript)
                                    .font(.body)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            
                            // Detected Biases
                            if !interview.biasAnalysis.detectedBiases.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Detected Biases")
                                        .font(.headline)
                                    
                                    ForEach(interview.biasAnalysis.detectedBiases, id: \.type) { bias in
                                        BiasCard(bias: bias)
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            }
                            
                            // Recommendations
                            VStack(alignment: .leading, spacing: 12) {
                                Text("AI Recommendations")
                                    .font(.headline)
                                
                                ForEach(interview.biasAnalysis.recommendations, id: \.self) { recommendation in
                                    Label(recommendation, systemImage: "lightbulb.fill")
                                        .font(.subheadline)
                                        .padding(.vertical, 4)
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        .padding()
                    }
                    .transition(.opacity)
                }
            }
            .navigationTitle("HR Report")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                // Simulate analysis delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        isAnalyzing = false
                    }
                    // Show content with a slight delay after analysis
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            showContent = true
                        }
                    }
                }
            }
        }
    }
    
    var discriminationColor: Color {
        switch interview.biasAnalysis.discriminationScore {
        case 0...0.3:
            return .green
        case 0.3...0.6:
            return .orange
        default:
            return .red
        }
    }
}

struct BiasCard: View {
    let bias: BiasDetection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(bias.type)
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text(bias.severity)
                    .font(.caption)
                    .padding(4)
                    .background(severityColor.opacity(0.2))
                    .foregroundColor(severityColor)
                    .cornerRadius(4)
            }
            
            Text(bias.context)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
    
    var severityColor: Color {
        switch bias.severity.lowercased() {
        case "low":
            return .green
        case "medium":
            return .orange
        case "high":
            return .red
        default:
            return .gray
        }
    }
}

struct InterviewRowView: View {
    let interview: InterviewData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(interview.type)
                .font(.headline)
            Text("Candidate #\(interview.candidateId) • \(interview.position)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Label(interview.time, systemImage: "calendar")
                Spacer()
                Label(interview.duration, systemImage: "clock.fill")
            }
            .font(.caption)
        }
        .padding(.vertical, 8)
    }
} 