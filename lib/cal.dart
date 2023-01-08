// import 'package:calander/widgets/showcal.dart';
import 'package:flutter/material.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:intl/intl.dart';
import './widgets/calendar.dart';

bool open = false;
bool openmonth = false;
int inputmonth = 0;
int inputdate = 0;
String inputyear = '';
String ddd = '';

enum CalendarViews { dates, months, year }

class Cal extends StatefulWidget {
  const Cal({super.key});

  @override
  State<Cal> createState() => _CalState();
}

class _CalState extends State<Cal> {
  @override
  void dispose() {
    super.dispose();
  }

  void showcalfun() {
    setState(() {
      open = !open;
    });
  }

  late DateTime _currentDateTime;
  late DateTime _selectedDateTime;
  late List<Calendar> _sequentialDates;
  late int midYear;
  CalendarViews _currentView = CalendarViews.dates;
  final List<String> _weekDays = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN'
  ];
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> years = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2029',
    '2030',
  ];
  String dropdownvalue = 'January';
  String dropdownvalueyear = '2023';
  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    _sequentialDates = [];
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }

  Widget _calendarBody() {
    if (_sequentialDates == null) return Container();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _sequentialDates.length + 7,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisCount: 7,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        if (index < 7) return _weekDayTitle(index);
        if (_sequentialDates[index - 7].date == _selectedDateTime) {
          inputdate = _sequentialDates[index - 7].date.day;
          return _selector(_sequentialDates[index - 7]);
        }
        return _calendarDates(_sequentialDates[index - 7]);
      },
    );
  }

  Widget _datesView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // prev month button
            // _toggleBtn(false),
            // month and year

            Visibility(
              visible: true,
              child: Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _monthNames.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        _currentDateTime =
                            DateTime(_currentDateTime.year, index + 1);
                        _getCalendar();
                        setState(
                          () => _currentView = CalendarViews.dates,
                        );
                        inputmonth = index + 1;
                      },
                      title: Center(
                        child: Text(
                          _monthNames[index],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: years.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      _currentDateTime =
                          DateTime(_currentDateTime.year, index + 1);
                      _getCalendar();
                      setState(() => _currentView = CalendarViews.dates);
                      inputyear = years[index];
                    },
                    title: Center(
                      child: Text(
                        years[index],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: InkWell(
            //     onTap: () =>
            //         setState(() => _currentView = CalendarViews.months),
            //     child: Center(
            //       child: Text(
            //         '${_monthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
            //         style: const TextStyle(
            //             color: Color.fromARGB(255, 15, 15, 15),
            //             fontSize: 18,
            //             fontWeight: FontWeight.w700),
            //       ),
            //     ),
            //   ),
            // ),
            // next month button
            // _toggleBtn(true),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: Colors.white,
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: _calendarBody(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                print(inputdate);
                print(inputmonth);
                print(inputyear);
                ddd =
                    "${inputdate.toString().padLeft(2, '0')}/${inputmonth.toString().padLeft(2, '0')}/${inputyear.toString()}";
                print(ddd);
                setState(() {
                  open = !open;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(ddd),
                    );
                  },
                );
              },
              child: const Text("OK"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  open = !open;
                });
              },
              child: const Text("Cancel"),
            )
          ],
        )
      ],
    );
  }

  // next / prev month buttons
  // Widget _toggleBtn(bool next) {
  //   return InkWell(
  //     onTap: () {
  //       if (_currentView == CalendarViews.dates) {
  //         setState(() => (next) ? _getNextMonth() : _getPrevMonth());
  //       } else if (_currentView == CalendarViews.year) {
  //         if (next) {
  //           midYear =
  //               (midYear == null) ? _currentDateTime.year + 9 : midYear + 9;
  //         } else {
  //           midYear =
  //               (midYear == null) ? _currentDateTime.year - 9 : midYear - 9;
  //         }
  //         setState(() {});
  //       }
  //     },
  //     child: Container(
  //       alignment: Alignment.center,
  //       width: 50,
  //       height: 50,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(25),
  //           border: Border.all(color: Colors.white),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.white.withOpacity(0.5),
  //               offset: Offset(3, 3),
  //               blurRadius: 3,
  //               spreadRadius: 0,
  //             ),
  //           ],
  //           gradient: LinearGradient(
  //             colors: [Colors.black, Colors.black.withOpacity(0.1)],
  //             stops: [0.5, 1],
  //             begin: Alignment.bottomRight,
  //             end: Alignment.topLeft,
  //           )),
  //       child: Icon(
  //         (next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  // calendar

  // calendar header
  Widget _weekDayTitle(int index) {
    return Text(
      _weekDays[index],
      style:
          const TextStyle(color: Color.fromARGB(255, 19, 19, 19), fontSize: 12),
    );
  }

  // calendar element
  Widget _calendarDates(Calendar calendarDate) {
    return InkWell(
      onTap: () {
        if (_selectedDateTime != calendarDate.date) {
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }
          setState(() => _selectedDateTime = calendarDate.date);
        }
      },
      child: Center(
          child: Text(
        '${calendarDate.date.day}',
        style: const TextStyle(
          color: Color.fromARGB(255, 18, 18, 17),
        ),
      )),
    );
  }

  // date selector
  Widget _selector(Calendar calendarDate) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white, width: 4),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.1), Colors.white],
          stops: const [0.1, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '${calendarDate.date.day}',
            style: const TextStyle(
                color: Color.fromARGB(255, 39, 38, 38),
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  // show months list
  // Widget _showMonthsList() {
  //   return Column(
  //     children: <Widget>[
  //       InkWell(
  //         onTap: () => setState(() => _currentView = CalendarViews.year),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Text(
  //             '${_currentDateTime.year}',
  //             style: const TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w700,
  //                 color: Color.fromARGB(255, 28, 27, 27)),
  //           ),
  //         ),
  //       ),
  //       const Divider(
  //         color: Colors.white,
  //       ),
  //       Expanded(
  //         child: ListView.builder(
  //           padding: EdgeInsets.zero,
  //           itemCount: _monthNames.length,
  //           itemBuilder: (context, index) => ListTile(
  //             onTap: () {
  //               _currentDateTime = DateTime(_currentDateTime.year, index + 1);
  //               _getCalendar();
  //               setState(() => _currentView = CalendarViews.dates);
  //             },
  //             title: Center(
  //               child: Text(
  //                 _monthNames[index],
  //                 style: const TextStyle(
  //                   fontSize: 18,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // years list views
  // Widget _yearsView(int midYear) {
  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         children: const <Widget>[
  //           // _toggleBtn(false),
  //           Spacer(),
  //           // _toggleBtn(true),
  //         ],
  //       ),
  //       Expanded(
  //         child: GridView.builder(
  //             shrinkWrap: true,
  //             itemCount: 9,
  //             physics: const NeverScrollableScrollPhysics(),
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 3,
  //             ),
  //             itemBuilder: (context, index) {
  //               int thisYear;
  //               if (index < 4) {
  //                 thisYear = midYear - (4 - index);
  //               } else if (index > 4) {
  //                 thisYear = midYear + (index - 4);
  //               } else {
  //                 thisYear = midYear;
  //               }
  //               return ListTile(
  //                 onTap: () {
  //                   _currentDateTime =
  //                       DateTime(thisYear, _currentDateTime.month);
  //                   _getCalendar();
  //                   setState(() => _currentView = CalendarViews.months);
  //                 },
  //                 title: Text(
  //                   '$thisYear',
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               );
  //             }),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("calender")),
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Select Date"),
                const Text(
                    'Make sure that the selected date is highlighted with white color and press ok to display the entered date'),
                const SizedBox(height: 4),
                SizedBox(
                  height: 700,
                  width: 500,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: dateinput,
                        inputFormatters: [
                          MaskInputFormatter(mask: '##/##/####'),
                        ],
                        onTap: () {},
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                            ),
                            onPressed: showcalfun,
                          ),
                          border: const OutlineInputBorder(),
                          hintText: "dd/mm/yyyy",
                        ),
                      ),
                      Text(ddd),
                      Visibility(
                        visible: open,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height * 0.7,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 212, 212),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: _datesView(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
