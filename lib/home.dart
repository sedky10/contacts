import 'package:contacts/contactscreen.dart';
import 'package:contacts/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Details> contacts = [];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'my contacts'.toUpperCase(),
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: FutureBuilder<List<Details>>(
        future: Contacts.instance.getAll(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            contacts = snapshot.data!;
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              Details numbers = contacts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return  ContactScreen(numbers);
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        numbers.url,
                      ),
                    ),
                    Text(
                      '${numbers.firstname}\n${numbers.lastname}',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      numbers.number.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheet();
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController Lastnamecontroller = TextEditingController();
  TextEditingController Urlcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.blue,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: firstnamecontroller,
              decoration: const InputDecoration(
                hintText: ' First Name',
                hintStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: TextFormField(
                controller: Lastnamecontroller,
                decoration: const InputDecoration(
                  hintText: ' Last Name',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: TextFormField(
                controller: numbercontroller,
                decoration: const InputDecoration(
                  hintText: ' Contact Number',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: TextFormField(
                controller: Urlcontroller,
                decoration: const InputDecoration(
                  suffix: Icon(Icons.image, color: Color(0xff19394c)),
                  hintText: ' Contact Photo URL',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: const Color(0xff19394c),
              height: 50,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff19394c),
                ),
                onPressed: () {
                  Contacts.instance.insert(
                    Details(
                      firstname: firstnamecontroller.text,
                      lastname: Lastnamecontroller.text,
                      number: numbercontroller.text,
                      url: Urlcontroller.text,
                    ),
                  );
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text(
                  'ADD\nCONTACT',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
