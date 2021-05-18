import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/client.dart';

Future<DateTime?> showDateTimePicker(BuildContext context,
    TextEditingController dateTimeController, Client client) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 6 * 30)),
  ).then((date) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (date != null && time != null) {
        DateTime nextSession = new DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        dateTimeController.text =
            DateFormat.yMMMMEEEEd().add_Hm().format(nextSession);
      }
    });
  });
}
