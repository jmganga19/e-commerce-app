import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/navigation.dart';
import '../home.dart';
import '../providers/user_provider.dart';
import '../widgets/loading.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password, _name;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: userProvider.status == Status.Authenticating
          ? const Loading()
          : SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Please make sure your email address is valid';
                            } else {
                              return null;
                            }
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.remove_red_eye)),
                            labelText: 'Password'),
                        obscureText: isVisible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The password field cannot be empty";
                          } else if (value.length < 6) {
                            return "the password has to be at least 6 characters long";
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        child: const Text('Sign up'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (!await userProvider.signUp(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('SignUp in failed')));
                            }
                            return;
                          }
                          changeScreenReplacement(context, const Home());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
