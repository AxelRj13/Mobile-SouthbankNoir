import 'package:email_validator/email_validator.dart';

extension ValidatorExt on String {
  bool get isEmail => EmailValidator.validate(this);

  bool get isPhone =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(this);

  bool get hasUppercase => contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => contains(RegExp(r'[a-z]'));
  bool get hasNumber => contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
}
