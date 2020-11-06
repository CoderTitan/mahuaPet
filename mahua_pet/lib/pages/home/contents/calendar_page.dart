import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mahua_pet/styles/app_style.dart';
import 'package:mahua_pet/component/component.dart';
import '../request/calendar_request.dart';
import '../models/model_index.dart';
import '../views/view_index.dart';


class CalendarPage extends StatefulWidget {

  final int petId;

  CalendarPage({this.petId});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  CalendarController _calendarController = CalendarController();
  int _currentYear = 2020;
  int _currentMounth = 1;
  int _currentDay = 1;
  bool _isInit = false;

  Map<DateTime, List> _calendarList = {};
  List<RecordListModel> _dayRecords = [];
  List<CalendarFitModel> _dayFits = [];



  @override
  void initState() {
    super.initState();

    getCuttentDate();
    loadCalendarRecord();
    loadDayRecord();
    
    _isInit = true;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('日历记录'), elevation: 0),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: renderCalendar(),
          ),
          SliverToBoxAdapter(
            child: renderEmptyItem(),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 16.px),
            sliver: SliverToBoxAdapter(
              child: CalendarCardItem(cardModels: _dayRecords),
            ),
          ),
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) => CalendarFitItem(key: ValueKey(index), model: _dayFits[index]),
                childCount: _dayFits.length
              ),
            ),
          )
        ],
      ),
      floatingActionButton: RaisedButton(
        color: Colors.transparent,
        disabledColor: Colors.transparent,
        elevation: 16,
        child: Image.asset('${TKImages.image_path}tabbar_add.png', width: 37.px, height: 37.px),
        shape: CircleBorder(),
        onPressed: (){
          TKActionSheet.bottomSheet(context, GrowthAlert());
        }
      ),
    );
  }

  Widget renderCalendar() {
    return Container(
      color: TKColor.white,
      child: TableCalendar(
        calendarController: _calendarController,
        events: _calendarList,
        onDaySelected: daySelected,
        onUnavailableDaySelected: () => print('点击未来的日期'),
        onHeaderTapped: (date) => print('头部标题点击时间内'),
        onVisibleDaysChanged: (date1, date2, format) => print('$date1----$date2'),
        onCalendarCreated: (date1, date2, format) => print('onCalendarCreated---$date1----$date2'),
        startDay: DateTime(2019, 1, 1),
        endDay: DateTime.now(),
        availableCalendarFormats: {CalendarFormat.month: 'Month'},
        headerVisible: true,
        rowHeight: 45,
        startingDayOfWeek: StartingDayOfWeek.monday,
        dayHitTestBehavior: HitTestBehavior.opaque,
        availableGestures: AvailableGestures.horizontalSwipe,
        calendarStyle: CalendarStyle(
          weekdayStyle: TextStyle(color: TKColor.color_666666, fontSize: 14, fontWeight: FontWeight.w600),
          weekendStyle: TextStyle(color: TKColor.color_666666, fontSize: 14, fontWeight: FontWeight.w600),
          todayStyle: TextStyle(color: TKColor.white, fontSize: 14, fontWeight: FontWeight.w600),
          outsideStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
          outsideWeekendStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
          unavailableStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
          selectedColor: TKColor.color_f5ca2b,
          todayColor: TKColor.color_ffea9e,
          markersColor: Colors.orange,
          markersPositionBottom: 6.0,
          markersMaxAmount: 1,
          contentPadding: EdgeInsets.only(top: 10),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
          weekdayStyle: TextStyle(color: TKColor.color_cccccc, fontSize: 14, fontWeight: FontWeight.w600),
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
      ),
    );
  }

  Widget renderEmptyItem() {
    if (_dayRecords.length == 0 && _dayFits.length == 0) {
      return EmptyContent(
        offsetY: 24.px,
        showReload: false,
      );
    }
    return Container();
  }

  void getCuttentDate() {
    DateTime date = DateTime.now();
    _currentYear = date.year;
    _currentMounth = date.month;
    _currentDay = date.day;
  }

  void daySelected(DateTime dayTime, List events, List events2) {
    _currentYear = dayTime.year;
    _currentMounth = dayTime.month;
    _currentDay = dayTime.day;
    
    loadDayRecord();
  }

  /// 获取日历的记录天数
  void loadCalendarRecord() {
    CalendarRequest.loadCalendarRecord(widget.petId, _currentYear)
      .then((value) {
        final List<CalendarRecordModel> _models = value;
        Map<DateTime, List> _records = {};
        _models.forEach((element) {
          DateTime keyTime = DateTime.now();
          if (element.isRecord == '1' || element.isDiseaseRecord == '1') {
            keyTime = DateTime(int.parse(element.year), int.parse(element.month), int.parse(element.day));
            _records[keyTime] = [0];
          }
        });
        setState(() {
          _calendarList = _records;
        });
      }).catchError((e) {

      });
  }

  /// 获取某一天的记录
  void loadDayRecord() {
    if (_isInit) {
      TKToast.showLoading();
    }
    CalendarRequest.loadCurrentDayRecord(petId: widget.petId, year: _currentYear, month: _currentMounth, day: _currentDay)
      .then((value) {
        if (_isInit) {
          TKToast.dismiss();
        }
        
        List<RecordListModel> _cards = [];
        List<CalendarFitModel> _fits = [];

        List<dynamic> modelList = value;
        if (modelList.length >= 2) {
          _cards = modelList.first;
          _fits = modelList.last;
          _cards = _cards.where((element) {
            final newValue = element.value ?? '0';
            final valueList = newValue.split(',').toList()
                              .map((e) => int.parse(e)).toList()
                              .where((element) => element > 0).toList();
            return valueList.length > 0;
          }).toList();
        }
        
        setState(() {
          _dayRecords = _cards;
          _dayFits = _fits;
        });
      }).catchError((e) {
        TKToast.dismiss();
      });
  }
}