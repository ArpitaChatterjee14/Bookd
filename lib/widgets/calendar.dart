import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:bookd/models/booking_details.dart';
import 'package:bookd/models/user_details.dart';
import 'package:bookd/services/booking_services.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bookd/provider/login_data.dart';

class CalendarConfig extends StatefulWidget {
  const CalendarConfig({super.key});

  @override
  State<CalendarConfig> createState() => _CalendarConfigState();
}

class _CalendarConfigState extends State<CalendarConfig> {
  final BookingService bookingService = BookingService();

  DateTime? pickedDate;

  BookingDetails? bookingDetails;

  var widgetHolder;

  Color cardColor(String colorString) {
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false);
    });
    widgetHolder = initial();
    super.initState();
  }

  Widget initial() {
    var k;
    final today = DateTime.now();
    List<BookingDetails> booking;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              shadowColor: Color.fromARGB(255, 251, 205, 65),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: Color.fromARGB(255, 251, 205, 65),
                    )),
                child: CalendarDatePicker(
                  initialDate: today,
                  firstDate: DateTime(today.year - 10, today.month, today.day),
                  lastDate: DateTime(today.year + 10, today.month, today.day),
                  onDateChanged: (value) async {
                    pickedDate = value;

                    http.Response bres = await bookingService.showbooking(
                        startdate:
                            DateFormat('d MMM yyyy, EEEE').format(pickedDate!),
                        participants: user.email);

                    if (bres.statusCode == 200) {
                      List<dynamic> res = jsonDecode(bres.body);
                      booking = res
                          .map<BookingDetails>(BookingDetails.fromJson)
                          .toList();
                      print(booking);
                      setState(() {
                        k = true;
                        widgetHolder = success(booking);
                      });
                      print(k);
                    }

                    if (bres.statusCode == 404) {
                      setState(() {
                        k = false;
                        widgetHolder = nothing();
                      });
                      print(k);
                    }
                  },
                  currentDate: today,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 217, 214, 250),
                        ),
                        bottom: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 217, 214, 250),
                        ))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child: Row(
                        children: [
                          Text('Today'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          Text(DateFormat('d MMM yyyy, EEEE').format(today),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nothing() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    var k;
    final today = DateTime.now();
    List<BookingDetails> booking;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              shadowColor: Color.fromARGB(255, 251, 205, 65),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: Color.fromARGB(255, 251, 205, 65),
                    )),
                child: CalendarDatePicker(
                  initialDate: pickedDate!,
                  firstDate: DateTime(today.year - 10, today.month, today.day),
                  lastDate: DateTime(today.year + 10, today.month, today.day),
                  onDateChanged: (value) async {
                    pickedDate = value;

                    http.Response bres = await bookingService.showbooking(
                        startdate:
                            DateFormat('d MMM yyyy, EEEE').format(pickedDate!),
                        participants: user.email);

                    if (bres.statusCode == 200) {
                      List<dynamic> res = jsonDecode(bres.body);
                      booking = res
                          .map<BookingDetails>(BookingDetails.fromJson)
                          .toList();
                      print(booking);
                      setState(() {
                        k = true;
                        widgetHolder = success(booking);
                      });
                      print(k);
                    }

                    if (bres.statusCode == 404) {
                      setState(() {
                        k = false;
                        widgetHolder = nothing();
                      });
                      print(k);
                    }
                  },
                  currentDate: pickedDate,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 217, 214, 250),
                        ),
                        bottom: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 217, 214, 250),
                        ))),
                child: Column(
                  children: [
                    pickedDate!.day == today.day
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                            ),
                            child: Row(
                              children: [
                                Text('Today'),
                              ],
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          Text(
                              DateFormat('d MMM yyyy, EEEE')
                                  .format(pickedDate!),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget success(List<BookingDetails> booking) {
    var k;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final today = DateTime.now();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(children: [
          Material(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            shadowColor: Color.fromARGB(255, 251, 205, 65),
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    color: Color.fromARGB(255, 251, 205, 65),
                  )),
              child: CalendarDatePicker(
                initialDate: today,
                firstDate: DateTime(today.year - 10, today.month, today.day),
                lastDate: DateTime(today.year + 10, today.month, today.day),
                onDateChanged: (value) async {
                  pickedDate = value;

                  http.Response bres = await bookingService.showbooking(
                      startdate:
                          DateFormat('d MMM yyyy, EEEE').format(pickedDate!),
                      participants: user.email);

                  if (bres.statusCode == 200) {
                    List<dynamic> res = jsonDecode(bres.body);
                    booking = res
                        .map<BookingDetails>(BookingDetails.fromJson)
                        .toList();
                    print(booking);
                    setState(() {
                      k = true;
                      widgetHolder = success(booking);
                    });
                    print(k);
                  }

                  if (bres.statusCode == 404) {
                    setState(() {
                      k = false;
                      widgetHolder = nothing();
                    });
                    print(k);
                  }
                },
                currentDate: DateTime.now(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 217, 214, 250),
                      ),
                      bottom: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 217, 214, 250),
                      ))),
              child: Column(
                children: [
                  pickedDate!.day == today.day
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: Row(
                            children: [
                              Text('Today'),
                            ],
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Row(children: [
                      Text(DateFormat('d MMM yyyy, EEEE').format(pickedDate!),
                          style: TextStyle(fontSize: 20)),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              addRepaintBoundaries: false,
              addAutomaticKeepAlives: false,
              shrinkWrap: true,
              itemCount: booking.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: cardColor(booking[index].color)),
                      backgroundBlendMode: BlendMode.screen,
                      borderRadius: BorderRadius.circular(30),
                      color: cardColor(booking[index].color),
                      boxShadow: [
                        BoxShadow(
                            color: cardColor(booking[index].color)
                                .withOpacity(0.7),
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            offset: Offset(0.0, 5.0))
                      ]),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: cardColor(booking[index].color).withOpacity(0.0),
                    elevation: 0,
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  booking[index].title,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    '${booking[index].starttime} - ${booking[index].endtime}',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 107, 106, 106))),
                                SizedBox(
                                  width: 30,
                                ),
                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(booking[index].priority,
                                        style: TextStyle(
                                            color: booking[index].color ==
                                                    'Color(0xff86f59e)'
                                                ? cardColor(
                                                        booking[index].color)
                                                    .withGreen(170)
                                                : cardColor(
                                                        booking[index].color)
                                                    .withGreen(50))),
                                  ),
                                  color: cardColor(booking[index].color)
                                      .withOpacity(0.8),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  iconSize: 20,
                                  icon: Icon(Icons.edit_outlined,
                                      color:
                                          Color.fromARGB(255, 110, 110, 110)),
                                  style: ButtonStyle(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(booking[index].priority,
                                        style: TextStyle(
                                            color: booking[index].color ==
                                                    'Color(0xff86f59e)'
                                                ? cardColor(
                                                        booking[index].color)
                                                    .withGreen(170)
                                                : cardColor(
                                                        booking[index].color)
                                                    .withGreen(50))),
                                  ),
                                  color: cardColor(booking[index].color)
                                      .withOpacity(0.8),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        ]));
  }

  @override
  Widget build(context) {
    return widgetHolder;
  }
}
