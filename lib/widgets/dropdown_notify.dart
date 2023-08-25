import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton].///
class Notify {
  Notify(this.name, this.icon);
  final String name;
  final Icon icon;
}

final List<Notify> notify = [
  Notify(
      'In app notification',
      const Icon(
        Icons.notifications,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Notify(
      'Text message',
      const Icon(
        Icons.message,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Notify(
      'Mail',
      const Icon(
        Icons.mail,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Notify(
      'Whatsapp',
      const Icon(
        Icons.wechat,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Notify(
      'Call',
      const Icon(
        Icons.call,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Notify(
      'All',
      const Icon(
        Icons.all_out,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
];

class DropdownNotifyButtonExample extends StatefulWidget {
  const DropdownNotifyButtonExample({super.key, required this.onTap});

  final void Function(Notify items) onTap;

  @override
  State<DropdownNotifyButtonExample> createState() =>
      _DropdownNotifyButtonExampleState();
}

class _DropdownNotifyButtonExampleState
    extends State<DropdownNotifyButtonExample> {
  Notify item = notify.first;

  void getDropDownItem(Notify selected) {
    widget.onTap(selected);
    setState(() {
      item = selected;
      // print(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Notify>(
      borderRadius: BorderRadius.circular(20),
      icon: const Icon(Icons.arrow_drop_down),
      value: item,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      onChanged: (selected) {
        // This is called when the user selects an item.
        getDropDownItem(selected!);
      },
      items: notify.map<DropdownMenuItem<Notify>>((Notify value) {
        return DropdownMenuItem<Notify>(
          value: value,
          child: Row(
            children: [
              value.icon,
              SizedBox(
                width: 10,
              ),
              Text(
                value.name,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
