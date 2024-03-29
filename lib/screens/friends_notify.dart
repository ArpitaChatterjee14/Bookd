import 'dart:convert';
import 'dart:math';
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

class FriendsNotify extends StatefulWidget {
  const FriendsNotify({super.key});

  @override
  State<FriendsNotify> createState() {
    return _FriendsNotify();
  }
}

class _FriendsNotify extends State<FriendsNotify> {
  final UserDetailsService userDetailsService = UserDetailsService();
  @override
  Widget build(context) {
    final friend = Provider.of<FriendProvider>(context).autogenerated;
    final all = Provider.of<AllProvider>(context, listen: false).details;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Details> details;
    return Scaffold(
        appBar: AppBar(
          title: Text('Friend Requests'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: friend.friendRequests.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 3),
                          child: ListTile(
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              tileColor: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6),
                              title: Text(
                                  'You have a new friend request: ${friend.friendRequests[index].toString()}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Yesterday'),
                                ],
                              ),
                              leading: Material(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        color: Colors.white, width: 2)),
                                elevation: 0,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Color.fromARGB(255, 222, 221, 221),
                                  child: Icon(Icons.person, size: 30),
                                ),
                              ),
                              onTap: () async {
                                print(friend.friendRequests[index].toString());
                                http.Response bres =
                                    await userDetailsService.checkstatus(
                                        email: user.email,
                                        friend: friend.friendRequests[index]
                                            .toString());
                                print(jsonDecode(bres.body)["msg"]);

                                if (jsonDecode(bres.body)["msg"] ==
                                        "Follow & Confirm or Reject" ||
                                    jsonDecode(bres.body)["msg"] ==
                                        "UnFollow & Confirm or Reject") {
                                  if (jsonDecode(bres.body)["msg"] ==
                                      "UnFollow & Confirm or Reject") {
                                    http.Response res =
                                        await userDetailsService.getFriend(
                                            email: friend.friendRequests[index]
                                                .toString());

                                    if (res.statusCode == 200) {
                                      List<dynamic> lres = jsonDecode(res.body);

                                      details = lres
                                          .map<Details>(Details.fromJson)
                                          .toList();

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return FriendsProfile(
                                            friend: details[0],
                                            followstatus: "UnFollow",
                                            friendstatus: "Respond",
                                          );
                                        },
                                      ));
                                    }
                                  }
                                  http.Response res =
                                      await userDetailsService.getFriend(
                                          email: friend.friendRequests[index]
                                              .toString());

                                  if (res.statusCode == 200) {
                                    List<dynamic> lres = jsonDecode(res.body);

                                    details = lres
                                        .map<Details>(Details.fromJson)
                                        .toList();

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return FriendsProfile(
                                          friend: details[0],
                                          followstatus: "Follow",
                                          friendstatus: "Respond",
                                        );
                                      },
                                    ));
                                  }
                                }
                                ;
                              }));
                    }),
              ),
            ],
          ),
        ));
  }
}
