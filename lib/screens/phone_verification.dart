import 'package:bookd/screens/login.dart';
import 'package:bookd/screens/register.dart';
import 'package:bookd/screens/verified.dart';
import 'package:bookd/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookd/widgets/button.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:bookd/provider/login_data.dart';
import 'package:bookd/services/auth_services.dart';
import 'package:http/http.dart' as http;

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() {
    return _PhoneVerification();
  }
}

class _PhoneVerification extends State<PhoneVerification> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  var _otp1 = '';
  var _otp2 = '';
  var _otp3 = '';
  var _otp4 = '';
  var _otp = '';

  void _submit({required String phone}) async {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return const Verified(
    //       opt: 'no',
    //     );
    //   },
    // ));
    // AssetsAudioPlayer.newPlayer().open(
    //   Audio("assets/audio/tap.wav"),
    //   autoStart: true,
    // );

    _formKey.currentState!.save();

    _otp = _otp1 + _otp2 + _otp3 + _otp4;

    print(_otp);

    if (_otp.length < 4) {
      return;
    }
    print(_otp);
    http.Response phoneValiid =
        await authService.phoneOtpValidation(phone: phone, otp: _otp);
    print(phoneValiid.body);

    if (phoneValiid.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const Verified(
            opt: 'no',
          );
        },
      ));
    }
  }

  @override
  Widget build(context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TopNavBar(category: 'Phone Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            SvgPicture.asset(
              'assets/images/phone-verification.svg',
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
                'We have sent the OTP Verification code to your Phone No.'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(child: Text(user.phone)),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: FormField(
                builder: (field) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 28,
                            width: 24,
                            child: Material(
                              elevation: 5,
                              color: Color.fromARGB(255, 249, 246, 246),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "0",
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (value) {
                                  _otp1 = value!;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 28,
                            width: 24,
                            child: Material(
                              elevation: 5,
                              color: Color.fromARGB(255, 249, 246, 246),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "0",
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (value) {
                                  _otp2 = value!;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 28,
                            width: 24,
                            child: Material(
                              elevation: 5,
                              color: Color.fromARGB(255, 249, 246, 246),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(hintText: "0"),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (value) {
                                  _otp3 = value!;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 28,
                            width: 24,
                            child: Material(
                              elevation: 5,
                              color: Color.fromARGB(255, 249, 246, 246),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(hintText: "0"),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (value) {
                                  _otp4 = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonConfig(
                        buttonVal: 'Verify',
                        nav: () {
                          _submit(phone: user.phone);
                        },
                        h: 50.0,
                        w: 200.0,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TextButtonConfig(
              buttonVal: "Didn't receive the code? Send Again",
              nav: () async {
                http.Response phoneRes =
                    await authService.phoneVerification(phone: user.phone);
                print(phoneRes.body);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
