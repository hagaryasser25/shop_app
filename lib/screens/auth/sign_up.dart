import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/consts/my_colors.dart';
import 'package:shop_app/services/global_methods.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  int _phoneNumber;
  File _pickedImage;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FocusNode myFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  GlobalMethods _globalMethods = new GlobalMethods();
  bool _isLoading = false;

  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
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
        await _auth.createUserWithEmailAndPassword(
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

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: HexColor('#ffcfbc'),
                        backgroundImage: _pickedImage == null
                            ? null
                            : FileImage(_pickedImage),
                      )),
                  Positioned(
                      top: 120,
                      left: 120,
                      child: SizedBox(
                        width: 50,
                        child: RawMaterialButton(
                            // constraints: BoxConstraints.tight(const Size(45, 45)),
                            elevation: 10,
                            fillColor: HexColor('#FA8072'),
                            child: const Align(
                                // ignore: unnecessary_const
                                child: Icon(Icons.add_a_photo,
                                    color: Colors.white, size: 22)),
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Choose option',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: HexColor('#FA8072'))),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                                onTap: _pickImageGallery,
                                                splashColor:
                                                    HexColor('#FA8072'),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(Icons.image,
                                                          color: HexColor(
                                                              '#FA8072')),
                                                    ),
                                                    Text('Gallery',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title,
                                                        ))
                                                  ],
                                                )),
                                            InkWell(
                                                onTap: _pickImageCamera,
                                                splashColor:
                                                    HexColor('#FA8072'),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(Icons.camera,
                                                          color: HexColor(
                                                              '#FA8072')),
                                                    ),
                                                    Text('Camera',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title,
                                                        ))
                                                  ],
                                                )),
                                            InkWell(
                                                onTap: _remove,
                                                splashColor:
                                                    HexColor('#FA8072'),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                          Icons.remove_circle,
                                                          color: HexColor(
                                                              '#FA8072')),
                                                    ),
                                                    Text('Remove',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title,
                                                        ))
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ))
                ],
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: const ValueKey('name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'name cannot be null';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1, color: HexColor('#e7e7e7')),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1, color: HexColor('#FA8072')),
                          ),
                          filled: true,
                          prefixIcon:
                              Icon(Icons.person, color: HexColor('#e7e7e7')),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                              color: myFocusNode.hasFocus
                                  ? Colors.black
                                  : Colors.black),
                          fillColor: Colors.white,
                        ),
                        onSaved: (value) {
                          _fullName = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          key: const ValueKey('email'),
                          focusNode: _emailFocusNode,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: HexColor('#e7e7e7')),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: HexColor('#FA8072')),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          key: const ValueKey('password'),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: HexColor('#e7e7e7')),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          key: const ValueKey('phone number'),
                          focusNode: _phoneNumberFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _submitForm,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: HexColor('#e7e7e7')),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: HexColor('#FA8072')),
                            ),
                            filled: true,
                            prefixIcon: Icon(Icons.phone_android,
                                color: HexColor('#e7e7e7')),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Colors.black
                                    : Colors.black),
                            fillColor: Colors.white,
                          ),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child:  ElevatedButton(
                            child: const Text('Sign Up'),
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('#FA8072'),
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
      ),
    );
  }
}
