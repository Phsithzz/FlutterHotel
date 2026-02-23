import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TypeMath { mathRound, mathCeil, mathFloor }

enum TypeDialog { error, warning, success, questions }

class AppUnity {
  static String keyUpfile = "";
  static String keyDev = "";
  static String urlNoImage =
      'http://147.50.148.241/attachfile/images/img_not_available.jpeg';
  static Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();
  static String urlGetString = 'https://api-globalsoft.gbhcenter.com/img?url=';
  static String dateFormat(
          {required DateTime? date, bool? isTime, int? digitY}) =>
      date == null
          ? ''
          : DateFormat(
                  'dd/MM/${'y' * (digitY ?? 4)}${(isTime ?? false) ? ' HH:mm น.' : ''}')
              .format(date);

  static String dateFormatSend({required String date}) =>
      '${date.split('/')[2]}-${date.split('/')[1]}-${date.split('/')[0]}';

  static String f(
      {required double text,
      int digit = 2,
      TypeMath typeMath = TypeMath.mathRound}) {
    String srtDecimal = digit == 0 ? '' : '.${'0' * digit}';
    final format = NumberFormat("#,##0$srtDecimal", "en_US");
    switch (typeMath) {
      case TypeMath.mathCeil:
        final s = format.format(mathCeil(num: text, digit: digit));
        return s;
      case TypeMath.mathFloor:
        final s = format.format(mathFloor(num: text, digit: digit));
        return s;
      default:
        final s = format.format(mathRound(num: text, digit: digit));
        return s;
    }
  }

  static double mathRound({required double num, required int digit}) {
    var pows = pow(10, digit);
    return (num * pows).round() / pows;
  }

  static double mathCeil({required double num, required int digit}) {
    var pows = pow(10, digit);
    return (num * pows).ceil() / pows;
  }

  static double mathFloor({required double num, required int digit}) {
    var pows = pow(10, digit);
    return (num * pows).floor() / pows;
  }

  static NumberFormat fomateNumber({int digit = 2}) {
    String srtDecimal = digit == 0 ? '' : '.${'0' * digit}';
    return NumberFormat("#,##0$srtDecimal", "en_US");
  }

  static Divider buildDivider({Color? color, double? height}) => Divider(
        color: color ?? Colors.black45,
        height: height,
      );

  static SizedBox mySizedBox({required double size, required String type}) {
    if (type == 'h') {
      return SizedBox(
        height: size,
      );
    } else {
      return SizedBox(
        width: size,
      );
    }
  }
  static myShowSnackBar(
      {required BuildContext context,
      required String text,
      required TypeDialog typeDialog}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            buildIcon(typeDialog),
            mySizedBox(size: 10, type: 'w'),
            Expanded(
              child: Text(
                text,
                // maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: buildColor(typeDialog),
      ),
    );
  }

  static Icon buildIcon(TypeDialog typeDialog) {
    switch (typeDialog) {
      case TypeDialog.error:
        return const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 20,
        );

      case TypeDialog.warning:
        return const Icon(
          Icons.warning_amber_sharp,
          size: 20,
          color: Colors.white,
        );
      case TypeDialog.questions:
        return const Icon(
          Icons.question_mark_outlined,
          size: 20,
          color: Colors.white,
        );

      default:
        return const Icon(
          Icons.check_circle_outline_sharp,
          size: 20,
          color: Colors.white,
        );
    }
  }

  static Color buildColor(TypeDialog typeDialog) {
    switch (typeDialog) {
      case TypeDialog.error:
        return Colors.redAccent;
      case TypeDialog.warning:
        return Colors.deepOrangeAccent;
      case TypeDialog.questions:
        return Colors.indigoAccent;
      default:
        return Colors.green;
    }
  }

  static Future<DateTimeRange?> showDatePickerRang(
      {required BuildContext context,
      required DateTime? currentDate,
      DateTime? lastDate,
      DateTime? firstDate,
      DateTimeRange? dateTimeRange}) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: firstDate ??
          DateTime(
            DateTime.now().year - 100,
          ),
      lastDate: lastDate ?? DateTime.now(),
      currentDate: currentDate ?? DateTime.now(),
      initialDateRange: dateTimeRange,
      saveText: 'Done',
    );
    return result;
  }

  static Future<DateTime?> myShowDatePicker(
      {required BuildContext context,
      required DateTime? currentDate,
      DateTime? lastDate,
      DateTime? initialDate,
      DateTime? firstDate}) async {
    final DateTime? result = await showDatePicker(
      firstDate: firstDate ??
          DateTime(
            DateTime.now().year - 100,
          ),
      context: context,
      lastDate: lastDate ?? DateTime.now(),
      currentDate: currentDate ?? DateTime.now(),
      initialDate: initialDate ?? DateTime.now(),
    );
    return result;
  }
}

class TitleText extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color? color;
  const TitleText({
    Key? key,
    required this.title,
    required this.iconData,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        AppUnity.mySizedBox(size: 5, type: 'w'),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: color ?? Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
