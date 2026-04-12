import 'dart:io';

void main() {
  const appTitle = "Student Grade Student Grade v1.0";
  print(".................$appTitle...............");

  List<Map<String?, dynamic>> studentList = [];
  ;
  final Set<String> subject = {"English", "Math", "Science,Bangle"};

  do {
    print('''
    1. Add Student
    2. Record Score
    3. Add Bonus Points
    4. Add Comment
    5. View All Students
    6. View Report Card
    7. Class Summary
    8. Exit
  
  Choose an option:
    ''');

    int option = int.parse(stdin.readLineSync()!);

    switch (option) {
      case 1:
        //student name prompt
        print("Add Student name:");

        //create the student map
        Map<String?, dynamic> student = {
          "name": stdin.readLineSync()!,
          "Subject": [...subject],
          "score": null,
          "bonus": null,
          "comment": null,
        };

        //add student to the list
        studentList.add(student);

        //confirmation message
        print("Student ${student["name"]} added successfully");

        continue;

      case 2:
        continue;

      case 3:
        continue;

      case 4:
        continue;

      case 5:
        continue;

      case 6:
        continue;

      case 7:
        break;

      case 8:
        print("Exit");
        break;

      default:
        print("Invalid option. Please enter correct option");
        continue;
    }
  } while (true);
}
