import 'dart:io';
import 'user.dart';

class BankAccount {
  int? accNumber;
  double balance;
  List<String> transactionHistory;

  BankAccount(this.accNumber, this.balance) : transactionHistory = [];

  static void bankMenu(List<BankAccount> bankAccountList) {
    while (true) {
      print(
          "1-> Account yaratish\n2-> Pul kiritish(Deposit)\n3-> Pul yechish(Withdraw)\n4-> Check Balance\n5-> Transaction History\n6-> Bosh menyuga qaytish");
      int b = int.parse(stdin.readLineSync()!);

      switch (b) {
        case 1:
          createAccount(bankAccountList);
        case 2:
          deposit(bankAccountList);
          break;

        case 3:
          withdraw(bankAccountList);
          break;

        case 4:
          bankAccountList[0].printBalance();
          break;

        case 5:
          viewTransactionHistory(bankAccountList);
          break;

        case 6:
          return;

        default:
          print("Noto'g'ri tanlov; Qayta urinib ko'ring");
          break;
      }
    }
  }

  static void createAccount(List<BankAccount> bankAccountList) {
    print("Yangi hisob raqamini kiriting: ");
    int accNumber = int.parse(stdin.readLineSync()!);
    print("Dastlabki balansni kiriting: ");
    double firstBalance = double.parse(stdin.readLineSync()!);

    var newAccount = BankAccount(accNumber, firstBalance);
    bankAccountList.add(newAccount);
    print("Hisob muvaffaqiyatli yaratildi");
  }

  static void deposit(List<BankAccount> bankAccountList) {
    if (bankAccountList.isEmpty) {
      print("Bank hisob qaydnomasi mavjud emas.");
      return;
    }
    print("Qancha pul kiritmoqchisiz?");
    double pul = double.parse(stdin.readLineSync()!);
    if (pul < 0) {
      print("Iltimos ijobiy miqdor kiriting");
    } else {
      for (var account in bankAccountList) {
        account.balance += pul;
        account.transactionHistory.add("Pul kiritildi: $pul");
      }
      print(
          "Siz kiritgan pul balansga muvaffaqiyatli qo'shildi. Joriy balance: ${bankAccountList[0].balance}");
    }
  }

  static void withdraw(List<BankAccount> bankAccountList) {
    if (bankAccountList.isEmpty) {
      print("Bank hisob qaydnomasi mavjud emas.");
      return;
    }
    print("Qancha pul yechmoqchisiz?");
    double amount = double.parse(stdin.readLineSync()!);
    if (amount > bankAccountList[0].balance) {
      print(
          "Balansda yetarli mablag' mavjud emas, iltimos qayta urinib ko'ring");
    } else {
      for (var account in bankAccountList) {
        account.balance -= amount;
        account.transactionHistory.add("Pul yechildi: $amount");
      }
      print(
          "Balansingizdan $amount so'm pul yechildi. Joriy balans: ${bankAccountList[0].balance}");
    }
  }

  static void viewTransactionHistory(List<BankAccount> bankAccountList) {
    List<String> combinedHistory = [];
    for (var account in bankAccountList) {
      combinedHistory.addAll(account.transactionHistory);
    }

    if (combinedHistory.isEmpty) {
      print("O'tkazmalar tarixi bo'sh");
    } else {
      print("O'tkazmalar tarixi: ");
      for (var transaction in combinedHistory) {
        print(transaction);
      }
    }
  }

  double getBalance() {
    return balance;
  }

  void printBalance() {
    print("Joriy balans: $balance");
  }
}
