import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timeago/timeago.dart' as timeago;

class OfferHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> timelineEvents;

  const OfferHistoryScreen({
    Key? key,
    required this.timelineEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: EmployerTheme.theme,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Offer History',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 8),
                    for (var eventMap in timelineEvents)
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        indicatorStyle: IndicatorStyle(
                          width: 50,
                          height: 50,
                          indicator: ClipOval(
                            child: Image.network(
                              eventMap['profile_url'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        endChild: Container(
                          constraints: const BoxConstraints(
                            minHeight: 120,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${eventMap['user']} ${eventMap['action']}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const Divider(
                                    color: greycolor,
                                    thickness: 1,
                                  ),
                                  Text(
                                    formatTimestamp(eventMap['timestamp']),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return timeago.format(
      dateTime,
      locale: 'en',
      allowFromNow: true,
      clock: DateTime.now(),
    );
  }
}
