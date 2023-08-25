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

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings> {
  @override
  Widget build(context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.manage_accounts),
                      label: Text('Accounts and Profiles')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.lock_person),
                      label: Text('Personal details')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.manage_accounts),
                      label: Text('Password and security')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.file_copy),
                      label: Text('Your information and permissions')),
                ],
              )
            ],
          ),
        ));
  }
}
