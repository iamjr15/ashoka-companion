String secondsToMMSS(int seconds) {
  // Calculate minutes and remaining seconds
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;

  // Format minutes and seconds as strings with leading zeros
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

  // Combine minutes and seconds in "mm:ss" format
  String formattedTime = '$formattedMinutes:$formattedSeconds';

  return formattedTime;
}