class Contact{
  late String name;
  late int accountNumber;

  Contact(this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }
}