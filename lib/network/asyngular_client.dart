import 'dart:async';

import 'package:ebbot_dart_client/ebbot_chat_listener.dart';
import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

class AsyngularClient {
  final asyngularUrl = 'wss://v2.ebbot.app/api/asyngular/';
  final String _botId;
  final String _chatId;
  final String _token;
  final EbbotChatListener _listener;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  late Socket _socket;

  AsyngularClient(this._botId, this._chatId, this._token, this._listener);

  Future<void> initalize() async {
    _socket = await Socket.connect(
        '$asyngularUrl?botId=$_botId&chatId=$_chatId&token=$_token',
        listener: _listener);
    
  }
}