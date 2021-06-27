import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConductSigTab extends StatefulWidget {
  const ConductSigTab({Key? key}) : super(key: key);

  @override
  _ConductSigTabState createState() => _ConductSigTabState();
}

class _ConductSigTabState extends State<ConductSigTab> {
  final formKey = GlobalKey<FormState>();

  String sigTitle = '';
  String sigDesc = '';
  String topics = '';
  String proficiency = '';
  String sigLink = '';
  int sigCount = 0;

  DateTime? sigDateTime;
  DateTime? date;
  TimeOfDay? time;

  String getTimeText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  String getDateText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Conduct SIG Form',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  buildTitle(),
                  const SizedBox(height: 10),
                  buildDesc(),
                  const SizedBox(height: 10),
                  buildTopics(),
                  const SizedBox(height: 10),
                  buildCount(),
                  const SizedBox(height: 10),
                  buildDate(),
                  const SizedBox(height: 10),
                  buildTime(),
                  const SizedBox(height: 10),
                  buildLink(),
                  const SizedBox(height: 10),
                  buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        decoration: InputDecoration(
          labelText: 'SIG Title',
          border: OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => sigTitle = value!),
      );

  Widget buildDesc() => TextFormField(
        decoration: InputDecoration(
          labelText: 'SIG Description',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
        maxLines: 2,
        keyboardType: TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 5 characters';
          } else {
            return null;
          }
        },
        maxLength: 40,
        onSaved: (value) => setState(() => sigDesc = value!),
      );

  Widget buildTopics() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Topics To Be Covered',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
        minLines: 3,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 5 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => topics = value!),
      );

  Widget buildLink() => TextFormField(
        decoration: InputDecoration(
          labelText: 'SIG Platform Link',
          border: OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => sigLink = value!),
      );

  Widget buildDate() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SIG Date'),
            TextButton(
              child: Text(getDateText()),
              onPressed: () async {
                final initialDate = DateTime.now();
                final newDate = await showDatePicker(
                  context: context,
                  initialDate: date ?? initialDate,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                );

                if (newDate == null) return;
                if (newDate.isAfter(DateTime.now())) return;

                setState(() => date = newDate);
              },
            ),
          ],
        ),
      );

  Widget buildTime() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SIG Time'),
            TextButton(
                child: Text(getTimeText()),
                onPressed: () async {
                  final initialTime = TimeOfDay(hour: 16, minute: 0);
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: time ?? initialTime,
                  );

                  if (newTime == null) return;

                  setState(() => time = newTime);
                }),
          ],
        ),
      );

  Widget buildCount() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Expected Count',
          border: OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == '') {
            return 'Enter Expected Count';
          }
          if (int.parse(value!) == 0) {
            return 'Enter A Valid Count';
          }
          if (int.parse(value) > 50) {
            return 'Enter a value less than 50';
          }
        },
        onSaved: (value) => setState(() => sigCount = int.parse(value!)),
      );

  Widget buildSubmitButton() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            final isValid = formKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              sigDateTime = new DateTime(
                date!.year,
                date!.month,
                date!.day,
                time!.hour,
                time!.minute,
              );

              print(sigDateTime);
              await FirebaseFirestore.instance.collection('sigs').add({
                'sigBy': FirebaseAuth.instance.currentUser!.uid,
                'sigTitle': sigTitle,
                'sigDesc': sigDesc,
                'topics': topics,
                'proficiency': proficiency,
                'sigDateTime': sigDateTime,
                'sigCount': sigCount,
                'sigLink': sigLink,
                'isConfirmed': true,
                'interestedCount': 0,
              });
              setState(() {
                date = null;
                time = null;
              });
              formKey.currentState!.reset();
            }
          },
        ),
      );
}
