import 'package:bytebank_2/components/centered_message.dart';
import 'package:bytebank_2/components/progress.dart';
import 'package:bytebank_2/databases/dao/contact_dao.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/screens/transaction_form.dart';
import 'package:flutter/material.dart';

import 'contact_form.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future:
            Future.delayed(const Duration(seconds: 1), () => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact>? contacts = snapshot.data;
              if (contacts!.isNotEmpty) {
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _dao.delete(contact.id).then((value) => setState(() {
                              contacts.removeAt(index);
                            }));
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: _ContactItem(contact, onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransactionForm(contact),
                          ),
                        );
                      }),
                    );
                  },
                );
              }
              return CenteredMessage('No contacts found!');
          }
          return CenteredMessage('Unknown Error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              )
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatefulWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem(this.contact, {required this.onClick});

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => widget.onClick(),
        title: Text(
          widget.contact.name,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          widget.contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
