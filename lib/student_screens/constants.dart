List<String> courseCodeList = ['IRE', 'TOC', 'AI', 'SE'];
List<String> teacherCodeList = ['JD', 'AK', 'WG', 'SK'];

class StudentObject {
  final String studentName;
  final String roll;
  bool present;

  StudentObject(
      {required this.studentName, required this.present, required this.roll});
}

List<StudentObject> studentPresentStatus = [
  StudentObject(studentName: 'Aaroh Srivastava', roll: '001', present: true),
  StudentObject(studentName: 'Aaroh Srivastava', roll: '002', present: true),
  StudentObject(studentName: 'Aaroh Srivastava', roll: '003', present: false),
  StudentObject(studentName: 'Aaroh Srivastava', roll: '004', present: false),
  StudentObject(studentName: 'Aaroh Srivastava', roll: '005', present: true),
  StudentObject(studentName: 'Aaroh Srivastava', roll: '006', present: true),
];
