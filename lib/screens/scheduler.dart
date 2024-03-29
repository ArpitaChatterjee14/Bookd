import 'dart:convert';
import 'package:bookd/models/user.dart';
import 'package:bookd/screens/follows.dart';
import 'package:bookd/screens/friends.dart';
import 'package:bookd/screens/friends_notify.dart';
import 'package:bookd/screens/notification.dart';
import 'package:bookd/screens/profile.dart';
import 'package:bookd/screens/search.dart';
import 'package:bookd/screens/settings.dart';
import 'package:bookd/screens/usual_booking.dart';
import 'package:bookd/services/user_details.dart';
import 'package:bookd/widgets/calendar.dart';
import 'package:bookd/widgets/meeting_manager.dart';
import 'package:flutter/material.dart';
import 'package:bookd/widgets/appbar.dart';
import 'package:bookd/services/booking_services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bookd/provider/login_data.dart';

class CalendarSchedule extends StatefulWidget {
  const CalendarSchedule({super.key});

  @override
  State<CalendarSchedule> createState() {
    return _CalendarSchedule();
  }
}

class _CalendarSchedule extends State<CalendarSchedule>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _startdate = TextEditingController();
  final _starttime = TextEditingController();
  final _enddate = TextEditingController();
  final _endtime = TextEditingController();
  final _title = TextEditingController();
  final BookingService bookingService = BookingService();
  final UserDetailsService friendService = UserDetailsService();

  void _startPickedDate(BuildContext context) async {
    var g = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10, DateTime.now().month,
            DateTime.now().day));

    _startdate.text = DateFormat('d MMM yyyy, EEEE').format(g!);
  }

  void _endPickedDate(BuildContext context) async {
    var h = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10, DateTime.now().month,
            DateTime.now().day));

    _enddate.text = DateFormat('d MMM yyyy, EEEE').format(h!);
  }

  void _startPickedTime(BuildContext context) async {
    var e = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    _starttime.text = e!.format(context);
  }

  void _endPickedTime(BuildContext context) async {
    var f = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    _endtime.text = f!.format(context);
  }

  int counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final user = Provider.of<UserProvider>(context).user;
    final friend = Provider.of<FriendProvider>(context).autogenerated;

    List<Details> details;

    final UserDetailsService userDetailsService = UserDetailsService();
    return Scaffold(
      drawer: Drawer(
        width: double.infinity * 0.5,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: Center(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Text('Menu',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.people,
                ),
                title: const Text('Friends and Follows'),
                onTap: () async {
                  http.Response res =
                      await userDetailsService.allFriends(email: user.email);

                  http.Response bres =
                      await userDetailsService.allFollows(email: user.email);
                  print(bres.body);

                  if (res.statusCode == 200 && bres.statusCode == 200) {
                    Provider.of<AllFriendProvider>(context, listen: false)
                        .setFriend(res.body);

                    Provider.of<AllFriendProvider>(context, listen: false)
                        .setFollow(bres.body);

                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return Friends();
                      },
                    ));
                  }
                }),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Profile();
                  },
                ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Settings();
                  },
                ));
              },
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        title: Text('Scheduler'),
        actions: [
          Row(children: [
            IconButton(
                onPressed: () async {
                  http.Response res = await userDetailsService.all();
                  final j = Provider.of<AllProvider>(context, listen: false)
                      .setFriend(res.body);

                  if (res.statusCode == 200) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Search();
                    }));
                  }
                },
                icon: Icon(Icons.search)),
            Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.person_add),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return FriendsNotify();
                        },
                      ));
                    }),
                // counter != 0 ?
                Positioned(
                  right: 2,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      // '$counter',
                      friend.friendRequests.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                // : new Container()
              ],
            ),
            Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Notifications();
                        },
                      ));
                    }),
                // counter != 0 ?
                new Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      // '$counter',
                      '10',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                // : new Container()
              ],
            )
          ]),
        ],
      ),
      body: CalendarConfig(),
      floatingActionButton: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: 1,
            child: child,
          );
        },
        child: FloatingActionButton(
          mini: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            showDialog(
              useSafeArea: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return SimpleDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    alignment: AlignmentDirectional.bottomEnd,
                    insetPadding: EdgeInsets.only(bottom: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    children: [
                      Container(
                          width: 20,
                          child: Column(
                            children: [
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(40.0),
                                            child: Column(children: [
                                              Text(
                                                'Quick Booking',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  SizedBox(width: 50),
                                                  Text(
                                                    'Start Time',
                                                  ),
                                                  SizedBox(width: 120),
                                                  Text('End Time')
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: Expanded(
                                                        child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              _startdate,
                                                          decoration:
                                                              InputDecoration(
                                                            prefixIcon:
                                                                IconButton(
                                                              icon: Icon(Icons
                                                                  .calendar_month),
                                                              onPressed:
                                                                  () async {
                                                                _startPickedDate(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _starttime,
                                                          decoration:
                                                              InputDecoration(
                                                            prefixIcon:
                                                                IconButton(
                                                              icon: Icon(Icons
                                                                  .lock_clock),
                                                              onPressed: () {
                                                                _startPickedTime(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    child: Expanded(
                                                        child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller: _enddate,
                                                          decoration:
                                                              InputDecoration(
                                                            prefixIcon:
                                                                IconButton(
                                                              icon: Icon(Icons
                                                                  .calendar_month),
                                                              onPressed:
                                                                  () async {
                                                                _endPickedDate(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          controller: _endtime,
                                                          decoration:
                                                              InputDecoration(
                                                            prefixIcon:
                                                                IconButton(
                                                              icon: Icon(Icons
                                                                  .lock_clock),
                                                              onPressed: () {
                                                                _endPickedTime(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 50),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: Expanded(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Booking Title'),
                                                            ],
                                                          ),
                                                          TextFormField(
                                                            controller: _title,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 50),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    print(user.email);
                                                    http.Response bookingRes =
                                                        await bookingService
                                                            .quickbooking(
                                                                startdate:
                                                                    _startdate
                                                                        .text,
                                                                enddate:
                                                                    _enddate
                                                                        .text,
                                                                starttime:
                                                                    _starttime
                                                                        .text,
                                                                endtime:
                                                                    _endtime
                                                                        .text,
                                                                title:
                                                                    _title.text,
                                                                participants:
                                                                    user.email);
                                                    print(bookingRes.body);
                                                    if (bookingRes.statusCode ==
                                                        200) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child:
                                                      Text('Create Booking')),
                                            ]),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromARGB(255, 255, 255, 255))),
                                  icon: Icon(Icons.hourglass_bottom,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  label: Text('Quick Booking')),
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return UsualSchedule();
                                      },
                                    ));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromARGB(255, 255, 255, 255))),
                                  icon: Icon(Icons.edit_calendar,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  label: Text(
                                    'Usual Booking',
                                  ))
                            ],
                          ))
                    ]);
              },
            );
          },
          elevation: 20,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: ButtonTheme(child: Icon(Icons.add)),
        ),
      ),
    );
  }
}
