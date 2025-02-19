import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var otp: String = ""
    @State private var isOTPReceived: Bool = false
    @State private var errorMessage: String?
    @State private var isLoggedIn: Bool = false
    @State private var showLocationView = false // To trigger navigation

    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 20)

            // App Icon
            Image("Logo")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
                .padding(.top, 20)
                .blendMode(.multiply)

            // Title
            Text("Sign In")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color.green)

            // Subtitle
            Text("Welcome Back to QSkipper!")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            // Email Input & Send OTP Button
            VStack(alignment: .leading, spacing: 5) {
                TextField("Enter Email", text: $email)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))

                HStack {
                    Spacer()
                    Button(action: sendOTP) {
                        Text(isOTPReceived ? "OTP Sent ✅" : "Send OTP")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.green)
                    }
                    .disabled(isOTPReceived) // Disable after OTP is sent
                }
            }
            .padding(.horizontal)

            // OTP Input & Resend OTP Button
            VStack(alignment: .leading, spacing: 5) {
                TextField("Enter OTP", text: $otp)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))

                HStack {
                    Spacer()
                    Button(action: sendOTP) {
                        Text("Resend OTP?")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.green)
                    }
                }
            }
            .padding(.horizontal)

            // Sign In Button
            Button(action: signInUser) {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .frame(height: 50)
            .padding(.horizontal)

            // Show error message if any
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.green.opacity(0.1)]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .fullScreenCover(isPresented: $showLocationView) {
            LocationViewControllerWrapper() // Present the wrapped `LocationViewController`
        }
    }

    // MARK: - API Calls

    func sendOTP() {
        Task {
            do {
                let (otp) = try await NetworkUtils.shared.loginUser(email: email)
                print("OTP sent successfully to \(otp)")
                isOTPReceived = true
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func signInUser() {
        Task {
            do {
                let userID = try await NetworkUtils.shared.verifyLoginUser(email: email, otp: otp)
                print("User Signed In with ID: \(userID)")
                isLoggedIn = true
                showLocationView = true // Trigger navigation
            } catch {
                errorMessage = "Invalid OTP. Please try again."
            }
        }
    }
}
