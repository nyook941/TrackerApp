import 'package:flutter/material.dart';
import 'package:poop_tracker/main.dart';
import 'package:poop_tracker/models/entry_map_model.dart';
import 'package:poop_tracker/models/month_model.dart';

class CalendarTacker extends StatefulWidget {
  const CalendarTacker({super.key});

  @override
  State<CalendarTacker> createState() => _CalendarTackerState();
}

class _CalendarTackerState extends State<CalendarTacker> {
  Month currentMonth = Month(DateTime.now());
  EntryMap entryMap = EntryMap();

  void _incrementMonth() {
    setState(() {
      currentMonth.incrementMonth();
    });
  }

  void _decrementMonth() {
    setState(() {
      currentMonth.decrementMonth();
    });
  }

  void _addEntry(
      {String? description,
      String? image,
      int? value,
      List<String>? properties,
      required String date}) {
    setState(() {
      entryMap.add(
          description: description,
          image: image,
          value: value,
          properties: properties,
          date: date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: const Color(0xFF444554),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CalendarHeader(
              currentMonth: currentMonth,
              onPreviousMonth: _decrementMonth,
              onNextMonth: _incrementMonth,
            ),
            const SizedBox(
              height: 8,
            ),
            Calendar(
              currentMonth: currentMonth,
              entryMap: entryMap,
              onAddEntry: _addEntry, // Pass the function reference here
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarHeader extends StatefulWidget {
  final Month currentMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const CalendarHeader(
      {required this.currentMonth,
      required this.onNextMonth,
      required this.onPreviousMonth,
      super.key});

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                widget.onPreviousMonth();
              });
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        Text("${widget.currentMonth.monthName} Poops",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500)),
        IconButton(
            onPressed: () {
              setState(() {
                widget.onNextMonth();
              });
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white)),
      ],
    );
  }
}

class Calendar extends StatefulWidget {
  final Month currentMonth;
  final EntryMap entryMap;
  final void Function(
      {String? description,
      String? image,
      int? value,
      List<String>? properties,
      required String date}) onAddEntry;

  const Calendar(
      {required this.currentMonth,
      required this.entryMap,
      required this.onAddEntry,
      super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final List<String> dayNames = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF62606B),
      ),
      width: double.maxFinite,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: dayNames.map((dayName) {
                return Expanded(
                  child: Text(
                    dayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            Column(
                children: List.generate(
                    widget.currentMonth.getAmountOfWeeks(),
                    (i) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            7,
                            (j) => Stamp(
                                currentMonth: widget.currentMonth,
                                entryMap: widget.entryMap,
                                week: i,
                                onAddEntry: widget.onAddEntry,
                                day: j)))))
          ])),
    );
  }
}

class Stamp extends StatefulWidget {
  final Month currentMonth;
  final void Function(
      {String? description,
      String? image,
      int? value,
      List<String>? properties,
      required String date}) onAddEntry;
  final int week;
  final int day;
  final int date;
  final bool inMonth;
  final int tense;
  final EntryMap entryMap;
  final List<Entry>? entries;
  final bool pressable;

  Stamp(
      {required this.currentMonth,
      required this.week,
      required this.day,
      required this.entryMap,
      required this.onAddEntry,
      super.key})
      : entries = entryMap.getEntries(currentMonth.getDate(week, day)),
        inMonth = currentMonth.inMonth(week, day),
        tense = currentMonth.tense(week, day),
        date = currentMonth.date(week, day),
        pressable = currentMonth.tense(week, day) < 1;

  @override
  State<Stamp> createState() => _StampState();
}

class _StampState extends State<Stamp> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(children: [
        Column(children: [
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: widget.pressable
                ? () {
                    Navigator.pushNamed(context, '/entry', arguments: {});
                  }
                : () {},
            onDoubleTap: widget.pressable
                ? () {
                    setState(() {
                      widget.onAddEntry(
                          date: widget.currentMonth
                              .getDate(widget.week, widget.day));
                    });
                  }
                : () {},
            child: Container(
              decoration: BoxDecoration(
                  color: !widget.inMonth ||
                          (widget.entries == null && widget.tense == 0) ||
                          widget.tense == 1
                      ? const Color(0xFFBFACB5).withOpacity(0.5)
                      : const Color(0xFFBFACB5),
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: widget.tense == 1
                      ? const SizedBox(height: 28, width: 28) // Outcome D
                      : (widget.tense == -1 && widget.entries == null)
                          ? Opacity(
                              opacity: widget.inMonth ? 1 : 0.5,
                              child: const Image(
                                image: AssetImage('assets/images/sad_poop.png'),
                                width: 28,
                              ),
                            ) // Outcome B
                          : (widget.tense == 0 && widget.entries == null)
                              ? const Icon(Icons.add,
                                  color: Colors.white, size: 28) // Outcome C
                              : (widget.tense < 1 && widget.entries != null)
                                  ? Opacity(
                                      opacity: widget.inMonth ? 1 : 0.5,
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/happy_poop.png'),
                                        width: 28,
                                      ),
                                    ) // Outcome A
                                  : null),
            ),
          ),
          Text(
            "${widget.date}",
            style: TextStyle(
                color: widget.inMonth
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                fontSize: 12),
          )
        ]),
        Positioned(
            top: 5,
            right: 2,
            child: Opacity(
              opacity: widget.tense > 0 || widget.entries == null
                  ? 0
                  : widget.inMonth
                      ? 1
                      : 0.5,
              child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${widget.entries?.length}",
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  )),
            )),
      ]),
    );
  }
}
