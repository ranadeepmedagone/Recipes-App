// Dart packages
import 'dart:io';

// Flutter in-built packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

// Local imports

class AppBarShareButton extends StatefulWidget {
  const AppBarShareButton({
    Key? key,
    required this.initialLoading,
    required this.shareTitle,
    this.imageUrl,
    this.richText,
    this.imageName,
    required this.title,
    this.padding = const EdgeInsets.only(
      top: 24.0,
      left: 16,
      right: 16,
      bottom: 14,
    ),
    this.subject = "Narayana Educational Institutions",
  }) : super(key: key);

  final bool initialLoading;

  final String title;
  final String shareTitle;
  final String subject;
  final String? richText;
  final String? imageUrl;
  final String? imageName;
  final EdgeInsets padding;

  @override
  _AppBarShareButtonState createState() => _AppBarShareButtonState();
}

class _AppBarShareButtonState extends State<AppBarShareButton> {
  bool isSharePressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.initialLoading) return;
        if (isSharePressed) return;
        setState(() {
          isSharePressed = true;
        });
        try {
          Uint8List? image;
          String? fileExt;
          (await NetworkAssetBundle(Uri.parse(image.toString()))
                  .load(image.toString()))
              .buffer
              .asUint8List();
          Directory? tempDir = await getExternalStorageDirectory();

          print(" temp dir : $tempDir");
          if (tempDir == null) return;
          String tempPath = tempDir.absolute.path;
          // var filePath = tempPath + '/file_01.png';

          var file = File("$tempPath/myfile.png");
          file = await file.writeAsBytes(image!);
          // if (widget.imageUrl != null && !widget.imageUrl.isNotEmpty) {
          //   fileExt = ShareUtilities.getFileExtFromNetworkUrl(widget.imageUrl!);
          //   if (!fileExt.isBlank) {
          //     image = await ShareUtilities.getBytesOfNetworkFile(
          //         Uri.parse(widget.imageUrl!));
          //     // print('image');
          //     // print(image);
          //   }
          // }

          if (mounted) {
            await WcFlutterShare.share(
              sharePopupTitle: widget.shareTitle,
              subject: widget.subject,
              text:
                  "${widget.title}: \n${(widget.richText ?? '')} \n\nShared from nConnect App by Narayana Educational Institutions.",
              fileName: fileExt != null && image != null
                  ? "${widget.imageName ?? 'nconnect-image'}.$fileExt"
                  : null,
              mimeType: "text/plain",
              bytesOfFile: image,
            );
          }
        } catch (err) {
          print(err);
        }
        setState(() {
          isSharePressed = false;
        });
      },
      child: Padding(
        // Giving Manual Padding on All Sides to:
        // - Give Space on right side from screen edge: 16
        // - Make tap target size large enough
        padding: widget.padding,
        child: isSharePressed
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              )
            : const Icon(
                Icons.share,
              ),
      ),
    );
  }
}
