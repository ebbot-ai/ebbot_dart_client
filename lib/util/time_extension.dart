extension FractionalSecondExtension on DateTime {

  /// Converts a given timestamp to the format expected by the Ebbot backend.
  ///
  /// The Ebbot backend expects timestamps to be in the format of fractional seconds
  /// with a precision of 9 decimals. This function takes a timestamp as input and
  /// converts it to the required format.
  ///
  /// Example usage:
  /// ```dart
  /// String timestamp = '2022-01-01T12:34:56.123456789Z';
  /// String formattedTimestamp = convertToEbbotTimestamp(timestamp);
  /// print(formattedTimestamp); // Output: '1641040496.123456789'
  /// ```
  ///
  /// Note: This function assumes that the input timestamp is in the UTC timezone.
  String fractionalSecond() {
    double currentTimeInSeconds = (millisecondsSinceEpoch / 1000);
    return currentTimeInSeconds.toStringAsFixed(9);
  }
}
