import SwiftUI

struct GetStartedView: View {
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @EnvironmentObject var authController: AuthController
    @State private var onboardingComplete = false

    var body: some View {
        VStack {
            Text("thank you")
                .padding()
                .font(.title)
                .bold()
                .foregroundStyle(Color.coffee)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                Task {
                    try await onboardingVM.saveProfile(userId: authController.currentUserId)
                    await authController.checkUserProfile()
                    onboardingComplete = true
                }
            } label: {
                Text("Get Started")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color.coffee)
            }
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.cream)
        .navigationDestination(isPresented: $onboardingComplete) {
            RootView()
                .navigationBarBackButtonHidden()
        }
    }
}

struct Restaurant: Codable {
    let name: String
    let location: String // You could also use a custom type with a custom `Encodable` conformance for convenience.
}

struct Response: Codable {
    let id: Int
    let name: String
    let lat: Double
    let long: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, lat, long
    }
}


