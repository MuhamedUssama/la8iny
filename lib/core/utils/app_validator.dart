abstract class AppValidator {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email Cannot be empty';
    }

    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!regex.hasMatch(email)) {
      return 'Invalid Email Address';
    }

    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password Cannot be empty';
    }

    if (password.length < 6) {
      return 'Invalid Password';
    }

    return null;
  }

  static String? nameVaidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name Cannot be empty';
    }

    return null;
  }
}
