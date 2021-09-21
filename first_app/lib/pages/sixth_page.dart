import 'package:first_app/models/first_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SixthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  var firstName = "";
  var lastName = "";
  var age = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Please Enter Name',
          //   style: Theme.of(context).textTheme.headline5,
          // ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter something.';
              }
              return null;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.trending_neutral),
              border: OutlineInputBorder(),
              labelText: "Enter your firstname",
            ),
            onSaved: (value) {
              firstName = value!;
            },
            initialValue: context.read<FirstFormModel>().firstName,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter something.';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter your lastname",
              icon: Icon(Icons.people),
            ),
            onSaved: (value) {
              lastName = value!;
            },
            initialValue: context.read<FirstFormModel>().lastName,
          ),
          TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age.';
                }
                if (int.parse(value) < 1) {
                  print(int.parse(value));
                  return 'Age must be a number and more than 0';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your age",
                  icon: Icon(Icons.calendar_view_day)),
              onSaved: (value) {
                age = int.parse(value!);
              },
              initialValue: context.read<FirstFormModel>().age.toString()),
          ElevatedButton(
              onPressed: () {
                // ถ้า validate ผ่าน จะเข้าเงื่อนไขนี้
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  context.read<FirstFormModel>().firstName = firstName;
                  context.read<FirstFormModel>().lastName = lastName;
                  context.read<FirstFormModel>().age = age;
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(content: Text(response)));
                  // var response =
                  //     'Hooray!! $firstName $lastName is $age years old';
                  // Navigator.pop(context, response);
                  Navigator.pop(context);
                }
              },
              child: Text('Validate')),
        ],
      ),
    );
  }
}
