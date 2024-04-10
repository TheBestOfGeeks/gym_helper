import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/settings/service_locator.dart';
import '../bloc/calendar_bloc.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final EventController calendarController;

  @override
  void initState() {
    super.initState();
    calendarController = EventController();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: calendarController,
      child: BlocProvider(
        create: (context) =>
            CalendarBloc(workoutRepo: ServiceLocator.workoutRepo),
        child: Scaffold(
          body: MonthView(
            showBorder: true,
            borderSize: 0,
            useAvailableVerticalSpace: true,
            weekDayBuilder: weekDayConverter,
            onCellTap: (events, date) {
              CalendarEventData event = CalendarEventData(
                date: date,
                title: 'Test',
              );
              calendarController.add(event);
            },
          ),
        ),
      ),
    );
  }

  Widget weekDayConverter(int day) {
    switch (day) {
      case 0:
        return const Text('Пн');
      case 1:
        return const Text('Вт');
      case 2:
        return const Text('Ср');
      case 3:
        return const Text('Чт');
      case 4:
        return const Text('Пт');
      case 5:
        return const Text('Сб');
      case 6:
        return const Text('Вс');
      default:
        return const Text('');
    }
  }
}
