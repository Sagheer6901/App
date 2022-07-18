import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/functions/app_config.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onClicked;

  const ButtonHeaderWidget({
    Key? key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
    child: ButtonWidget(
      text: "${text}",
      onClicked: onClicked,
    ),
  );
}





class ButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onClicked;

  const ButtonWidget({
    Key? key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text == "null"?
    Text(
    "Add Birth Date",
        style: TextStyle(fontSize: AppConfig.f4, fontFamily: AppConfig.fontFamilyRegular),
        textScaleFactor: 1
    )
            :Text(
            "${text}",
            style: TextStyle(fontSize: AppConfig.f4, fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1
           ),
    IconButton(
      onPressed: onClicked,
    icon: Icon(
             Icons.edit,
             color: AppConfig.tripColor,
           ),
    ),
      ],
    );
  }




      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: Size.fromHeight(40),
      //     primary: Colors.white,
      //   ),
      //   child: FittedBox(
      //     child: Text(
      //       "${text}",
      //       style: TextStyle(fontSize: 20, color: Colors.black),
      //     ),
      //   ),
      //   onPressed: onClicked,
      // );
}

class HeaderWidget extends StatelessWidget {
  final Widget? child;

  const HeaderWidget({
    Key? key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      child!,
    ],
  );
}

//
// class DatePickerWidget extends StatefulWidget {
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }
//
// class _DatePickerWidgetState extends State<DatePickerWidget> {
//    DateTime? date;
//
//   String getText() {
//     if (date == null) {
//       return 'Select Date';
//     } else {
//       return DateFormat('MM/dd/yyyy').format(date!);
//       // return '${date.month}/${date.day}/${date.year}';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => ButtonHeaderWidget(
//     text: getText(),
//     onClicked: () => pickDate(context),
//   );
//
//   Future pickDate(BuildContext context) async {
//     final initialDate = DateTime.now();
//     final newDate = await showDatePicker(
//       context: context,
//       initialDate: date ?? initialDate,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 5),
//     );
//
//     if (newDate == null) return;
//
//     setState(() => date = newDate);
//   }
// }