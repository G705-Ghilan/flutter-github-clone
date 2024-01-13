import 'dart:convert';
import 'dart:developer';

void logInfo(dynamic msg, [String name = "LogInfo"]) {
  if (msg is Map || msg is List) {
    try {
      msg = const JsonEncoder.withIndent('  ').convert(msg);
    } catch (e) {
      // pass
    }
  }
  log(msg.toString(), name: name);
}
