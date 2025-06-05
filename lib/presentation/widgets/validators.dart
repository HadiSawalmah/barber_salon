class Validators {
  static String? email(String? value) {
   if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value){
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d:@$*&_-]{8,}$',
    ).hasMatch(value)) {
      return 'Password must be 8+ characters,\n'
          'and include both letters and numbers )';
    }

    return null;
  }



  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'number is required';
    }
    if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
      return 'number must contain only digits';
    }
    if (value.trim().length != 10) {
      return 'number must be 10 digits';
    }

    return null;
  }

  static String? text(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'is required';
    }
    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value.trim())) {
      return 'must contain only letters and spaces';
    }

    return null;
  }

  static String? facebookUrl(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Facebook URL is required';
  }
   if (!RegExp(r'^(https?:\/\/)?(www\.)?facebook\.com\/[A-Za-z0-9_.-]+\/?$').hasMatch(value.trim())) {
      return 'Enter a valid Facebook profile URL';
    }

    return null;

}

}
