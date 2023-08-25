import 'package:bookd/models/user.dart';
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
import 'package:bookd/services/user_details.dart';

class FriendsProfile extends StatefulWidget {
  FriendsProfile(
      {super.key,
      required this.friend,
      required this.friendstatus,
      required this.followstatus});
  final Details friend;
  final String friendstatus;
  final String followstatus;

  @override
  State<FriendsProfile> createState() => _FriendsProfileState();
}

class _FriendsProfileState extends State<FriendsProfile> {
  final UserDetailsService userDetailsService = UserDetailsService();

  var c = 0;
  var a = 0;
  var b = 0;
  var p = 0;
  var r = 0;
  var s = 0;

  @override
  Widget build(context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.friend.username,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.friend.email,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.friend.phone,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  widget.friendstatus == "Respond"
                      ? ElevatedButton.icon(
                          onPressed: c == 0
                              ? () async {
                                  print(widget.friend.email);
                                  Navigator.of(context).push(
                                    ModalBottomSheetRoute(
                                        useSafeArea: true,
                                        builder: (context) {
                                          return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton.icon(
                                                    onPressed: () async {
                                                      http.Response eres =
                                                          await userDetailsService
                                                              .confirmFriends(
                                                                  email: widget
                                                                      .friend
                                                                      .email,
                                                                  friend: user
                                                                      .email);

                                                      http.Response fres =
                                                          await userDetailsService
                                                              .confirmFriends(
                                                                  email: user
                                                                      .email,
                                                                  friend: widget
                                                                      .friend
                                                                      .email);

                                                      http.Response hres =
                                                          await userDetailsService
                                                              .removefriendrequest(
                                                                  email: user
                                                                      .email,
                                                                  friend: widget
                                                                      .friend
                                                                      .email);

                                                      if (eres.statusCode == 200 &&
                                                          fres.statusCode ==
                                                              200 &&
                                                          hres.statusCode ==
                                                              200) {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Friend request accepted')));

                                                        http.Response lres =
                                                            await userDetailsService
                                                                .getNotify(
                                                                    email: user
                                                                        .email);

                                                        // List<dynamic> d = jsonDecode(lres.body);
                                                        // List<Autogenerated> f =
                                                        //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                        Provider.of<FriendProvider>(
                                                                context,
                                                                listen: false)
                                                            .setFriend(
                                                                lres.body);

                                                        setState(() {
                                                          c = 1;
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(Icons.task_alt),
                                                    label: Text('Confirm')),
                                                ElevatedButton.icon(
                                                    onPressed: () async {
                                                      http.Response hres =
                                                          await userDetailsService
                                                              .removefriendrequest(
                                                                  friend: widget
                                                                      .friend
                                                                      .email,
                                                                  email: user
                                                                      .email);

                                                      if (hres.statusCode ==
                                                          200) {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Friend request rejected')));

                                                        http.Response lres =
                                                            await userDetailsService
                                                                .getNotify(
                                                                    email: user
                                                                        .email);

                                                        // List<dynamic> d = jsonDecode(lres.body);
                                                        // List<Autogenerated> f =
                                                        //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                        Provider.of<FriendProvider>(
                                                                context,
                                                                listen: false)
                                                            .setFriend(
                                                                lres.body);

                                                        setState(() {
                                                          c = 2;
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                        Icons.cancel_outlined),
                                                    label: Text('Reject'))
                                              ]);
                                        },
                                        isScrollControlled: true),
                                  );
                                }
                              : c == 1
                                  ? a == 0
                                      ? () async {
                                          print(widget.friend.email);
                                          Navigator.of(context).push(
                                            ModalBottomSheetRoute(
                                                useSafeArea: true,
                                                builder: (context) {
                                                  return ElevatedButton.icon(
                                                      onPressed: () async {
                                                        http.Response hres =
                                                            await userDetailsService
                                                                .removefriend(
                                                                    friend: user
                                                                        .email,
                                                                    email: widget
                                                                        .friend
                                                                        .email);

                                                        http.Response gres =
                                                            await userDetailsService
                                                                .removefriend(
                                                                    friend: widget
                                                                        .friend
                                                                        .email,
                                                                    email: user
                                                                        .email);

                                                        if (hres.statusCode ==
                                                                200 &&
                                                            gres.statusCode ==
                                                                200) {
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      'Removed Friend')));
                                                          setState(() {
                                                            a = 1;
                                                          });
                                                        }
                                                      },
                                                      icon: Icon(
                                                          Icons.person_remove),
                                                      label: Text('UnFriend'));
                                                },
                                                isScrollControlled: true),
                                          );
                                        }
                                      : b == 0
                                          ? () async {
                                              print(widget.friend.email);

                                              http.Response hres =
                                                  await userDetailsService
                                                      .getFriends(
                                                          friend: user.email,
                                                          email: widget
                                                              .friend.email);

                                              if (hres.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Friend request sent')));

                                                http.Response lres =
                                                    await userDetailsService
                                                        .getNotify(
                                                            email: user.email);

                                                // List<dynamic> d = jsonDecode(lres.body);
                                                // List<Autogenerated> f =
                                                //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                Provider.of<FriendProvider>(
                                                        context,
                                                        listen: false)
                                                    .setFriend(lres.body);

                                                setState(() {
                                                  b = 1;
                                                });
                                              }
                                            }
                                          : () async {
                                              print(widget.friend.email);

                                              http.Response hres =
                                                  await userDetailsService
                                                      .removefriendrequest(
                                                          friend: user.email,
                                                          email: widget
                                                              .friend.email);

                                              if (hres.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Friend request cancelled')));

                                                http.Response lres =
                                                    await userDetailsService
                                                        .getNotify(
                                                            email: user.email);

                                                // List<dynamic> d = jsonDecode(lres.body);
                                                // List<Autogenerated> f =
                                                //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                Provider.of<FriendProvider>(
                                                        context,
                                                        listen: false)
                                                    .setFriend(lres.body);

                                                setState(() {
                                                  b = 0;
                                                });
                                              }
                                            }
                                  : b == 0
                                      ? () async {
                                          print(widget.friend.email);

                                          http.Response hres =
                                              await userDetailsService
                                                  .getFriends(
                                                      friend: user.email,
                                                      email:
                                                          widget.friend.email);

                                          if (hres.statusCode == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Friend request sent')));

                                            http.Response lres =
                                                await userDetailsService
                                                    .getNotify(
                                                        email: user.email);

                                            // List<dynamic> d = jsonDecode(lres.body);
                                            // List<Autogenerated> f =
                                            //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                            Provider.of<FriendProvider>(context,
                                                    listen: false)
                                                .setFriend(lres.body);

                                            setState(() {
                                              b = 1;
                                            });
                                          }
                                        }
                                      : () async {
                                          print(widget.friend.email);

                                          http.Response hres =
                                              await userDetailsService
                                                  .removefriendrequest(
                                                      friend: user.email,
                                                      email:
                                                          widget.friend.email);

                                          if (hres.statusCode == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Friend request cancelled')));

                                            http.Response lres =
                                                await userDetailsService
                                                    .getNotify(
                                                        email: user.email);

                                            // List<dynamic> d = jsonDecode(lres.body);
                                            // List<Autogenerated> f =
                                            //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                            Provider.of<FriendProvider>(context,
                                                    listen: false)
                                                .setFriend(lres.body);

                                            setState(() {
                                              b = 0;
                                            });
                                          }
                                        },
                          icon: c == 0
                              ? Icon(Icons.person_add_alt)
                              : c == 1
                                  ? a == 0
                                      ? Icon(Icons.task_alt)
                                      : b == 0
                                          ? Icon(Icons.person_add)
                                          : Icon(Icons.cancel)
                                  : b == 0
                                      ? Icon(Icons.person_add)
                                      : Icon(Icons.cancel),
                          label: c == 0
                              ? Text('Respond')
                              : c == 1
                                  ? a == 0
                                      ? Text('Friends')
                                      : b == 0
                                          ? Text('Add Friend')
                                          : Text('Cancel')
                                  : b == 0
                                      ? Text('Add Friend')
                                      : Text('Cancel'),
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStatePropertyAll(Size(100, 30))),
                        )
                      : widget.friendstatus == "Add Friend"
                          ? ElevatedButton.icon(
                              onPressed: p == 0
                                  ? () async {
                                      print(widget.friend.email);

                                      http.Response hres =
                                          await userDetailsService.getFriends(
                                              friend: user.email,
                                              email: widget.friend.email);

                                      if (hres.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Friend request sent')));

                                        http.Response lres =
                                            await userDetailsService.getNotify(
                                                email: user.email);

                                        // List<dynamic> d = jsonDecode(lres.body);
                                        // List<Autogenerated> f =
                                        //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                        Provider.of<FriendProvider>(context,
                                                listen: false)
                                            .setFriend(lres.body);

                                        setState(() {
                                          p = 1;
                                        });
                                      }
                                    }
                                  : () async {
                                      print(widget.friend.email);

                                      http.Response hres =
                                          await userDetailsService
                                              .removefriendrequest(
                                                  friend: user.email,
                                                  email: widget.friend.email);

                                      if (hres.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Friend request cancelled')));

                                        http.Response lres =
                                            await userDetailsService.getNotify(
                                                email: user.email);

                                        // List<dynamic> d = jsonDecode(lres.body);
                                        // List<Autogenerated> f =
                                        //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                        Provider.of<FriendProvider>(context,
                                                listen: false)
                                            .setFriend(lres.body);

                                        setState(() {
                                          p = 0;
                                        });
                                      }
                                    },
                              icon: p == 0
                                  ? Icon(Icons.person_add)
                                  : Icon(Icons.cancel),
                              label:
                                  p == 0 ? Text("Add Friend") : Text("Cancel"),
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(100, 30))),
                            )
                          : widget.friendstatus == "UnFriend"
                              ? ElevatedButton.icon(
                                  onPressed: a == 0
                                      ? () async {
                                          print(widget.friend.email);
                                          Navigator.of(context).push(
                                            ModalBottomSheetRoute(
                                                useSafeArea: true,
                                                builder: (context) {
                                                  return ElevatedButton.icon(
                                                      onPressed: () async {
                                                        http.Response hres =
                                                            await userDetailsService
                                                                .removefriend(
                                                                    friend: user
                                                                        .email,
                                                                    email: widget
                                                                        .friend
                                                                        .email);

                                                        http.Response gres =
                                                            await userDetailsService
                                                                .removefriend(
                                                                    friend: widget
                                                                        .friend
                                                                        .email,
                                                                    email: user
                                                                        .email);

                                                        if (hres.statusCode ==
                                                                200 &&
                                                            gres.statusCode ==
                                                                200) {
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      'Removed Friend')));
                                                          setState(() {
                                                            a = 1;
                                                          });
                                                        }
                                                      },
                                                      icon: Icon(
                                                          Icons.person_remove),
                                                      label: Text('UnFriend'));
                                                },
                                                isScrollControlled: true),
                                          );
                                        }
                                      : p == 0
                                          ? () async {
                                              print(widget.friend.email);

                                              http.Response hres =
                                                  await userDetailsService
                                                      .getFriends(
                                                          friend: user.email,
                                                          email: widget
                                                              .friend.email);

                                              if (hres.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Friend request sent')));

                                                http.Response lres =
                                                    await userDetailsService
                                                        .getNotify(
                                                            email: user.email);

                                                // List<dynamic> d = jsonDecode(lres.body);
                                                // List<Autogenerated> f =
                                                //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                Provider.of<FriendProvider>(
                                                        context,
                                                        listen: false)
                                                    .setFriend(lres.body);

                                                setState(() {
                                                  p = 1;
                                                });
                                              }
                                            }
                                          : () async {
                                              print(widget.friend.email);

                                              http.Response hres =
                                                  await userDetailsService
                                                      .removefriendrequest(
                                                          friend: user.email,
                                                          email: widget
                                                              .friend.email);

                                              if (hres.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Friend request cancelled')));

                                                http.Response lres =
                                                    await userDetailsService
                                                        .getNotify(
                                                            email: user.email);

                                                // List<dynamic> d = jsonDecode(lres.body);
                                                // List<Autogenerated> f =
                                                //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                Provider.of<FriendProvider>(
                                                        context,
                                                        listen: false)
                                                    .setFriend(lres.body);

                                                setState(() {
                                                  p = 0;
                                                });
                                              }
                                            },
                                  icon: a == 0
                                      ? Icon(Icons.task_alt_sharp)
                                      : p == 0
                                          ? Icon(Icons.person_add)
                                          : Icon(Icons.cancel),
                                  label: a == 0
                                      ? Text("Friends")
                                      : p == 0
                                          ? Text('Add Friend')
                                          : Text('Cancel'),
                                  style: ButtonStyle(
                                      minimumSize: MaterialStatePropertyAll(
                                          Size(100, 30))),
                                )
                              : widget.friendstatus == "Cancel"
                                  ? ElevatedButton.icon(
                                      onPressed: p == 0
                                          ? () async {
                                              print(widget.friend.email);

                                              http.Response hres =
                                                  await userDetailsService
                                                      .removefriendrequest(
                                                          friend: user.email,
                                                          email: widget
                                                              .friend.email);

                                              if (hres.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Friend request cancelled')));

                                                http.Response lres =
                                                    await userDetailsService
                                                        .getNotify(
                                                            email: user.email);

                                                // List<dynamic> d = jsonDecode(lres.body);
                                                // List<Autogenerated> f =
                                                //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                Provider.of<FriendProvider>(
                                                        context,
                                                        listen: false)
                                                    .setFriend(lres.body);

                                                setState(() {
                                                  p = 1;
                                                });
                                              }
                                            }
                                          : () async {
                                              print(widget.friend.email);

                                              http.Response hres =
                                                  await userDetailsService
                                                      .getFriends(
                                                          friend: user.email,
                                                          email: widget
                                                              .friend.email);

                                              if (hres.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Friend request sent')));

                                                http.Response lres =
                                                    await userDetailsService
                                                        .getNotify(
                                                            email: user.email);

                                                // List<dynamic> d = jsonDecode(lres.body);
                                                // List<Autogenerated> f =
                                                //     d.map<Autogenerated>(Autogenerated.fromJson).toList();
                                                Provider.of<FriendProvider>(
                                                        context,
                                                        listen: false)
                                                    .setFriend(lres.body);

                                                setState(() {
                                                  p = 0;
                                                });
                                              }
                                            },
                                      icon: p == 0
                                          ? Icon(Icons.cancel)
                                          : Icon(Icons.person_add),
                                      label: p == 0
                                          ? Text("Cancel")
                                          : Text("Add Friend"),
                                      style: ButtonStyle(
                                          minimumSize: MaterialStatePropertyAll(
                                              Size(100, 30))),
                                    )
                                  : SizedBox(),
                  Spacer(),
                  widget.followstatus == 'Follow'
                      ? ElevatedButton.icon(
                          onPressed: r == 0
                              ? () async {
                                  print("1");

                                  http.Response fres =
                                      await userDetailsService.addfollows(
                                          email: user.email,
                                          friend: widget.friend.email);

                                  if (fres.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Followed')));

                                    setState(() {
                                      r = 1;
                                    });
                                  }
                                }
                              : () async {
                                  print("2");

                                  http.Response fres =
                                      await userDetailsService.removefollows(
                                          email: user.email,
                                          friend: widget.friend.email);

                                  if (fres.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('UnFollowed')));

                                    setState(() {
                                      r = 0;
                                    });
                                  }
                                },
                          icon: r == 0
                              ? Icon(Icons.arrow_forward)
                              : Icon(Icons.arrow_back),
                          label: r == 0 ? Text("Follow") : Text("UnFollow"),
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStatePropertyAll(Size(100, 30))),
                        )
                      : widget.followstatus == 'UnFollow'
                          ? ElevatedButton.icon(
                              onPressed: s == 0
                                  ? () async {
                                      print("3");

                                      http.Response fres =
                                          await userDetailsService
                                              .removefollows(
                                                  email: user.email,
                                                  friend: widget.friend.email);

                                      if (fres.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('UnFollowed')));

                                        setState(() {
                                          s = 1;
                                        });
                                      }
                                    }
                                  : () async {
                                      print("4");

                                      http.Response fres =
                                          await userDetailsService.addfollows(
                                              email: user.email,
                                              friend: widget.friend.email);

                                      if (fres.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('Followed')));

                                        setState(() {
                                          s = 0;
                                        });
                                      }
                                    },
                              icon: s == 0
                                  ? Icon(Icons.arrow_back)
                                  : Icon(Icons.arrow_forward),
                              label: s == 0 ? Text("UnFollow") : Text("Follow"),
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(100, 30))),
                            )
                          : SizedBox()
                ],
              )
            ],
          )),
        ));
  }
}
