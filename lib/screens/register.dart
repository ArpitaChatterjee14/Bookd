import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/login.dart';
import 'package:bookd/services/auth_services.dart';
import 'package:bookd/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookd/widgets/form_field.dart';
import 'package:bookd/widgets/button.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bookd/screens/email_verification.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() {
    return _RegisterForm();
  }
}

class _RegisterForm extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  var _userName = '';
  var _phone = '';
  var _password = '';
  var _email = '';

  void _submit() async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const EmailVerification();
    // }));

    final isValid = _formKey.currentState!.validate();

    // AssetsAudioPlayer.newPlayer().open(
    //   Audio("assets/audio/tap.wav"),
    //   autoStart: true,
    // );

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    http.Response res = await authService.registerUser(
        email: _email, phone: _phone, password: _password, username: _userName);
    print(res.body);

    Provider.of<UserProvider>(context, listen: false).setUser(res.body);

    if (res.statusCode == 200) {
      http.Response emailRes =
          await authService.emailVerification(email: _email);

      if (emailRes.statusCode == 200) {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const EmailVerification();
        }));
      }
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TopNavBar(category: 'Create an account'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/sign-up-form.svg',
                  height: 200,
                  width: double.infinity,
                ),
                Form(
                    key: _formKey,
                    child: FormField(
                      builder: (field) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InputFieldConfig(
                              image: Icons.person,
                              inputVal: 'UserName',
                              hide: false,
                              fieldType: TextInputType.name,
                              validation: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter valid UserName';
                                }
                                return null;
                              },
                              saved: (newValue) {
                                _userName = newValue!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputFieldConfig(
                              image: Icons.email,
                              inputVal: 'Email',
                              hide: false,
                              fieldType: TextInputType.emailAddress,
                              validation: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter valid Email';
                                }
                                return null;
                              },
                              saved: (newValue) {
                                _email = newValue!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputFieldConfig(
                              image: Icons.phone,
                              inputVal: 'Phone',
                              hide: false,
                              fieldType: TextInputType.phone,
                              validation: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Please enter valid Phone Number';
                                }
                                return null;
                              },
                              saved: (newValue) {
                                _phone = newValue!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputFieldConfig(
                              image: Icons.password,
                              inputVal: 'Password',
                              hide: true,
                              fieldType: null,
                              validation: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim().length < 6) {
                                  return 'Please enter password with atleast 6 characters';
                                }
                                return null;
                              },
                              saved: (newValue) {
                                _password = newValue!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonConfig(
                              buttonVal: 'Continue',
                              nav: _submit,
                              h: 50.0,
                              w: 200.0,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextButtonConfig(
                              buttonVal: "Already have an account? Login",
                              nav: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginForm();
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      },
                    ))
              ],
            ),
          ),
        ));
  }
}
