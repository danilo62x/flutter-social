// Small formatting helpers shared across the app. Kept free of Flutter
// dependencies so they can be reused anywhere (UI, models, tests).

/// Builds up to two uppercase initials from a display name or handle.
///
/// Dots are treated as separators so handles like `ana.souza` become `AS`.
String initialsOf(String name) {
  final parts = name.replaceAll('.', ' ').trim().split(RegExp(r'\s+'));
  final buffer = StringBuffer();
  for (final part in parts.take(2)) {
    if (part.isNotEmpty) buffer.write(part[0].toUpperCase());
  }
  final result = buffer.toString();
  return result.isEmpty ? '?' : result;
}

/// Groups an integer with `.` as the thousands separator (pt-BR style):
/// `1234` -> `1.234`.
String thousands(int value) {
  final digits = value.abs().toString();
  final buffer = StringBuffer(value < 0 ? '-' : '');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// Compact, human-friendly counts used for large numbers: `1200` -> `1,2 mil`,
/// `3_400_000` -> `3,4 mi`.
String compact(int value) {
  if (value < 1000) return value.toString();
  if (value < 1000000) {
    final v = value / 1000.0;
    return '${_trim(v)} mil';
  }
  final v = value / 1000000.0;
  return '${_trim(v)} mi';
}

String _trim(double v) {
  final rounded = (v * 10).round() / 10;
  if (rounded == rounded.roundToDouble()) return rounded.toInt().toString();
  return rounded.toStringAsFixed(1).replaceAll('.', ',');
}
