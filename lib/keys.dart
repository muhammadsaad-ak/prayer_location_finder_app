class Strings {
  static String APIKeys = 'AIzaSyDqwUf8f05X7XztGJtCkaQ1LmbIeFzgwrI';
}

// for maghrib calculation
// TweenAnimationBuilder<Duration>(
// duration: Duration(
// hours: _getSysTime() % 12,
// minutes: _getSysTime2() % 12,
// seconds: _getSysTime3() % 12,
// ),
// tween: Tween(
// begin: Duration(
// hours:
// prayerTimes.maghrib.hour % 12 - _hour,
// minutes: prayerTimes.maghrib.minute % 12 -
// _min,
// // seconds:
// //     prayerTimes.maghrib.second - _sec,
// ),
// end: Duration.zero),
// onEnd: () {
// print('Timer Ended');
// },
// builder: (BuildContext context, Duration value,
// Widget child) {
// final hours = value.inHours % 60;
// final minutes = value.inMinutes % 60;
// final seconds = value.inSeconds % 60;
// return Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 5),
// child: Text(
// 'Time Left \n $hours:$minutes:$seconds',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 25)));
// }),

// for ISHA calculation
// TweenAnimationBuilder<Duration>(
// duration: Duration(
// hours: _getSysTime() % 12,
// minutes: _getSysTime2() % 12,
// seconds: _getSysTime3() % 12,
// ),
// tween: Tween(
// begin: Duration(
// hours: prayerTimes.isha.hour % 12 - _hour,
// minutes:
// prayerTimes.isha.minute % 12 - _min,
// // seconds:
// //     prayerTimes.maghrib.second - _sec,
// ),
// end: Duration.zero),
// onEnd: () {
// print('Timer Ended');
// },
// builder: (BuildContext context, Duration value,
// Widget child) {
// final hours = value.inHours % 60;
// final minutes = value.inMinutes % 60;
// final seconds = value.inSeconds % 60;
// return Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 5),
// child: Text(
// 'Time Left \n $hours:$minutes:$seconds',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 25)));
// }),

//for maghrib
// TweenAnimationBuilder<Duration>(
// duration: Duration(
// hours: prayerTimes.maghrib.hour % 12 -
// _getSysTime() % 12,
// minutes: prayerTimes.maghrib.minute % 12 -
// _getSysTime2() % 12,
// seconds: prayerTimes.maghrib.second % 12 -
// _getSysTime3() % 12,
// ),
// tween: Tween(
// begin: Duration(
// hours: prayerTimes.maghrib.hour % 12 -
// _getSysTime(),
// minutes:
// prayerTimes.maghrib.minute % 12 -
// _getSysTime2(),
// seconds:
// prayerTimes.maghrib.second % 12 -
// _getSysTime3(),
// ),
// end: Duration.zero),
// onEnd: () {
// print('Timer Ended');
// },
// builder: (BuildContext context,
//     Duration value, Widget child) {
// final hours = value.inHours;
// final minutes = value.inMinutes % 60;
// final seconds = value.inSeconds % 60;
// return Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 5),
// child: Text(
// 'Time Left \n $hours:$minutes:$seconds',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 25)));
// }),

//for latest isha
// TweenAnimationBuilder<Duration>(
// duration: Duration(
// hours: prayerTimes.isha.hour % 12 -
// _getSysTime() % 12,
// minutes: prayerTimes.isha.minute % 12 -
// _getSysTime2() % 12,
// seconds: prayerTimes.isha.second % 12 -
// _getSysTime3() % 12,
// ),
// tween: Tween(
// begin: Duration(
// hours: prayerTimes.isha.hour % 12 -
// _getSysTime() % 12,
// minutes: prayerTimes.isha.minute % 12 -
// _getSysTime2() % 12,
// // seconds: prayerTimes.isha.second % 12 -
// //     _getSysTime3() % 12,
// ),
// end: Duration.zero),
// onEnd: () {
// print('Timer Ended');
// },
// builder: (BuildContext context,
//     Duration value, Widget child) {
// final hours = value.inHours;
// final minutes = value.inMinutes % 60;
// final seconds = value.inSeconds % 60;
// return Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 5),
// child: Text(
// 'Time Left \n $hours:$minutes:$seconds',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 25)));
// }),
