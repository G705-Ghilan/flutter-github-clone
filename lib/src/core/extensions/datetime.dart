import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get format {
    final format = DateFormat('yyyy MMM, d');
    return format.format(this);
  }

  String get long {
    Duration difference = DateTime.now().difference(this);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '${years}y';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '${months}M';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  }
}
