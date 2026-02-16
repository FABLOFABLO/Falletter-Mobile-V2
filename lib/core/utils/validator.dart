
   bool emailValid(String email) {
    final input = email;
    final isValid = RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(input);
    return isValid && input.length >= 6;
  }