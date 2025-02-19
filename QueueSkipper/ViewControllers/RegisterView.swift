import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var otp: String = ""
    @State private var isOTPReceived: Bool = false
    @State private var isRegistered: Bool = false
    @State private var errorMessage: String?

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
            Text("Register")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color.green)

            // Subtitle
            Text("Hi, Team QSkipper Welcomes You!")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            // Username Input
            TextField("Username", text: $username)
                .padding()
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))
                .padding(.horizontal)

            // Email Input & Send OTP Button
            VStack(alignment: .leading, spacing: 5) {
                TextField("Email", text: $email)
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

            // Register Button
            Button(action: registerUser) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .frame(height: 50)
            .padding(.horizontal)
            .disabled(!isOTPReceived) // Disable until OTP is sent

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
    }

    // MARK: - API Calls

    func sendOTP() {
        Task {
            do {
                let message = try await NetworkUtils.shared.registerUser(email: email, username: username)
                print(message)
                isOTPReceived = true
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func registerUser() {
        Task {
            do {
                let userID = try await NetworkUtils.shared.verifyUser(email: email, otp: otp)
                print("User Registered with ID: \(userID)")
                isRegistered = true
                navigateToMenuViewController()
            } catch {
                errorMessage = "Invalid OTP. Please try again."
            }
        }
    }

    func navigateToMenuViewController() {
            if let window = UIApplication.shared.windows.first {
                let menuViewController = MenuViewController()
                window.rootViewController = UINavigationController(rootViewController: menuViewController)
                window.makeKeyAndVisible()
            }
        }
    }

#Preview {
    RegisterView()
}
