import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../services/global_methods.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _emailAddress = '';
  String _password = '';
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  GlobalMethods _globalMethods = new GlobalMethods();

  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim());
      } catch (error) {
        _globalMethods.authErrorHandle(error.message, context);
        print('error occured ${error.message}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Image.asset('assets/images/image-removebg-preview.png'),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: HexColor('#e7e7e7')),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: HexColor('#FA8072')),
                        ),
                        filled: true,
                        prefixIcon:
                            Icon(Icons.email, color: HexColor('#e7e7e7')),
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? Colors.black
                                : Colors.black),
                        fillColor: Colors.white,
                      ),
                      onSaved: (value) {
                        _emailAddress = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        key: ValueKey('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1, color: HexColor('#e7e7e7')),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1, color: HexColor('#FA8072')),
                          ),
                          filled: true,
                          prefixIcon:
                              Icon(Icons.lock, color: HexColor('#e7e7e7')),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: HexColor('#e7e7e7')),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: myFocusNode.hasFocus
                                  ? Colors.black
                                  : Colors.black),
                          fillColor: Colors.white,
                        ),
                        onSaved: (value) {
                          _password = value;
                        },
                        obscureText: _obscureText,
                        onEditingComplete: _submitForm,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          child: Text('Log In'),
                          style: ElevatedButton.styleFrom(
                            primary: HexColor('#f44a82'),
                          ),
                          onPressed: _submitForm,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
