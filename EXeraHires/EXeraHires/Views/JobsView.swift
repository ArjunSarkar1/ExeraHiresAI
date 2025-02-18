import SwiftUI

struct JobsView: View {
    @State private var searchText = ""
    
    let jobs = [
        // Technology
        JobData(title: "Senior iOS Developer", department: "Engineering", location: "San Francisco", candidates: 14, deiScore: 4.2),
        JobData(title: "Full Stack Engineer", department: "Engineering", location: "Remote", candidates: 28, deiScore: 4.4),
        JobData(title: "Cloud Security Architect", department: "Infrastructure", location: "Seattle", candidates: 19, deiScore: 4.3),
        
        // Data & Analytics
        JobData(title: "Data Scientist", department: "Analytics", location: "Remote", candidates: 31, deiScore: 4.5),
        JobData(title: "Business Intelligence Analyst", department: "Analytics", location: "Chicago", candidates: 22, deiScore: 4.6),
        
        // Design & UX
        JobData(title: "UX Research Lead", department: "Design", location: "Seattle", candidates: 18, deiScore: 4.6),
        JobData(title: "Senior Product Designer", department: "Design", location: "Los Angeles", candidates: 25, deiScore: 4.7),
        
        // Business & Operations
        JobData(title: "Product Marketing Manager", department: "Marketing", location: "Boston", candidates: 27, deiScore: 4.3),
        JobData(title: "Strategic Account Executive", department: "Sales", location: "New York", candidates: 16, deiScore: 4.4),
        JobData(title: "Operations Manager", department: "Operations", location: "Austin", candidates: 21, deiScore: 4.5),
        
        // HR & People
        JobData(title: "HR Business Partner", department: "Human Resources", location: "New York", candidates: 23, deiScore: 4.8),
        JobData(title: "Talent Acquisition Specialist", department: "Human Resources", location: "Remote", candidates: 15, deiScore: 4.9),
        JobData(title: "Learning & Development Manager", department: "People Development", location: "Denver", candidates: 12, deiScore: 4.7),
        
        // Finance & Legal
        JobData(title: "Financial Analyst", department: "Finance", location: "Chicago", candidates: 20, deiScore: 4.2),
        JobData(title: "Legal Counsel", department: "Legal", location: "Washington DC", candidates: 8, deiScore: 4.6)
    ]
    
    var filteredJobs: [JobData] {
        if searchText.isEmpty {
            return jobs
        }
        return jobs.filter { job in
            job.title.localizedCaseInsensitiveContains(searchText) ||
            job.department.localizedCaseInsensitiveContains(searchText) ||
            job.location.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(Dictionary(grouping: filteredJobs, by: { $0.department })), id: \.key) { department, departmentJobs in
                    Section(header: Text(department)) {
                        ForEach(departmentJobs, id: \.title) { job in
                            JobRowView(job: job)
                        }
                    }
                }
            }
            .navigationTitle("Job Board")
            .searchable(text: $searchText, prompt: "Search jobs, departments, or locations...")
        }
    }
}

struct JobData: Identifiable {
    let id = UUID()
    let title: String
    let department: String
    let location: String
    let candidates: Int
    let deiScore: Double
    var isScanned: Bool = false
    var isScanning: Bool = false
}

struct JobRowView: View {
    let job: JobData
    @State private var isScanning = false
    @State private var isScanned = false
    @State private var showingScanAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(job.title)
                .font(.headline)
            HStack {
                Image(systemName: "building.2.fill")
                    .foregroundColor(.secondary)
                Text("\(job.location)")
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
            
            HStack {
                Label("\(job.candidates) candidates", systemImage: "person.fill")
                    .foregroundColor(.blue)
                Spacer()
                
                // Scan Button
                Button(action: {
                    startScanning()
                }) {
                    if isScanning {
                        HStack {
                            ProgressView()
                                .scaleEffect(0.8)
                                .tint(.white)
                            Text("Scanning")
                                .foregroundColor(.white)
                        }
                        .frame(width: 100)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(20)
                    } else if isScanned {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Complete")
                        }
                        .frame(width: 100)
                        .padding(.vertical, 6)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(20)
                    } else {
                        HStack {
                            Image(systemName: "doc.text.magnifyingglass")
                            Text("Scan")
                        }
                        .frame(width: 100)
                        .padding(.vertical, 6)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
                }
                .disabled(isScanning || isScanned)
            }
            .font(.caption)
        }
        .padding(.vertical, 8)
        .alert("Scan Complete!", isPresented: $showingScanAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("All applications have been analyzed for potential biases and DEI compliance.")
        }
    }
    
    private func startScanning() {
        isScanning = true
        
        // Simulate scanning process
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isScanning = false
            isScanned = true
            showingScanAlert = true
            
            // Optional: Add haptic feedback
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
} 