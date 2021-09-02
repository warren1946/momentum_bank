import 'package:flutter/material.dart';
import 'package:momentum_bank/app/login/model/login_response.dart';
import 'package:momentum_bank/app/login/view_model/login_view_model.dart';
import 'package:momentum_bank/app/utils/app_alert_dialog.dart';
import 'package:momentum_bank/app/utils/input_validation_mixin.dart';
import 'package:ndialog/ndialog.dart';

class LoginScreen extends StatelessWidget with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  LoginViewModel loginViewModel = LoginViewModel();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameField(),
            _passwordField(),
            SizedBox(
              height: 25,
            ),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Username',
      ),
      validator: (value) {
        if (isEmailValid(value))
          return null;
        else
          return 'Please enter a valid email address';
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Password',
      ),
      validator: (value) {
        if (isPasswordValid(value))
          return null;
        else
          return 'Password should have a minimum of 8 characters.';
      },
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          ProgressDialog progressDialog = AppAlertDialog().progressDialog(context: context, text: 'Logging in...');
          progressDialog.show();

          LoginResponse _response = await loginViewModel.loginUser(
            username: usernameController.text,
            password: passwordController.text,
            returnSecureToken: true,
          );

          if (_response != null) {
            progressDialog.dismiss();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => CymlessHomeScreen()));
          } else {
            progressDialog.dismiss();
            AppAlertDialog().showSnackBar(context: context, text: 'Invalid username and or password!');
          }
        }
      },
      child: Text('Login'),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
