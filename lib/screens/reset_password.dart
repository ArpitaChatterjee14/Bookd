import 'package:bookd/screens/forgot_password.dart';
import 'package:bookd/screens/login.dart';
import 'package:bookd/screens/register.dart';
import 'package:bookd/screens/scheduler.dart';
import 'package:bookd/widgets/appbar.dart';
import 'package:bookd/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookd/widgets/button.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:http/http.dart' as http;
import 'package:bookd/services/auth_services.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  State<ResetPassword> createState() {
    return _ResetPassword();
  }
}

class _ResetPassword extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  var _password = '';
  var _confirmPassword = '';

  void _submit({required String email}) async {
    final isValid = _formKey.currentState!.validate();

    // AssetsAudioPlayer.newPlayer().open(
    //   Audio("assets/audio/tap.wav"),
    //   autoStart: true,
    // );

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    http.Response resetPassword =
        await authService.resetpassword(email: email, password: _password);
    print(resetPassword.statusCode);

    if (resetPassword.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return LoginForm();
        },
      ));
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TopNavBar(category: 'Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/forgot-password.svg',
                height: 200,
                width: double.infinity,
              ),
              Text(
                  'Please enter new password. It should be different from old password'),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: FormField(
                  builder: (field) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InputFieldConfig(
                          image: Icons.password,
                          inputVal: 'New Password',
                          hide: false,
                          fieldType: null,
                          validation: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter valid Email or UserName';
                            }
                            return null;
                          },
                          saved: (newValue) {
                            _password = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputFieldConfig(
                          image: Icons.password,
                          inputVal: 'Confirm Password',
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
                            _confirmPassword = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // const SizedBox(height: 10),
                        ButtonConfig(
                          buttonVal: 'Submit',
                          nav: () {
                            _submit(email: widget.email);
                          },
                          h: 50.0,
                          w: 200.0,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
