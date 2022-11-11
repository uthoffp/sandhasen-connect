import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension MyDates on DateTime {

  String get toGermanDateFormat => DateFormat('dd.MM.yyyy').format(this);

  String get toGermanDateFormatWithDay => DateFormat('EEEE, dd.MM.yyyy').format(this);

  String get toGermanDateFormatWithTime => DateFormat('dd.MM.yyyy, HH:mm').format(this);

  String get toMonthYearFormat => DateFormat("MMMM yyyy").format(this);

  String get toTime => DateFormat("HH:mm").format(this);

  DateTime setTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}