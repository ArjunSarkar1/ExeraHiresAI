import SwiftUI
import Charts

struct AnalyticsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    DiversityScoreCard()
                    
                    HiringFunnelCard()
                    
                    BiasDetectionCard()
                }
                .padding()
            }
            .navigationTitle("Analytics")
        }
    }
}

struct DiversityScoreCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Diversity Score")
                .font(.headline)
            
            HStack {
                Text("4.2")
                    .font(.system(size: 48, weight: .bold))
                Text("/ 5.0")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: 0.84)
                .tint(.green)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct HiringFunnelCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hiring Funnel")
                .font(.headline)
            
            VStack(spacing: 8) {
                FunnelRow(label: "Applications", count: 245)
                FunnelRow(label: "Screened", count: 180)
                FunnelRow(label: "Interviewed", count: 45)
                FunnelRow(label: "Offered", count: 12)
                FunnelRow(label: "Hired", count: 8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct FunnelRow: View {
    var label: String
    var count: Int
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text("\(count)")
                .bold()
        }
    }
}

struct BiasDetectionCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Bias Detection")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                Label("Gender-neutral language: 98%", systemImage: "checkmark.circle.fill")
                Label("Age-neutral terms: 95%", systemImage: "checkmark.circle.fill")
                Label("Inclusive terminology: 92%", systemImage: "checkmark.circle.fill")
            }
            .foregroundColor(.green)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
} 