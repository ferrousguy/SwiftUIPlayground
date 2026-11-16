//
//  FocusStateView.swift
//  SwiftUIPlayground
//
//  Created by Joben Gohlke on 4/19/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - validation
    func nameIsValid() -> Bool {
        return !name.isEmpty
    }
    
    func emailIsValid() -> Bool {
        return !email.isEmpty
    }
    
    func passwordIsValid() -> Bool {
        return !password.isEmpty
    }
    
    func formIsValid() -> Bool {
        return nameIsValid() && emailIsValid() && passwordIsValid()
    }
}

struct FocusStateView: View {
  @ObservedObject var viewModel: ViewModel

  @FocusState private var focusedField: Field?
  
  @State var name: String = ""
  @State var email: String = ""
  @State var password: String = ""
  
  enum Field {
    case name
    case email
    case password
  }
  
  var didTapContinue: () -> Void = {}
    
  var body: some View {
    ScrollView {
        VStack(alignment: .leading, spacing: 12) {
            Text("Enter your name")
                .font(.title)
                .fontWeight(.bold)

            InputField(text: $viewModel.name, titleLable: "Name", placeholder: "Name")
                .error(errorMessage: "Please enter your name", entryIsValid: viewModel.nameIsValid)
                .onSubmit { setActiveField(.email) }
                .focused($focusedField, equals: .name)
            
            InputField(text: $viewModel.email, titleLable: "Email", placeholder: "Email")
                .error(errorMessage: "Please enter your email", entryIsValid: viewModel.emailIsValid)
                .onSubmit { setActiveField(.password) }
                .focused($focusedField, equals: .email)
            
            InputField(text: $viewModel.password, titleLable: "Password", placeholder: "Password")
                .error(errorMessage: "Enter password", entryIsValid: viewModel.passwordIsValid)
                .focused($focusedField, equals: .password)
            
            Spacer()
            
            Button(action: { didTapContinue() }) {
                Text("Continue")
            }
            .disabled(!viewModel.formIsValid())
        }
        .padding()
    }
  }
  
  private func setActiveField(_ field: Field) {
    focusedField = field
  }
}

struct InputField: View {
    @FocusState private var isTextFieldFocused: Bool
    @Binding var text: String
    @State private var isTapped: Bool = false
    var titleLable: String
    var placeholder: String
    
    private var errorMessage: String = ""
    private var entryIsValid: (() -> Bool)? = nil
    @State private var showErrorMessage: Bool = false
    
    private var onCommitAction: (() -> Void)? = nil
    
    init(text: Binding<String>, titleLable: String, placeholder: String) {
        _text = text
        self.titleLable = titleLable
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(titleLable)
                .font(.system(size: 16))
                .lineLimit(1)
            
            TextField(placeholder, text: $text)
                .focused($isTextFieldFocused)
                .onChange(of: isTextFieldFocused) { isFocused in
                    isTapped = isFocused
                    if !isFocused {
                        checkForError()
                    }
                }
                .onSubmit {
                    onCommitAction?()
                    checkForError()
                }
                .frame(height: 50)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(strokeColor, lineWidth: isTapped ? 2:0.5)
                )
            
            if showErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
            }
        }
    }
    
    private var strokeColor: Color {
        return isTapped ? Color(uiColor: .blue):Color(uiColor: .black)
    }
    
    private func checkForError() {
        guard let entryIsValid = entryIsValid else {
            return
        }
        showErrorMessage = !entryIsValid()
    }
    
    func error(errorMessage: String, entryIsValid: @escaping (() -> Bool)) -> InputField {
        var view = self
        view.errorMessage = errorMessage
        view.entryIsValid = entryIsValid
        return view
    }
    
    func onCommit(action: @escaping (() -> Void)) -> InputField {
        var view = self
        view.onCommitAction = action
        return view
    }
}

struct FocusStateView_Previews: PreviewProvider {
  static var previews: some View {
    FocusStateView(viewModel: ViewModel())
  }
}
