String? validateEmail(String email) {
  String _msg;
  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (email.isEmpty) {
    return "This field can't be empty'";
  } else if (!regex.hasMatch(email)) {
    _msg = "Email format is not correct";
  } else{
    return null;
  }
}
