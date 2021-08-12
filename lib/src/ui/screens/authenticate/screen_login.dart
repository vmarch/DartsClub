import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/blocks/auth_bloc.dart';
import 'package:test_flutter_app/src/models/login_enum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  final TextEditingController _firstNameFilter = new TextEditingController();
  final TextEditingController _lastNameFilter = new TextEditingController();
  final TextEditingController _nickFilter = new TextEditingController();
  final TextEditingController _cityFilter = new TextEditingController();
  final TextEditingController _phoneFilter = new TextEditingController();

  final TextEditingController _emailFilter = new TextEditingController();

  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _passwordRepeatFilter =
      new TextEditingController();

  FormType _form = FormType.login;
  bool _registerVisible = false;

  // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginScreenState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);

    _registerVisible = false;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _emailFilter.addListener(_emailListen);
  //   _passwordFilter.addListener(_passwordListen);
  // }

  void _firstNameListen() {
    if (_firstNameFilter.text.isEmpty) {
      authBloc.firstName("");
    } else {
      authBloc.firstName(_firstNameFilter.text);
    }
  }

  void _lastNameListen() {
    if (_lastNameFilter.text.isEmpty) {
      authBloc.lastName("");
    } else {
      authBloc.lastName(_lastNameFilter.text);
    }
  }

  void _nickListen() {
    if (_nickFilter.text.isEmpty) {
      authBloc.nick("");
    } else {
      authBloc.nick(_nickFilter.text);
    }
  }

  void _cityListen() {
    if (_cityFilter.text.isEmpty) {
      authBloc.city("");
    } else {
      authBloc.city(_cityFilter.text);
    }
  }

  void _phoneListen() {
    if (_phoneFilter.text.isEmpty) {
      authBloc.phone("");
    } else {
      authBloc.phone(_phoneFilter.text);
    }
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      authBloc.email("");
    } else {
      authBloc.email(_emailFilter.text);
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      authBloc.password("");
    } else {
      authBloc.password(_passwordFilter.text);
    }
  }

  void _passwordRepeatListen() {
    if (_passwordRepeatFilter.text.isEmpty) {
      authBloc.passwordRepeat("");
    } else {
      authBloc.passwordRepeat(_passwordRepeatFilter.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 32.0, right: 32.0, top: 24, bottom: 12),
                child: Text(
                  'New User',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Visibility(
              visible: !_registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      // decoration: BoxDecoration(
                      //     color: Colors.red,
                      //     borderRadius: BorderRadius.circular(50.0)),
                      child: Image.asset('assets/darts_login.jpg')),
                ),
              ),
            ),

//Register part

            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 0),
                child: TextField(
                  controller: _firstNameFilter,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First name',
                      hintText: 'Enter your First name'),
                ),
              ),
            ),
            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 0),
                child: TextField(
                  controller: _lastNameFilter,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last name',
                      hintText: 'Enter your Last name'),
                ),
              ),
            ),
            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 0),
                child: TextField(
                  controller: _nickFilter,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter your Username (nickname)'),
                ),
              ),
            ),

            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 0),
                child: TextField(
                  controller: _cityFilter,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                      hintText: 'Enter city where are you living'),
                ),
              ),
            ),

            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 0),
                child: TextField(
                  controller: _phoneFilter,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                      hintText: 'Enter your phone number'),
                ),
              ),
            ),

// Login/Register part

            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 12, bottom: 0),
              child: TextField(
                controller: _emailFilter,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 12, bottom: 0),
              child: TextField(
                controller: _passwordFilter,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),

            Visibility(
              visible: _registerVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12, bottom: 32),
                child: TextField(
                  controller: _passwordRepeatFilter,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password repeat',
                      hintText: 'Repeat your password'),
                ),
              ),
            ),

            Visibility(
              visible: !_registerVisible,
              child: TextButton(
                onPressed: () {
                  _passwordReset();
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
            Visibility(
              visible: !_registerVisible,
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    _loginBtnPressed();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: _registerVisible,
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    _registerBtnPressed();
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Visibility(
              visible: !_registerVisible,
              child: TextButton(
                child: Text('New User? Click here to register.'),
                onPressed: _tryToRegisterBtnPressed,
              ),
            ),
            Visibility(
              visible: _registerVisible,
              child: TextButton(
                child: Text('Have an account? Click here to login.'),
                onPressed: _tryToLogin,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _loginBtnPressed() {

    authBloc.login(context);
    print('The user wants to login with email and password');
  }

  void _registerBtnPressed() {
    print('The user wants to register with email and password');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to email");
  }

  void _tryToRegisterBtnPressed() {
    addRegistersListeners();
    print('Change to Registrations form');
    setState(() {
      _registerVisible = true;
    });
  }

  void _tryToLogin() {
    clearRegisterFields();
    clearRegistersListener();
    authBloc.cleanFormData();
    print('Change to Login form');
    setState(() {
      _registerVisible = false;
    });
  }

  void addRegistersListeners() {
    _firstNameFilter.addListener(_firstNameListen);
    _lastNameFilter.addListener(_lastNameListen);
    _nickFilter.addListener(_nickListen);
    _cityFilter.addListener(_cityListen);
    _phoneFilter.addListener(_phoneListen);
    _passwordRepeatFilter.addListener(_passwordRepeatListen);
  }

  void clearRegistersListener() {
    _firstNameFilter.removeListener(_firstNameListen);
    _lastNameFilter.removeListener(_lastNameListen);
    _nickFilter.removeListener(_nickListen);
    _cityFilter.removeListener(_cityListen);
    _phoneFilter.removeListener(_phoneListen);
    _passwordRepeatFilter.removeListener(_passwordRepeatListen);
  }

  void clearRegisterFields() {
    _firstNameFilter.clear();
    _lastNameFilter.clear();
    _nickFilter.clear();
    _cityFilter.clear();
    _phoneFilter.clear();
    _passwordRepeatFilter.clear();
  }
}
