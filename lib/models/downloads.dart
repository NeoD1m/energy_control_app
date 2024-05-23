import '../main.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'downloaded_file.dart';

Future<void> downloadAndSavePdf(
    {required int id, required String? title, required String? type}) async {
  print("start");
  try {
    final dio = Dio();
    final response = await dio.get(
      '$apiUrl/file/$id',
      options: Options(responseType: ResponseType.bytes),
    );
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$id.pdf');
    await file.writeAsBytes(response.data);

    final downloadedFile = DownloadedFile(
      id: id,
      title: title ?? "Ошибка получения названия документа",
      type: type ?? "doc",
      path: file.path,
    );
    await addDownloadedFile(downloadedFile);
  } catch (e) {
    print("Error downloading PDF: $e");
  }
}
