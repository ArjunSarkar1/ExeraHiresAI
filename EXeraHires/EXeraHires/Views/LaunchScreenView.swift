import SwiftUI

struct LaunchScreenView: View {
    @State private var isLoading = false
    @State private var showMainContent = false
    @State private var scale = 1.0
    
    var body: some View {
        if showMainContent {
            ContentView()
        } else {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Logo and App Name
                    VStack(spacing: 15) {
                        ZStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                                .offset(x: -20)
                            
                            Image(systemName: "laptopcomputer")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                                .offset(x: 20)
                            
                            // Connection line between human and computer
                            Circle()
                                .trim(from: 0, to: 0.5)
                                .stroke(Color.blue, lineWidth: 3)
                                .frame(width: 40, height: 40)
                                .rotationEffect(.degrees(-45))
                                .offset(y: -10)
                        }
                        .scaleEffect(scale)
                        .animation(
                            Animation.easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true),
                            value: scale
                        )
                        
                        Text("EXeraHires")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("AI-Powered HR Solutions")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    
                    // Loading indicator
                    VStack(spacing: 15) {
                        ProgressView()
                            .scaleEffect(1.5)
                        
                        Text("Initializing AI Systems...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .opacity(isLoading ? 1 : 0)
                }
            }
            .onAppear {
                // Start loading animation
                withAnimation(.easeIn(duration: 0.8)) {
                    isLoading = true
                    scale = 1.1
                }
                
                // Simulate initialization time and transition to main content
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showMainContent = true
                    }
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
} 