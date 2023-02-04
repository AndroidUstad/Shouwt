extension DurationExtension on Duration {
  String get durationToString {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this.inSeconds.remainder(60));
    if (this.inHours == 0 && this.inMinutes == 0) return '0:$twoDigitSeconds';
    if (this.inHours == 0) return '$twoDigitMinutes:$twoDigitSeconds';
    return "${twoDigits(this.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
