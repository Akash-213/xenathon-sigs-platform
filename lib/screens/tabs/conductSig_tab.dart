import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String proficiency = 'Basic';
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
                  buildProficiency(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildResetButton(),
                      buildSubmitButton(),
                    ],
                  ),
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
        if (value == null) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      onSaved: (value) async {
        setState(() => sigLink = value!);
      });

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
                if (newDate.isBefore(DateTime.now())) return;

                setState(() => date = newDate);
              },
            ),
          ],
        ),
      );

  Widget buildProficiency() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Your Proficiency'),
            Container(
              padding: const EdgeInsets.all(0.0),
              child: DropdownButton<String>(
                value: proficiency,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>['Advanced', 'Intermediate', 'Basic']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    proficiency = 'Basic';
                  }
                  setState(() {
                    proficiency = value!;
                  });
                },
              ),
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

  Widget buildResetButton() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Reset'),
          onPressed: () {
            formKey.currentState!.reset();
          },
        ),
      );

  Widget buildSubmitButton() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            final isValid = formKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              // if (date!.isBefore(DateTime.now())) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     duration: Duration(milliseconds: 500),
              //     content: Text('Enter a Valid Date'),
              //   ));
              //   return;
              // }

              if (!await canLaunch(sigLink)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text('Enter a Valid Link'),
                  ),
                );
                return;
              }

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
                'sigByName': FirebaseAuth.instance.currentUser!.displayName,
                'sigTitle': sigTitle,
                'sigDesc': sigDesc,
                'topics': topics,
                'proficiency': proficiency,
                'sigDateTime': sigDateTime,
                'sigCount': sigCount,
                'sigLink': sigLink,
                'isConfirmed': false,
                'interestedCount': 0,
              });

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text('Form Submitted'),
              ));

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
