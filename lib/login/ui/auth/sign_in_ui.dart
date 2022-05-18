import 'package:flutter/material.dart';
import 'package:getx/login/controllers/controller.dart';
import 'package:getx/login/ui/components/components.dart';
import 'package:getx/login/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:getx/login/ui/auth/auth.dart';

class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'auth.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                    labelText: 'auth.signInButton'.tr,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        authController.signInWithEmailAndPassword(context);
                      }
                    },
                  ),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                  LabelButton(
                    labelText: 'auth.signUpLabelButton'.tr,
                    onPressed: () => Get.to(SignUpUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
