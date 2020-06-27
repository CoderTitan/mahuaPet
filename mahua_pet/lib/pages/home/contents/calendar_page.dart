import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mahua_pet/styles/app_style.dart';

class CalendarPage extends StatelessWidget {

  static const rooteName = '/calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('日历记录'), elevation: 0),
      body: CalendarContent()
    );
  }
}

class CalendarContent extends StatefulWidget {
  @override
  _CalendarContentState createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent> {

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            events: {DateTime.now(): [0]},
            onDaySelected: (dayTime, event) => print('dayTime = $dayTime'),
            onUnavailableDaySelected: null,
            startDay: DateTime(2019, 1, 1),
            endDay: DateTime.now(),
            availableCalendarFormats: {CalendarFormat.month: 'Month'},
            headerVisible: true,
            rowHeight: 45,
            startingDayOfWeek: StartingDayOfWeek.monday,
            dayHitTestBehavior: HitTestBehavior.opaque,
            availableGestures: AvailableGestures.horizontalSwipe,
            // simpleSwipeConfig: SimpleSwipeConfig(),
            calendarStyle: CalendarStyle(
              weekdayStyle: TextStyle(color: TKColor.color_666666, fontSize: 14, fontWeight: FontWeight.w600),
              weekendStyle: TextStyle(color: TKColor.color_666666, fontSize: 14, fontWeight: FontWeight.w600),
              todayStyle: TextStyle(color: TKColor.white, fontSize: 14, fontWeight: FontWeight.w600),
              outsideStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
              outsideWeekendStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
              unavailableStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
              selectedColor: TKColor.color_f5ca2b,
              todayColor: TKColor.color_ffea9e,
              markersColor: TKColor.white,
              markersPositionBottom: 6.0,
              markersMaxAmount: 1,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
              weekdayStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
              // dowTextBuilder: (date, locale) => DateFormat.E(locale).format(date)[0],
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonShowsNext: true,
              // titleTextBuilder: (date, locale) => DateFormat.yM(locale).format(date),
              titleTextStyle: TextStyle(fontSize: 19.px, color: TKColor.color_333333, fontWeight: FontWeight.bold),
              formatButtonTextStyle: TextStyle(fontSize: 19.px, color: TKColor.color_333333, fontWeight: FontWeight.bold),
              leftChevronMargin: EdgeInsets.only(left: 60.px),
              rightChevronMargin: EdgeInsets.only(right: 60.px),
              leftChevronIcon: Icon(Icons.arrow_left, color: TKColor.color_333333, size: 40),
              rightChevronIcon: Icon(Icons.arrow_right, color: TKColor.color_333333, size: 40),
              decoration: BoxDecoration(color: TKColor.main_color)
            ),
          )
        ],
      )
    );
  }
}