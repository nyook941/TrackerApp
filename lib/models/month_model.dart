import 'package:intl/intl.dart';

class Month {
  int monthIndex;
  String monthName;
  int year;

  Month(DateTime dateTime)
      : monthIndex = dateTime.month,
        monthName = DateFormat.MMMM().format(dateTime),
        year = dateTime.year;

  void incrementMonth() {
    monthIndex++;
    if (monthIndex > 12) {
      monthIndex = 1;
      year++;
    }
    monthName = DateFormat.MMMM().format(DateTime(year, monthIndex));
  }

  void decrementMonth() {
    monthIndex--;
    if (monthIndex < 1) {
      monthIndex = 12;
      year--;
    }
    monthName = DateFormat.MMMM().format(DateTime(year, monthIndex));
  }

  int daysInMonth({bool previous = false}) {
    DateTime firstDayNextMonth;
    if (previous) {
      if (monthIndex > 1) {
        firstDayNextMonth = DateTime(year, monthIndex, 1);
      } else {
        firstDayNextMonth = DateTime(year - 1, 12, 1);
      }
      var lastDayPreviousMonth =
          firstDayNextMonth.subtract(const Duration(days: 1));
      return lastDayPreviousMonth.day;
    } else {
      firstDayNextMonth = (monthIndex < 12)
          ? DateTime(year, monthIndex + 1, 1)
          : DateTime(year + 1, 1, 1);
      var lastDayCurrentMonth =
          firstDayNextMonth.subtract(const Duration(days: 1));
      return lastDayCurrentMonth.day;
    }
  }

  int getFirstDayIndex() {
    DateTime firstDayOfMonth = DateTime(year, monthIndex, 1);
    int firstDayIndex = (firstDayOfMonth.weekday %
        7); // Sunday is 0, Monday is 1, ..., Saturday is 6
    return firstDayIndex;
  }

  int getLastDayIndex() {
    DateTime lastDayOfMonth = DateTime(year, monthIndex, daysInMonth());
    int lastDayIndex = (lastDayOfMonth.weekday %
        7); // Sunday is 0, Monday is 1, ..., Saturday is 6
    return lastDayIndex;
  }

  int getAmountOfWeeks() {
    // Get the first and last day of the month
    DateTime firstDayOfMonth = DateTime(year, monthIndex, 1);
    DateTime lastDayOfMonth = DateTime(year, monthIndex, daysInMonth());

    // Calculate the weekday of the first day of the month
    int firstWeekday = firstDayOfMonth.weekday % 7; // Sunday is 0

    // Calculate the total number of days in the month
    int totalDays = lastDayOfMonth.day;

    // Calculate the number of days in the first week and the remaining days
    int daysInFirstWeek = 7 - firstWeekday;
    int remainingDays = totalDays - daysInFirstWeek;

    // Calculate the number of full weeks in the remaining days
    int fullWeeks = (remainingDays / 7).ceil();

    // Total number of weeks is the first week + full weeks
    return 1 + fullWeeks;
  }

  int date(int week, int day) {
    int firstDayIndex = getFirstDayIndex();
    int date = week * 7 + day - firstDayIndex + 1;

    if (date <= 0) {
      // Previous month dates
      int previousMonthDays = daysInMonth(previous: true);
      return previousMonthDays + date;
    } else if (date > daysInMonth()) {
      // Next month dates
      return date - daysInMonth();
    } else {
      // Current month dates
      return date;
    }
  }

  bool inMonth(int week, int day) {
    int firstDayIndex = getFirstDayIndex();
    int date = week * 7 + day - firstDayIndex + 1;

    return date > 0 && date <= daysInMonth();
  }

  int tense(int week, int day) {
    DateTime today = DateTime.now();
    int firstDayIndex = getFirstDayIndex();

    int date = week * 7 + day - firstDayIndex + 1;
    DateTime targetDate;

    if (date <= 0) {
      // Previous month dates
      targetDate =
          DateTime(year, monthIndex - 1, daysInMonth(previous: true) + date);
    } else if (date > daysInMonth()) {
      // Next month dates
      targetDate = DateTime(year, monthIndex + 1, date - daysInMonth());
    } else {
      // Current month dates
      targetDate = DateTime(year, monthIndex, date);
    }

    if (targetDate.year == today.year &&
        targetDate.month == today.month &&
        targetDate.day == today.day) {
      return 0; // Present
    } else if (targetDate.isBefore(today)) {
      return -1; // Past
    } else {
      return 1; // Future
    }
  }

  String getDate(int week, int day) {
    int daysInPrevMonth = daysInMonth(previous: true);
    int daysInCurrentMonth = daysInMonth();
    int firstDayIndex = getFirstDayIndex();

    int date = week * 7 + day - firstDayIndex + 1;
    DateTime targetDate;

    if (date <= 0 || (!inMonth(week, day) && tense(week, day) == -1)) {
      // Previous month dates
      if (monthIndex == 1) {
        targetDate = DateTime(year - 1, 12, daysInPrevMonth + date);
      } else {
        targetDate = DateTime(year, monthIndex - 1, daysInPrevMonth + date);
      }
    } else if (date > daysInCurrentMonth) {
      // Next month dates
      if (monthIndex == 12) {
        targetDate = DateTime(year + 1, 1, date - daysInCurrentMonth);
      } else {
        targetDate = DateTime(year, monthIndex + 1, date - daysInCurrentMonth);
      }
    } else {
      // Current month dates
      targetDate = DateTime(year, monthIndex, date);
    }
    return "${targetDate.month.toString().padLeft(2, '0')}/${targetDate.day.toString().padLeft(2, '0')}/${targetDate.year}";
  }
}
