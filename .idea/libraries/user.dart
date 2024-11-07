import 'bank_account.dart';
import 'dart:io';

class User {
  String? userID;
  String? name;
  String? email;
  String? phone;
  List<BankAccount> accounts;

  User(this.userID, this.name, this.email, this.phone, this.accounts);

  static void userMenu(
      List<User> userList, int count, List<BankAccount> bankAccountList) {
    while (true) {
      print(
          "1-> User qo'shish\n2-> Userlar ro'yhatini ko'rish\n3-> Userni tahrirlash\n4-> Userni o'chirish\n5-> Bank akkaunt qo'shish\n6-> Bosh menyuga qaytish");
      int ch = int.parse(stdin.readLineSync()!);

      switch (ch) {
        case 1:
          User.addUser(userList, count);
          count++;
          break;

        case 2:
          User.viewUser(userList);
          break;

        case 3:
          User.editUser(userList);
          break;

        case 4:
          User.deleteUser(userList);
          break;

        case 5:
          addAccount(userList, bankAccountList);
          break;

        case 6:
          return;

        default:
          print("Noto'g'ri tanlov; Qayta urinib ko'ring");
          break;
      }
    }
  }

  static void addUser(List<User> userList, int count) {
    print("Foydalanuvchi ismini kiriting: ");
    String? ism = stdin.readLineSync()!;
    print("Foydalanuvchi emailini kiriting: ");
    String? pochta = stdin.readLineSync()!;
    print("Foydalanuvchi telefon raqamini kiriting: ");
    String? phoneNumber = stdin.readLineSync()!;
    String userID = "${count + 1}";

    User user = User(userID, ism, pochta, phoneNumber, []);
    userList.add(user);
    print("Foydalanuvchi qo'shildi");
  }

  static void viewUser(List<User> userList) {
    if (userList.isEmpty) {
      print("Hech qanday foydalanuvchi mavjud emas");
    } else {
      print("Foydalanuvchilar ro'yhati");
      for (var user in userList) {
        user.userInfo();
      }
    }
  }

  static void editUser(List<User> userList) {
    print("Tahrirlamoqchi bo'lgan foydalanuvchini ID sini kiriting: ");
    String? userID = stdin.readLineSync()!;
    var user = userList.firstWhere((u) => u.userID == userID,
        orElse: () => User("", "", "", "", []));

    if (userID == '') {
      print("Foydalanuvchi topilmadi");
    } else {
      print("Yangi ism kiriting: (${user.name})");
      user.name = stdin.readLineSync()!;
      print("Yangi email kiriting (${user.email}): ");
      user.email = stdin.readLineSync()!;
      print("Yangi telefon raqam kiriting (${user.phone}): ");
      user.phone = stdin.readLineSync()!;
      print("Foydalanuvchi ma'lumotlari yangilandi!");
    }
  }

  static void deleteUser(List<User> userList) {
    print("O'chirish uchun foydalanuvchi ID sini kiriting: ");
    String? userID = stdin.readLineSync()!;
    if (userID == '') {
      print("Bunday foydalanuvchi topilmadi!");
    } else {
      userList.removeWhere((u) => u.userID == userID);
      print("Foydalanuvchi o'chirildi");
    }
  }

  static void addAccount(
      List<User> userList, List<BankAccount> bankAccountList) {
    print("Qo'shmoqchi bo'lgan foydalanuvchining ID sini kiriting: ");
    String? userID = stdin.readLineSync()!;
    var user = userList.firstWhere((u) => u.userID == userID,
        orElse: () => User("", "", "", "", []));

    if (user.userID == "") {
      print("Foydalanuvchi topilmadi");
    } else {
      print("Yangi akkaunt raqamini kiriting: ");
      int accNumber = int.parse(stdin.readLineSync()!);
      print("Boshlang'ich balansni kiriting: ");
      double balance = double.parse(stdin.readLineSync()!);
      BankAccount newAccount = BankAccount(accNumber, balance);
      user.accounts.add(newAccount);
      bankAccountList.add(newAccount);
      print(
          "Foydalanuvchiga yangi akkaunt qo'shildi: Akkaunt raqami: ${newAccount.accNumber}, Balans: ${newAccount.balance} so'm");
    }
  }

  void userInfo() {
    print("$userID | Ismi: $name | Email: $email | Phone: $phone ");
    if (accounts.isNotEmpty) {
      print("Akkauntlari: ");
      for (var account in accounts) {
        print(
            " Akkaunt raqami: ${account.accNumber} | Balans: ${account.balance} so'm");
      }
    } else {
      print(" Akkaunt mavjud emas");
    }
  }
}
