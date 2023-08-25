import 'package:bookd/screens/scheduler.dart';
import 'package:bookd/widgets/calendar.dart';
import 'package:bookd/widgets/dropdown_notify.dart';
import 'package:bookd/widgets/dropdown_priority.dart';
import 'package:bookd/widgets/meeting_manager.dart';
import 'package:flutter/material.dart';
import 'package:bookd/widgets/appbar.dart';
import 'package:bookd/services/booking_services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:bookd/widgets/dropdown_visibility.dart';

class UsualSchedule extends StatefulWidget {
  const UsualSchedule({super.key});

  @override
  State<UsualSchedule> createState() {
    return _UsualSchedule();
  }
}

class _UsualSchedule extends State<UsualSchedule> {
  final _startdate = TextEditingController();
  final _starttime = TextEditingController();
  final _enddate = TextEditingController();
  final _endtime = TextEditingController();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _participant = TextEditingController();
  final BookingService bookingService = BookingService();
  late Notify _notify;
  late Priority _priority;
  late Visibily _visibily;
  Widget _widgetholder = SizedBox();

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
    var e =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    _starttime.text = e!.format(context);
  }

  void _endPickedTime(BuildContext context) async {
    var f =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    _endtime.text = f!.format(context);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TopNavBar(category: 'New Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
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
                          controller: _startdate,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(Icons.calendar_month),
                              onPressed: () async {
                                _startPickedDate(context);
                              },
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _starttime,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(Icons.lock_clock),
                              onPressed: () {
                                _startPickedTime(context);
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
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(Icons.calendar_month),
                              onPressed: () async {
                                _endPickedDate(context);
                              },
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _endtime,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(Icons.lock_clock),
                              onPressed: () {
                                _endPickedTime(context);
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
                              Text('Booking Title'),
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
              Row(
                children: [
                  Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Booking Description'),
                            ],
                          ),
                          TextFormField(
                            controller: _description,
                          )
                        ],
                      ),
                    ),
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
                              Text('Visibility'),
                            ],
                          ),
                          Row(
                            children: [
                              DropdownVisibilyButtonExample(
                                onTap: (items) {
                                  _visibily = items;
                                  print(_visibily.name);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
                              Text('Participants'),
                            ],
                          ),
                          Stack(children: [
                            TextFormField(
                              controller: _participant,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _widgetholder = value.contains(
                                          'arpitachatterjee47@gmail.com')
                                      ? InputChip(
                                          selected: true,
                                          onDeleted: () {},
                                          deleteIcon: Icon(Icons.cancel),
                                          selectedColor: Color.fromARGB(
                                              255, 161, 244, 204),
                                          elevation: 0,
                                          label: Text(
                                              'arpitachatterjee47@gmail.com'))
                                      : SizedBox();
                                });
                              },
                            ),
                            _widgetholder
                          ])
                        ],
                      ),
                    ),
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
                              Text('Priority'),
                            ],
                          ),
                          Row(
                            children: [
                              DropdownPriorityButtonExample(
                                onTap: (items) {
                                  _priority = items;
                                  print(_priority.name);
                                  print(_priority.icon.color);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
                              Text('Notify In'),
                            ],
                          ),
                          Row(
                            children: [
                              DropdownNotifyButtonExample(
                                onTap: (items) {
                                  _notify = items;
                                  print(_notify.name);
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 50),
                          ElevatedButton(
                              onPressed: () async {
                                http.Response bookingRes =
                                    await bookingService.usualbooking(
                                        startdate: _startdate.text,
                                        enddate: _enddate.text,
                                        starttime: _starttime.text,
                                        endtime: _endtime.text,
                                        title: _title.text,
                                        description: _description.text,
                                        visibility: _visibily.name,
                                        participants: _participant.text,
                                        priority: _priority.name,
                                        notify: _notify.name,
                                        color: _priority.icon.color.toString());
                                print(bookingRes.body);
                                if (bookingRes.statusCode == 200) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return CalendarSchedule();
                                  }));
                                  // print(bookingRes.body);
                                }
                              },
                              child: Text('Create Booking'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
