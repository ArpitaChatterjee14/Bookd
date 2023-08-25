import 'dart:convert';
import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/friends_profile.dart';
import 'package:bookd/screens/login.dart';
import 'package:bookd/screens/profile.dart';
import 'package:bookd/services/auth_services.dart';
import 'package:bookd/services/user_details.dart';
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
import 'package:bookd/models/user.dart';

class Follows extends StatefulWidget {
  const Follows({super.key});

  @override
  State<Follows> createState() {
    return _Follows();
  }
}

class _Follows extends State<Follows> {
  final UserDetailsService userDetailsService = UserDetailsService();

  var widgetHolder;
  final _friend = TextEditingController();

  Widget success(List<Details> details) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 203, 161, 245)),
                backgroundBlendMode: BlendMode.screen,
                borderRadius: BorderRadius.zero,
                color: Color.fromARGB(255, 203, 161, 245),
                boxShadow: [
                  BoxShadow(
                      color:
                          Color.fromARGB(255, 203, 161, 245).withOpacity(0.7),
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      offset: Offset(0.0, 5.0))
                ]),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return FriendsProfile(
                      friend: details[index],
                      followstatus: "",
                      friendstatus: "",
                    );
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Color.fromARGB(255, 203, 161, 245).withOpacity(0.0),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(details[index].username),
                        Text(details[index].email)
                      ],
                    )
                  ]),
                ),
              ),
            ),
          );
        },
        itemCount: details.length,
      ),
    );
  }

  @override
  void initState() {
    widgetHolder = SizedBox();
    super.initState();
  }

  @override
  Widget build(context) {
    List<Details> details;
    var k;
    return Scaffold(
        appBar: AppBar(
          title: Text('Follows'),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Column(
              children: [
                TextField(
                  controller: _friend,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_add),
                      suffixIcon: IconButton(
                          onPressed: () async {
                            http.Response res = await userDetailsService
                                .getUser(username: _friend.text);

                            if (res.statusCode == 200) {
                              List<dynamic> lres = jsonDecode(res.body);
                              details =
                                  lres.map<Details>(Details.fromJson).toList();

                              setState(() {
                                k = true;
                                print(k);

                                widgetHolder = success(details);
                              });
                            }

                            if (res.statusCode != 200) {
                              setState(() {
                                k = false;
                                print(k);
                                widgetHolder = SizedBox();
                              });
                            }
                          },
                          icon: Icon(Icons.search)),
                      hintText: 'Search for Follows'),
                ),
                widgetHolder
              ],
            ))));
  }
}
