extension NumExtension on num {
  String get str {
    if (this < 1000) {
      return toString();
    } else if (this < 1000000) {
      double result = this / 1000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
    } else {
      double result = this / 1000000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    }
  }

  String get formatSize {
    const List<String> suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];
    int i = 0;
    double size = toDouble();
    while (size > 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }
}
