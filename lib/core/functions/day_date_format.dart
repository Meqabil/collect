import 'package:get/get.dart';

String dayDateFormat(DateTime date) {
  final now = DateTime.now();

  // Remove time from both dates.
  final today = DateTime(now.year, now.month, now.day);
  final targetDate = DateTime(date.year, date.month, date.day);

  final difference = targetDate.difference(today).inDays;

  // Today
  if (difference == 0) {
    return 'due_today'.tr;
  }

  // Past dates
  if (difference < 0) {
    final lateDays = -difference;

    if (lateDays == 1) {
      return 'yesterday'.tr;
    }

    if (lateDays == 2) {
      return 'late_2_days'.tr;
    }

    if (lateDays > 59) {
      final months = lateDays ~/ 30;
      return "${'late'.tr} $months ${'months'.tr}";
    }

    if (lateDays > 29) {
      return "${'late'.tr} 1 ${'month'.tr}";
    }

    if (lateDays > 21) {
      return "${'late'.tr} 3 ${'weeks'.tr}";
    }

    if (lateDays > 14) {
      return "${'late'.tr} 2 ${'weeks'.tr}";
    }

    if (lateDays > 6) {
      return "${'late'.tr} 1 ${'week'.tr}";
    }

    return "${'late'.tr} $lateDays ${'days'.tr}";
  }

  // Future dates
  if (difference == 1) {
    return 'tomorrow'.tr;
  }

  if (difference == 2) {
    return "${'after'.tr} 2 ${'days'.tr}";
  }

  if (difference > 59) {
    final months = difference ~/ 30;
    return "${'after'.tr} $months ${'months'.tr}";
  }

  if (difference > 29) {
    return "${'after'.tr} 1 ${'month'.tr}";
  }

  if (difference > 21) {
    return "${'after'.tr} 3 ${'weeks'.tr}";
  }

  if (difference > 14) {
    return "${'after'.tr} 2 ${'weeks'.tr}";
  }

  if (difference > 6) {
    return "${'after'.tr} 1 ${'week'.tr}";
  }

  return "${'after'.tr} $difference ${'days'.tr}";
}