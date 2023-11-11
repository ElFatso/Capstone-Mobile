import 'package:flutter/material.dart';

class HighlightedLanguages extends StatelessWidget {
  final List<dynamic> languagesList;
  final Color highlightColor;

  const HighlightedLanguages({
    Key? key,
    required this.languagesList,
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

    for (int i = 0; i < languagesList.length; i += 9) {
      var language1 = i < languagesList.length ? languagesList[i] : null;
      var language2 =
          i + 1 < languagesList.length ? languagesList[i + 1] : null;
      var language3 =
          i + 2 < languagesList.length ? languagesList[i + 2] : null;
      var language4 =
          i + 3 < languagesList.length ? languagesList[i + 3] : null;
      var language5 =
          i + 4 < languagesList.length ? languagesList[i + 4] : null;
      var language6 =
          i + 5 < languagesList.length ? languagesList[i + 5] : null;
      var language7 =
          i + 6 < languagesList.length ? languagesList[i + 6] : null;
      var language8 =
          i + 7 < languagesList.length ? languagesList[i + 7] : null;
      var language9 =
          i + 8 < languagesList.length ? languagesList[i + 8] : null;

      if (language1 != null && language1['name'] is String) {
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
                  language1['name'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              if (language2 != null && language2['name'] is String)
                const SizedBox(width: 8),
              if (language2 != null && language2['name'] is String)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    language2['name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              if (language3 != null && language3['name'] is String)
                const SizedBox(width: 8),
              if (language3 != null && language3['name'] is String)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    language3['name'],
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

      if (language4 != null && language4['name'] is String) {
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
                  language4['name'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              if (language5 != null && language5['name'] is String)
                const SizedBox(width: 8),
              if (language5 != null && language5['name'] is String)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    language5['name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              if (language6 != null && language6['name'] is String)
                const SizedBox(width: 8),
              if (language6 != null && language6['name'] is String)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    language6['name'],
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

      if (language7 != null && language7['name'] is String) {
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
                  language7['name'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              if (language8 != null && language8['name'] is String)
                const SizedBox(width: 8),
              if (language8 != null && language8['name'] is String)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    language8['name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              if (language9 != null && language9['name'] is String)
                const SizedBox(width: 8),
              if (language9 != null && language9['name'] is String)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    language9['name'],
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
