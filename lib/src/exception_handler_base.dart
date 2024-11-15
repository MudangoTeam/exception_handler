import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:exception_handler/src/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';

class ExceptionHandler {
  ExceptionHandler({
    required this.username,
    required this.password,
    required this.subject,
    required this.recipients,
    required this.environment,
    required this.globalKey,
    required this.onUserInfo,
    required this.onIsActiveExceptionHandler,
  });

  final String username;
  final String password;
  final String subject;
  final List<String> recipients;
  final String environment;
  final GlobalKey<ScaffoldState> globalKey;
  final Future<String?> Function()? onUserInfo;
  final Future<bool> Function() onIsActiveExceptionHandler;

  final logger = Logger();

  Future<void> sendMail(Object error, StackTrace stack) async {
    if (!await onIsActiveExceptionHandler()) {
      return;
    }

    final boundary =
        // ignore: cast_nullable_to_non_nullable, use_build_context_synchronously
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/${DateTime.now()}.png';
    final imgFile = File(imagePath);
    await imgFile.writeAsBytes(pngBytes);

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Notifier')
      ..recipients.addAll(recipients)
      ..subject = subject
      ..html = await _buildHtml(error, stack)
      ..attachments.add(FileAttachment(File(imagePath)));

    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      logger.e(
        'EXCEPTION HANDLER\n ENVIROMENT => $environment',
        error: e,
      );
    }
  }

  Future<String> _buildHtml(Object error, StackTrace stack) async {
    final appInfo = await getAppInfo(environment);
    final deviceInfo = await getDeviceInfo();
    final networkType = await getNetworkType();
    final userInfo = await getUserInfo(onUserInfo);

    final body = stack.toString().replaceAll('#', '<br>#');

    // ignore: leading_newlines_in_multiline_strings
    return '''
              <p>
                ---------------------
                <br>ERROR<br>
                ---------------------
                <br>
                $error
                <br>
              </p>
              <p>
                ---------------------
                <br>STACK<br>
                ---------------------
                $body
                <br>
              </p>
              <p>
                ---------------------
                <br>APP INFO<br>
                ---------------------
                <br>
                $appInfo
              </p>
              <p>
                ---------------------
                <br>DEVICE INFO<br>
                ---------------------
                <br>
                $deviceInfo
              </p>
              <p>
                ---------------------
                <br>NETWORK INFO<br>
                ---------------------
                <br>
                $networkType
              </p>
              <p>
                ---------------------
                <br>USER INFO<br>
                ---------------------
                <br>
                $userInfo
              </p>
              ''';
  }
}
