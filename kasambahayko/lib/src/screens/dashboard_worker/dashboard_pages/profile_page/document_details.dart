import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DocumentDetails extends StatefulWidget {
  final String documentType;
  final List<dynamic> fileUrls;

  const DocumentDetails(
      {Key? key, required this.fileUrls, required this.documentType})
      : super(key: key);

  @override
  DocumentDetailsState createState() => DocumentDetailsState();
}

class DocumentDetailsState extends State<DocumentDetails> {
  PageController pageController = PageController();
  int currentPage = 0;
  bool showWidgets = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackcolor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              showWidgets = !showWidgets;
            });
          },
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: widget.fileUrls.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.fileUrls[index]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                pageController: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                scaleStateChangedCallback: (scaleState) {
                  if (scaleState == PhotoViewScaleState.zoomedIn ||
                      scaleState == PhotoViewScaleState.zoomedOut) {
                    setState(() {
                      showWidgets = false;
                    });
                  } else {
                    setState(() {
                      showWidgets = true;
                    });
                  }
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Visibility(
                  visible: showWidgets,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.documentType,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Visibility(
                  visible: showWidgets,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Page ${currentPage + 1} of ${widget.fileUrls.length}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
