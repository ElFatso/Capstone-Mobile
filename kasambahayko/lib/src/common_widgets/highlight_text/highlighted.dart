import 'package:flutter/material.dart';

class Highlighted extends StatelessWidget {
  final List<dynamic> servicesList;
  final Color highlightColor;

  const Highlighted({
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
                const SizedBox(width: 8),
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
        } else {
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

        if (service3 != null &&
            service3['service_name'] is String &&
            service4 != null &&
            service4['service_name'] is String) {
          paragraph.add(const SizedBox(height: 8));
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
                    service3['service_name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
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
              ],
            ),
          );
        } else if (service3 != null) {
          paragraph.add(const SizedBox(height: 8));
          paragraph.add(
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
          );
        }
      }
    }

    return paragraph;
  }
}
