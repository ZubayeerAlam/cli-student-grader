import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

void main() {
  const appTitle = "Student Grade Student Grade v1.0";
  print(".................$appTitle...............");

  List<Map<String?, dynamic>> studentList = [];
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
          "score": [],
          "bonus": null,
          "comment": null,
        };

        //add student to the list
        studentList.add(student);

        //confirmation message
        print("Student ${student["name"]} added successfully");

        continue;

      case 2:
        //Show a numbered list of the students
        print("Number List of the Students:");
        for (int i = 0; i < studentList.length; i++) {
          print("${i + 1}. ${studentList[i]["name"]}");
        }

        // Teacher picks a student
        int studentNumber;
        while (true) {
          print("Enter the student number:");
          studentNumber = int.parse(stdin.readLineSync()!);

          if (studentNumber < 1 || studentNumber > studentList.length) {
            print("Invalid student number. Please try again.");
            continue;
          } else {
            break;
          }
        }

        //show available subject
        print(
          "Available Subject : ${studentList[studentNumber - 1]["Subject"]}",
        );

        //add the score for each subject
        for (int i = 0; i < subject.length; i++) {
          print("Enter  subject ${i + 1}: mark:");
          int mark;
          while (true) {
            mark = int.parse(stdin.readLineSync()!);
            if (mark < 0 || mark > 100) {
              print("Invalid mark. Please try again.");
              continue;
            } else {
              break;
            }
          }

          //add the score to the score list
          studentList[studentNumber - 1]["score"].add(mark);
          print("Score added successfully");
        }

        print(studentList);
        continue;

      case 3:
        //prompt to choose the students to give bonus points
        print("Choose a student for bonus points:");
        for (int i = 0; i < studentList.length; i++) {
          print("${i + 1}. ${studentList[i]["name"]}");
        }

        //choose a student
        int studentNumber;
        while (true) {
          print("Enter the student number:");
          studentNumber = int.parse(stdin.readLineSync()!);

          if (studentNumber < 1 || studentNumber > studentList.length) {
            print("Invalid student number. Please try again.");
            continue;
          } else {
            break;
          }
        }

        //check if bonus points already set
        if (studentList[studentNumber - 1]["bonus"] != null) {
          print("Bonus points already set");
        } else {
          //add bonus points
          print("Enter bonus points(1-10):");
          int bonus;
          while (true) {
            bonus = int.parse(stdin.readLineSync()!);
            //check if bonus points is valid
            if (bonus < 1 || bonus > 10) {
              print("Please try again.");
              continue;
            } else {
              break;
            }
          }
          //add bonus points to the student
          studentList[studentNumber - 1]["bonus"] ??= bonus;
          print("Bonus points added successfully");
        }
        continue;

      case 4:
        //prompt to choose a student for comment
        print("Choose a student for comment:");
        for (int i = 0; i < studentList.length; i++) {
          print("${i + 1}. ${studentList[i]["name"]}");
        }

        //choose a student for comment
        int studentNumber;
        while (true) {
          print("Enter the student number:");
          studentNumber = int.parse(stdin.readLineSync()!);

          if (studentNumber < 1 || studentNumber > studentList.length) {
            print("Invalid student number. Please try again.");
            continue;
          } else {
            break;
          }
        }
        //Show student have a comment or not
        String display =
            studentList[studentNumber - 1]["comment"]?.toUpperCase() ??
            "No comment provided";
        print("Comment: $display");

        //add comment
        print("Add comment ");
        String? comment = stdin.readLineSync()!;
        studentList[studentNumber - 1]["comment"] = comment;
        print("Comment added successfully");

        continue;

      case 5:
        //view all students
        print("Student List:");

        var tags = [
          for (var student in studentList)
            {
              "Name: ${student["name"]} \n",
              "Score: ${student["score"].length} scores \n",
              if (student["bonus"] != null) "⭐️has a bonus \n",
              "------------------------------------- \n",
            },
        ];
        print(tags);
        continue;

      case 6:
        print("select a student for report card:");
        for (int i = 0; i < studentList.length; i++) {
          print("${i + 1}. ${studentList[i]["name"]}");
        }

        //choose a student
        int studentNumber;
        while (true) {
          print("Enter the student number:");
          studentNumber = int.parse(stdin.readLineSync()!);

          if (studentNumber < 1 || studentNumber > studentList.length) {
            print("Invalid student number. Please try again.");
            continue;
          } else {
            break;
          }
        }

        String Grade;
        dynamic totalScore = 0;
        for (
          int i = 0;
          i < studentList[studentNumber - 1]["score"]?.length;
          i++
        ) {
          totalScore += studentList[studentNumber - 1]["score"][i];
        }
        var average = totalScore / studentList[studentNumber - 1]["score"].length;
        if (average >= 90) {
          Grade = "A";
        } else if (average >= 80) {
          Grade = "B";
        } else if (average >= 70) {
          Grade = "C";
        } else if (average >= 60) {
          Grade = "D";
        } else {
          Grade = "F";
        }

        var finalAvrg=average+(studentList[studentNumber - 1]["bonus"]?? 0);

        print('''
        
        ╔══════════════════════════════╗
        ║       REPORT CARD            ║
        ╠══════════════════════════════╝
        ║  Name:    ${studentList[studentNumber - 1]["name"]}       ║
        ║  Scores:  ${studentList[studentNumber - 1]["score"]}       ║
        ║  Bonus:   ${studentList[studentNumber - 1]["bonus"] ?? 0}                 ║
        ║  Average:  ${finalAvrg.toStringAsFixed(2)}             ║
        ║  Grade:    $Grade                 ║
        ║  Comment:  ${studentList[studentNumber - 1]["comment"] ?? "No comment"}        ║
        ╚══════════════════════════════╝
        .
        
        ''');
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
