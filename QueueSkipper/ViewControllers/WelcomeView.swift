import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView { // Wrap in NavigationView
            VStack {
//                Spacer(minLength: 20)

                // Image instead of GIF
                Image("login")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 250)
                    .padding(.top, 20)
                    .padding(50)
                    .blendMode(.multiply)

                // Headline Text
                Text("No Lines, Just Good Times!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.0, green: 0.6, blue: 0.2))
                    .padding(.top, 10)

                // Subtitle Text
                Text("Because great food shouldn’t come with long lines!")
                    .font(.custom("Regular", size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(width: 250) // Adjust width to force wrapping
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                Spacer()

                // Buttons (Login and Register)
                HStack(spacing: 20) {
                    NavigationLink(destination: SignInView()) { // Navigate to SignInView
                        Text("Login")
                            .fontWeight(.bold)
                            .frame(width: 140, height: 50)
                            .background(Color(red: 0.0, green: 0.6, blue: 0.2))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    NavigationLink(destination: RegisterView()) { // sNavigate to RegisterView
                        Text("Register")
                            .fontWeight(.bold)
                            .frame(width: 140, height: 50)
                            .foregroundColor(.black)
                    }
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure VStack takes full screen
            .background(
                Image("wave")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0.3)
                    .ignoresSafeArea() // Ensure background extends beyond safe areas
            )
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
