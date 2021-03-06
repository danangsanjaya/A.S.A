import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';
import '../widgets/calendar/activity_calendar.dart';
import '../widgets/calendar/activity_calendar_list.dart';

import '../../providers/main_calendar_provider.dart';

class MainCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: sizes.height(context) / 20),
            padding:
                EdgeInsets.symmetric(horizontal: sizes.width(context) / 20),
            child: Consumer<MainCalendarProvider>(
              builder: (_, mcProvider, __) => ActivityCalendar(
                onDaySelected: (date, activity) {
                  if (activity.isEmpty || activity == null) {
                    mcProvider.setSelectedListAndDateActivity(
                      selectedActivity: [],
                      dateSelectedActivityItem: date,
                    );
                    return null;
                  }
                  mcProvider.setSelectedListAndDateActivity(
                    dateSelectedActivityItem: date,
                    selectedActivity: activity,
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.25,
                  color:
                      colorPallete.bottomTitleMainCalendarDynamicColor(context),
                ),
              ),
            ),
            child: Consumer<MainCalendarProvider>(
              builder: (_, mcProvider, __) {
                final yearMonthDayFormat =
                    DateFormat.yMMMMd(appConfig.indonesiaLocale)
                        .format(mcProvider.dateSelectedActivityItem);
                return Text(
                  yearMonthDayFormat,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: colorPallete
                        .bottomTitleMainCalendarDynamicColor(context),
                  ),
                );
              },
            ),
          ),
          Consumer<MainCalendarProvider>(
            builder: (_, mcProvider, __) => ActivityCalendarList(
              selectedActivity: mcProvider.selectedActivityItem,
              dateActivity: mcProvider.dateSelectedActivityItem,
            ),
          ),
        ],
      ),
    );
  }
}
