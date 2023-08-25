import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/login.dart';
import 'package:bookd/services/auth_services.dart';
import 'package:bookd/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookd/widgets/form_field.dart';
import 'package:bookd/widgets/button.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bookd/screens/email_verification.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  @override
  Widget build(context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              opacity: 0.8,
                              image: AssetImage(
                                  'assets/images/photography-city-lights-facebook-cover.jpg'),
                              fit: BoxFit.fill)),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 140),
                            CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  Color.fromARGB(255, 222, 221, 221),
                              child: Icon(Icons.person, size: 30),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              user.username,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              user.phone,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Booking Summary')
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
