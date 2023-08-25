import 'dart:convert';
import 'package:bookd/models/allfriend.dart';
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

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() {
    return _Search();
  }
}

class _Search extends State<Search> {
  final UserDetailsService userDetailsService = UserDetailsService();

  var widgetHolder;
  final _friend = TextEditingController();

  Widget success() {
    final all = Provider.of<AllProvider>(context, listen: false).details;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 203, 161, 245)),
                backgroundBlendMode: BlendMode.screen,
                borderRadius: BorderRadius.all(Radius.zero),
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
              onTap: () async {
                http.Response bres = await userDetailsService.checkstatus(
                    email: user.email, friend: all[index].email);

                if (jsonDecode(bres.body)["msg"] == "Follow & Add Friend" ||
                    jsonDecode(bres.body)["msg"] == "UnFollow & Add Friend") {
                  if (jsonDecode(bres.body)["msg"] == "UnFollow & Add Friend") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "UnFollow",
                          friendstatus: "Add Friend");
                    }));
                  }

                  if (jsonDecode(bres.body)["msg"] == "Follow & Add Friend") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "Follow",
                          friendstatus: "Add Friend");
                    }));
                  }
                }

                if (jsonDecode(bres.body)["msg"] == "Follow & Cancel" ||
                    jsonDecode(bres.body)["msg"] == "UnFollow & Cancel") {
                  if (jsonDecode(bres.body)["msg"] == "UnFollow & Cancel") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "UnFollow",
                          friendstatus: "Cancel");
                    }));
                  }
                  if (jsonDecode(bres.body)["msg"] == "Follow & Cancel") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "Follow",
                          friendstatus: "Cancel");
                    }));
                  }
                }

                if (jsonDecode(bres.body)["msg"] ==
                        "Follow & Confirm or Reject" ||
                    jsonDecode(bres.body)["msg"] ==
                        "UnFollow & Confirm or Reject") {
                  if (jsonDecode(bres.body)["msg"] ==
                      "UnFollow & Confirm or Reject") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "UnFollow",
                          friendstatus: "Respond");
                    }));
                  }
                  if (jsonDecode(bres.body)["msg"] ==
                      "Follow & Confirm or Reject") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "Follow",
                          friendstatus: "Respond");
                    }));
                  }
                }

                if (jsonDecode(bres.body)["msg"] == "Follow & UnFriend" ||
                    jsonDecode(bres.body)["msg"] == "UnFollow & UnFriend") {
                  print(jsonDecode(bres.body)["msg"]);
                  if (jsonDecode(bres.body)["msg"] == "UnFollow & UnFriend") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "UnFollow",
                          friendstatus: "UnFriend");
                    }));
                  }
                  if (jsonDecode(bres.body)["msg"] == "Follow & UnFriend") {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FriendsProfile(
                          friend: all[index],
                          followstatus: "Follow",
                          friendstatus: "UnFriend");
                    }));
                  }
                }
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
                      children: [Text(all[index].email)],
                    )
                  ]),
                ),
              ),
            ),
          );
        },
        itemCount: all.length,
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AllProvider>(context, listen: false);
    });

    widgetHolder = success();

    super.initState();
  }

  @override
  Widget build(context) {
    List<Details> details;

    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
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
                              http.Response res = await UserDetailsService()
                                  .getUser(username: _friend.text);

                              print(jsonDecode(res.body)[0]);

                              if (res.statusCode == 200) {
                                setState(() {
                                  widgetHolder = success();
                                });
                              }
                            },
                            icon: Icon(Icons.search)),
                        hintText: 'Search...'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widgetHolder
                ],
              ),
            )));
  }
}
