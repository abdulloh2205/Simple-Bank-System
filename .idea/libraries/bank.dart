import 'user.dart';
import 'bank_account.dart';
import 'dart:io';

void main() {
  List<User> userList = [];
  List<BankAccount>bankAccountList = [];
  int count = 0;

  while (true) {
    print(
        "1-> User bo'limi\n2-> Bank akkaunt bo'limi\n3-> Dasturdan chiqish");
    int a = int.parse(stdin.readLineSync()!);

    switch (a) {
      case 1:
        User.userMenu(userList, count, bankAccountList);
        break;

      case 2:
        BankAccount.bankMenu(bankAccountList);
        break;

      case 3:
        exit(0);
    }
  }
}