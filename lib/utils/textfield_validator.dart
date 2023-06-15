import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: "Password Cannot be Empty!"),
  MinLengthValidator(4, errorText: "Password length must be greater than 4"),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: "Email Cannot be Empty!"),
  EmailValidator(errorText: "Email not valid!"),
]);

final nameValidator = MultiValidator([
  RequiredValidator(errorText: "Name Cannot be Empty!"),
  MinLengthValidator(4, errorText: "Name must have more than 4 characters")
]);

final usernameValidator = MultiValidator([
  RequiredValidator(errorText: "Username Cannot be Empty!"),
  MinLengthValidator(4, errorText: "Username must have more than 4 characters")
]);
//Passed so that nested condition in validation of textfieldform can return this instead of null
//to avoid error
final matchPassword = MatchValidator(errorText: 'Password Does Not Match');
final validator = MultiValidator([]);
