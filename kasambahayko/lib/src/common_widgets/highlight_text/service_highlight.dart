import 'package:flutter/material.dart';

class HighlightedService extends StatelessWidget {
  final List<dynamic> servicesList;
  final Color highlightColor;

  const HighlightedService({
    Key? key,
    required this.servicesList,
    required this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildParagraph(context),
    );
  }

  List<Widget> _buildParagraph(BuildContext context) {
    List<Widget> paragraph = [];

    for (int i = 0; i < servicesList.length; i += 4) {
      var service1 = servicesList[i];
      var service2 = i + 1 < servicesList.length ? servicesList[i + 1] : null;
      var service3 = i + 2 < servicesList.length ? servicesList[i + 2] : null;
      var service4 = i + 3 < servicesList.length ? servicesList[i + 3] : null;

      if (service1['service_name'] is String) {
        if (service2 != null && service2['service_name'] is String) {
          // Group service1, service2, and service3 in a row
          paragraph.add(
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    service1['service_name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                    width:
                        8), // Horizontal spacing between service1 and service2
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    service2['service_name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                if (service3 != null && service3['service_name'] is String)
                  const SizedBox(
                      width:
                          8), // Horizontal spacing between service2 and service3
                if (service3 != null && service3['service_name'] is String)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: highlightColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      service3['service_name'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
              ],
            ),
          );
        } else {
          // Only service1 is available
          paragraph.add(
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                service1['service_name'],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          );
        }

        if (service4 != null && service4['service_name'] is String) {
          // Group service4 below the row
          paragraph.add(const SizedBox(height: 8));
          paragraph.add(
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                service4['service_name'],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          );
        }
      } else if (service1['service_name'] == null) {
        // Handle cases with only two services
        paragraph.add(
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  service2['service_name'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }
    }

    return paragraph;
  }
}
