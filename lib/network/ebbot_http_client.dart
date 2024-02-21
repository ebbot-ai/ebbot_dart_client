import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EbbotHttpClient {
  final baseUrl = "https://v2.ebbot.app/api/asyngular";

  final Map<String, String> headers = {
    'Accept': 'application/json, text/plain, */*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'en-GB,en;q=0.9',
    'Content-Type': 'application/json',
    'Origin': 'https://demo.ebbot.ai',
    'Referer': 'https://demo.ebbot.ai/',
    'Sec-Ch-Ua':
        '"Chromium";v="118", "Google Chrome";v="118", "Not=A?Brand";v="99"',
    'Sec-Ch-Ua-Mobile': '?0',
    'Sec-Ch-Ua-Platform': '"macOS"',
    'Sec-Fetch-Dest': 'empty',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Site': 'cross-site',
    'User-Agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
  };

  String botId;
  String chatId;

  EbbotHttpClient(this.botId, this.chatId);

  Future<dynamic> initEbbot() async {
    var url = "$baseUrl/init";
    print("URL: $url");
    var body = {"botId": botId, "chatId": chatId};
    var uri = Uri.parse(url);
    var response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    return json.decode(response.body);
  }
}
