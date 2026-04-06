import 'package:optizenqor/feature/authentication/auth_choice/auth_choice_model/auth_choice_model.dart';

class AuthChoiceController {
  const AuthChoiceController();

  AuthChoiceModel get content => const AuthChoiceModel(
    title: 'Welcome To Optizenqor Store',
    subtitle: 'Log In or SIgn Up to continue.',
  );
}
