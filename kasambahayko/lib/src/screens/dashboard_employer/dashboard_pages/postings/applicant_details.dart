import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/language_highlight.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/service_highlight.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/status_highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/profile_page/document_details.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

class ApplicantDetailsScreen extends StatelessWidget {
  final String profileUrl;
  final String lastName;
  final String firstName;
  final String rate;
  final String city;
  final String verified;
  final String bio;
  final String availability;
  final String distance;
  final String experience;
  final List<dynamic> servicesList;
  final List<dynamic> languagesList;
  final List<dynamic> documents;

  const ApplicantDetailsScreen({
    super.key,
    required this.profileUrl,
    required this.lastName,
    required this.firstName,
    required this.rate,
    required this.city,
    required this.verified,
    required this.bio,
    required this.availability,
    required this.distance,
    required this.experience,
    required this.servicesList,
    required this.languagesList,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    List getDocumentsByType(String type) {
      return documents.where((document) => document['type'] == type).toList();
    }

    final resumeDocuments = getDocumentsByType('resume');
    final barangayClearanceDocuments = getDocumentsByType('barangay clearance');
    final policeClearanceDocuments = getDocumentsByType('police clearance');
    final nbiClearanceDocuments = getDocumentsByType('nbi clearance');
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                profileUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$firstName $lastName',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$city - $distance kilometers',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₱$rate/hr',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          const Icon(
                            Icons.star_border,
                            size: 32.0,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'Services:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        HighlightedService(
                          servicesList: servicesList,
                          highlightColor: orangecolor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          'Languages:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        HighlightedLanguages(
                          languagesList: languagesList,
                          highlightColor: greencolor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Availability',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          availability,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          color: greycolor,
                          thickness: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Experience',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          experience,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          color: greycolor,
                          thickness: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bio',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bio,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    if (documents.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Documents',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              children: [
                                if (getDocumentsByType('resume').isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                if (resumeDocuments[0]
                                                        ['status'] ==
                                                    'verified')
                                                  const StatusHighlight(
                                                    label: 'Resume:',
                                                    highlightColor: greencolor,
                                                    text: 'Verified',
                                                  )
                                                else if (resumeDocuments[0]
                                                        ['status'] ==
                                                    'unverified')
                                                  const StatusHighlight(
                                                    label: 'Resume:',
                                                    highlightColor: orangecolor,
                                                    text: 'Pending',
                                                  )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                  ),
                                                  onPressed: () async {
                                                    const documentType =
                                                        'Resume';
                                                    final fileUrls =
                                                        resumeDocuments[0]
                                                            ['fileUrl'];
                                                    Get.to(
                                                        () => DocumentDetails(
                                                              documentType:
                                                                  documentType,
                                                              fileUrls:
                                                                  fileUrls,
                                                            ),
                                                        transition: Transition
                                                            .downToUp);
                                                  },
                                                  child: const Text(
                                                      'View Document'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('barangay clearance')
                                    .isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                if (barangayClearanceDocuments[
                                                        0]['status'] ==
                                                    'verified')
                                                  const StatusHighlight(
                                                    label:
                                                        'Barangay Clearance:',
                                                    highlightColor: greencolor,
                                                    text: 'Verified',
                                                  )
                                                else if (barangayClearanceDocuments[
                                                        0]['status'] ==
                                                    'unverified')
                                                  const StatusHighlight(
                                                    label:
                                                        'Barangay Clearance:',
                                                    highlightColor: orangecolor,
                                                    text: 'Pending',
                                                  )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                  ),
                                                  onPressed: () async {
                                                    const documentType =
                                                        'Barangay Clearance';
                                                    final fileUrls =
                                                        barangayClearanceDocuments[
                                                            0]['fileUrl'];
                                                    Get.to(
                                                        () => DocumentDetails(
                                                              documentType:
                                                                  documentType,
                                                              fileUrls:
                                                                  fileUrls,
                                                            ),
                                                        transition: Transition
                                                            .downToUp);
                                                  },
                                                  child: const Text(
                                                      'View Document'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('police clearance')
                                    .isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                if (policeClearanceDocuments[0]
                                                        ['status'] ==
                                                    'verified')
                                                  const StatusHighlight(
                                                    label: 'Police Clearance:',
                                                    highlightColor: greencolor,
                                                    text: 'Verified',
                                                  )
                                                else if (policeClearanceDocuments[
                                                        0]['status'] ==
                                                    'unverified')
                                                  const StatusHighlight(
                                                    label: 'Police Clearance:',
                                                    highlightColor: orangecolor,
                                                    text: 'Pending',
                                                  )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                  ),
                                                  onPressed: () async {
                                                    const documentType =
                                                        'Police Clearance';
                                                    final fileUrls =
                                                        policeClearanceDocuments[
                                                            0]['fileUrl'];
                                                    Get.to(
                                                        () => DocumentDetails(
                                                              documentType:
                                                                  documentType,
                                                              fileUrls:
                                                                  fileUrls,
                                                            ),
                                                        transition: Transition
                                                            .downToUp);
                                                  },
                                                  child: const Text(
                                                      'View Document'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('nbi clearance')
                                    .isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                if (nbiClearanceDocuments[0]
                                                        ['status'] ==
                                                    'verified')
                                                  const StatusHighlight(
                                                    label: 'NBI Clearance:',
                                                    highlightColor: greencolor,
                                                    text: 'Verified',
                                                  )
                                                else if (nbiClearanceDocuments[
                                                        0]['status'] ==
                                                    'unverified')
                                                  const StatusHighlight(
                                                    label: 'NBI Clearance:',
                                                    highlightColor: orangecolor,
                                                    text: 'Pending',
                                                  )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                  ),
                                                  onPressed: () async {
                                                    const documentType =
                                                        'NBI Clearance';
                                                    final fileUrls =
                                                        nbiClearanceDocuments[0]
                                                            ['fileUrl'];
                                                    Get.to(
                                                        () => DocumentDetails(
                                                              documentType:
                                                                  documentType,
                                                              fileUrls:
                                                                  fileUrls,
                                                            ),
                                                        transition: Transition
                                                            .downToUp);
                                                  },
                                                  child: const Text(
                                                      'View Document'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Divider(
                            color: greycolor,
                            thickness: 1,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {},
                      child: const Text('Hire Worker'),
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
}
