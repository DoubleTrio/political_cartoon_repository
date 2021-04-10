import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class TimeConverter {
  const TimeConverter({this.locale = 'en'});

  final String locale;

  String timeAgoSinceDate(Timestamp timestamp, {bool numericDates = true});
}

class DefaultTimeAgo implements TimeConverter {
  const DefaultTimeAgo({this.locale = 'en'});

  final String locale;

  String timeAgoSinceDate(Timestamp timestamp, {bool numericDates = true}) {
    DateTime notificationDate = timestamp.toDate();
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      var dateString =
          DateFormat('dd MMM yyyy', locale).format(notificationDate);
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
