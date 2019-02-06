import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Contacts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 List<Contact> contacts = [];
 @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    final List<Contact> _contacts = (await ContactsService.getContacts(

    )).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Hello World"),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = contacts[index];
                  
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Text(contact.initials()),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contact.displayName ?? ""),
                            Text(contact.phones?.first.value ?? ""),
                          ],
                        )
                      ],
                    ),
                    );
                },
              ),
            ),
          ],
        ),
      )
      
    );
  }
}
