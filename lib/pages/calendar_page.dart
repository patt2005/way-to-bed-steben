import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:way_to_bed_steben/models/route.dart';
import 'package:way_to_bed_steben/models/route_event.dart';
import 'package:way_to_bed_steben/utils/app_provider.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class CustomCalendarPage extends StatefulWidget {
  const CustomCalendarPage({super.key});

  @override
  _CustomCalendarPageState createState() => _CustomCalendarPageState();
}

class _CustomCalendarPageState extends State<CustomCalendarPage> {
  String _selectedActivity = "";
  MapRoute? _selectedMapRoute;
  DateTime? _pickedDate;

  void _tryShowEventModal(BuildContext context, DateTime pickedDate) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final eventsForDate = provider.getRoutesForDate(pickedDate);

    if (eventsForDate.isEmpty && provider.userRoutes.isNotEmpty) {
      _showEventModal(context, pickedDate);
    } else {
      setState(() {
        _pickedDate = pickedDate;
      });
    }
  }

  void _showEventModal(BuildContext context, DateTime pickedDate) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16),
                height: screenSize.height * 0.45,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'ADD NEW EVENT',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Bayon",
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(),
                    const SizedBox(height: 20),
                    _buildActivitySelector(setState),
                    SizedBox(height: screenSize.height * 0.02),
                    _buildCreateEventButton(context, pickedDate),
                    SizedBox(height: screenSize.height * 0.05),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDropdown() {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<MapRoute>(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        items: provider.userRoutes
            .map(
              (mapRoute) => DropdownMenuItem(
                value: mapRoute,
                child: Text(mapRoute.routePoints.last.name),
              ),
            )
            .toList(),
        onChanged: (MapRoute? selectedRoute) {
          setState(() {
            _selectedMapRoute = selectedRoute;
          });
        },
        hint: const Text('Choose your route'),
      ),
    );
  }

  Widget _buildActivityCircle(StateSetter setState, Color color, String label) {
    bool isSelected = _selectedActivity == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActivity = label;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isSelected ? Colors.white : color,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySelector(StateSetter setState) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActivityCircle(setState, Colors.red, 'Weak'),
          _buildActivityCircle(setState, Colors.orange, 'So-so'),
          _buildActivityCircle(setState, Colors.green, 'Active'),
        ],
      ),
    );
  }

  Widget _buildCreateEventButton(BuildContext context, DateTime pickedDate) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_selectedActivity.isNotEmpty && _selectedMapRoute != null) {
            final provider = Provider.of<AppProvider>(context, listen: false);
            final activityColor = _getActivityColor(_selectedActivity);

            final newEvent = RouteEvent(
              date: pickedDate,
              routes: [_selectedMapRoute!],
              activityColor: activityColor,
              userId: provider.currentUser!.name,
            );

            provider.addEvent(newEvent);
            Navigator.of(context).pop();
            setState(() {});
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC900),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Create Event',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Color _getActivityColor(String activity) {
    switch (activity) {
      case 'Weak':
        return Colors.red;
      case 'So-so':
        return Colors.orange;
      case 'Active':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          RouteEvent? selectedEvent;
          if (_pickedDate != null) {
            var foundEvents =
                value.userEvents.where((e) => e.date == _pickedDate);
            selectedEvent = foundEvents.isEmpty ? null : foundEvents.first;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.4,
                  child: SfDateRangePicker(
                    backgroundColor: Colors.white,
                    view: DateRangePickerView.month,
                    selectionColor: Colors.transparent,
                    todayHighlightColor: Colors.purple,
                    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                      setState(() {
                        _pickedDate = dateRangePickerSelectionChangedArgs.value;
                      });
                      _tryShowEventModal(context, _pickedDate!);
                    },
                    cellBuilder: (context, cellDetails) {
                      final eventsForDate = value.userEvents
                          .where((e) =>
                              normalizeDate(e.date) ==
                              normalizeDate(cellDetails.date))
                          .toList();

                      final isSelected = _pickedDate != null &&
                          normalizeDate(_pickedDate!) ==
                              normalizeDate(cellDetails.date);

                      final isToday = normalizeDate(cellDetails.date) ==
                          normalizeDate(DateTime.now());
                      final eventColor = eventsForDate.isNotEmpty
                          ? eventsForDate.first.activityColor
                          : Colors.white;

                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isToday ? Colors.deepPurple : eventColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? Colors.deepPurple.withOpacity(
                                    0.6) // Border for selected cell
                                : Colors.transparent,
                            width:
                                2, // Slightly thicker border for better visibility
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cellDetails.date.day.toString(),
                          style: TextStyle(
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    },
                    headerStyle: const DateRangePickerHeaderStyle(
                      backgroundColor: Colors.white,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                selectedEvent == null
                    ? Container(
                        margin: EdgeInsets.only(top: screenSize.height * 0.1),
                        child: const Center(
                          child: Text("There are no events for this day yet."),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: value
                              .getRoutesForDate(_pickedDate!)
                              .map(
                                (route) => ListTile(
                                  title: Text(route.routePoints.last.name),
                                  leading: const Icon(Icons.route),
                                ),
                              )
                              .toList(),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
