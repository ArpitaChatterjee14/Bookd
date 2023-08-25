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

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() {
    return _Friends();
  }
}

class _Friends extends State<Friends> {
  final UserDetailsService userDetailsService = UserDetailsService();

  var widgetHolder;
  final _friend = TextEditingController();

  // Widget success(List<Details> details, Allfriend allfriend) {
  //   return Column(mainAxisSize: MainAxisSize.min, children: [
  //     Flexible(
  //         child: ListView(
  //             shrinkWrap: true,
  //             children: details
  //                 .map(
  //                   (e) => Container(
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                         border: Border.all(
  //                             color: Color.fromARGB(255, 203, 161, 245)),
  //                         backgroundBlendMode: BlendMode.screen,
  //                         borderRadius: BorderRadius.all(Radius.zero),
  //                         color: Color.fromARGB(255, 203, 161, 245),
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Color.fromARGB(255, 203, 161, 245)
  //                                   .withOpacity(0.7),
  //                               blurRadius: 5,
  //                               spreadRadius: 0.5,
  //                               offset: Offset(0.0, 5.0))
  //                         ]),
  //                     child: InkWell(
  //                       onTap: () {
  //                         Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (context) {
  //                             return FriendsProfile(
  //                               friend: e,
  //                               confirm: false,
  //                             );
  //                           },
  //                         ));
  //                       },
  //                       child: Card(
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(30)),
  //                         color: Color.fromARGB(255, 219, 195, 243)
  //                             .withOpacity(0.0),
  //                         elevation: 0,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(12.0),
  //                           child: Row(children: [
  //                             CircleAvatar(
  //                               backgroundColor: Colors.grey,
  //                               child: Icon(Icons.person),
  //                             ),
  //                             Spacer(),
  //                             Column(
  //                               children: [Text(e.username), Text(e.email)],
  //                             )
  //                           ]),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                 .toList()
  //               ..addAll(
  //                 allfriend.friends.map(
  //                   (e) => Container(
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                         border: Border.all(
  //                             color: Color.fromARGB(255, 203, 161, 245)),
  //                         backgroundBlendMode: BlendMode.screen,
  //                         borderRadius: BorderRadius.all(Radius.zero),
  //                         color: Color.fromARGB(255, 203, 161, 245),
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Color.fromARGB(255, 203, 161, 245)
  //                                   .withOpacity(0.7),
  //                               blurRadius: 5,
  //                               spreadRadius: 0.5,
  //                               offset: Offset(0.0, 5.0))
  //                         ]),
  //                     child: InkWell(
  //                       onTap: () {},
  //                       child: Card(
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(30)),
  //                         color: Color.fromARGB(255, 219, 195, 243)
  //                             .withOpacity(0.0),
  //                         elevation: 0,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(12.0),
  //                           child: Row(children: [
  //                             CircleAvatar(
  //                               backgroundColor: Colors.grey,
  //                               child: Icon(Icons.person),
  //                             ),
  //                             Spacer(),
  //                             Column(
  //                               children: [Text(e)],
  //                             )
  //                           ]),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )))
  //   ]);
  // }

  Widget friends({required bool follow}) {
    final allfriend =
        Provider.of<AllFriendProvider>(context, listen: false).allfriend;
    final allfollow =
        Provider.of<AllFriendProvider>(context, listen: false).allfollow;

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
              onTap: () {},
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
                        follow == true
                            ? Text(allfollow.follows[index])
                            : Text(allfriend.friends[index])
                      ],
                    )
                  ]),
                ),
              ),
            ),
          );
        },
        itemCount: follow == true
            ? allfollow.follows.length
            : allfriend.friends.length,
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AllFriendProvider>(context, listen: false);
    });

    widgetHolder = friends(follow: false);

    super.initState();
  }

  var c = true;

  @override
  Widget build(context) {
    List<Details> details;
    final allfriend = Provider.of<AllFriendProvider>(context).allfriend;

    return Scaffold(
        appBar: AppBar(
          title: Text('Friends and Follows'),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: _friend,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.search)),
                        hintText: 'Search for friends and follows'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  c == true
                      ? Row(
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 220, 188, 247)),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(150, double.infinity))),
                                child: Text('Friends'),
                                onPressed: () {
                                  print(c);
                                }),
                            Spacer(),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 255, 255, 255)),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(150, double.infinity))),
                                child: Text('Follows'),
                                onPressed: () async {
                                  setState(() {
                                    c = !c;
                                    widgetHolder = friends(follow: true);
                                  });

                                  print(c);
                                })
                          ],
                        )
                      : Row(
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 255, 255, 255)),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(150, double.infinity))),
                                child: Text('Friends'),
                                onPressed: () {
                                  setState(() {
                                    c = !c;
                                    widgetHolder = friends(follow: false);
                                  });

                                  print(c);
                                }),
                            Spacer(),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 220, 188, 247)),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(150, double.infinity))),
                                child: Text('Follows'),
                                onPressed: () {
                                  print(c);
                                })
                          ],
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  widgetHolder
                ],
              ),
            )));
  }
}
