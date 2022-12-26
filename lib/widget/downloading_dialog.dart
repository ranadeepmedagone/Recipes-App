import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meals/model/single_meal.dart';
import 'package:path_provider/path_provider.dart';

class DownLoadingPdf extends StatefulWidget {
  const DownLoadingPdf({required this.single, super.key});

  final MealSingle? single;

  @override
  State<DownLoadingPdf> createState() => _DownLoadingPdfState();
}

class _DownLoadingPdfState extends State<DownLoadingPdf> {
  MealSingle? single;
  Dio dio = Dio();
  double progress = 0.0;
  void startDownloading() async {
    print(" here");
    if (single == null || single!.strMealThumb == null) {
      print("null single");
      return;
    }
    try {
      String url = single!.strMealThumb!;

      print("url is $url");
      String fileName = "${single!.strMeal!}.jpg";
      String path = await _getFilePath(fileName);
      print(path);
      await dio.download(url, path, onReceiveProgress: (count, total) {
        setState(() {
          progress = count / total;
        });

        print(progress);
      }, deleteOnError: true).then((value) {
        print("download res: ${value.data}");
        print("download res: ${value.statusCode}");

        Navigator.pop(context);
      });
    } catch (e) {
      print("error : $e");
    }
  }

  Future<String> _getFilePath(String fileName) async {
    var directory = Directory('/storage/emulated/0/Download');
    // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
    // ignore: avoid_slow_async_io
    if (!await directory.exists()) {
      print("falling back");
      final dir = await getExternalStorageDirectory();
      return "${dir!.absolute.path}/$fileName";
    }

    return '${directory.path}/$fileName';
    // final dir = await getExternalStorageDirectory();
    // return "${dir!.absolute.path}/$fileName";
  }

  @override
  void initState() {
    super.initState();
    single = widget.single;
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading:$downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
