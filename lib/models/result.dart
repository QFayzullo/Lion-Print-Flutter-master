class Result {

  late int id;
  late String firstName;
  late String lastName;
  late String middleName;
  late String phoneNumber;
  late String address;
  late String imageUrl;
  late Department department;
  late Job job;
  late WorkingDay workingDay;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    imageUrl = json['imageUrl'];
    department = (json['department'] != null
        ? Department.fromJson(json['department'])
        : Department(id: 0, name: "", info: ""));
    job = Job.fromJson(json['job']);
    workingDay = (json['workingDay'] != null
        ? WorkingDay.fromJson(json['workingDay'])
        : WorkingDay(id:0,workingDate:"",arrivalTime:"",exitTime:"",inWork:false));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['imageUrl'] = imageUrl;
    data['department'] = department.toJson();
    data['job'] = job.toJson();
    data['workingDay'] = workingDay.toJson();
    return data;
  }

  @override
  String toString() {
    return 'Result{id: $id, firstName: $firstName, lastName: $lastName, middleName: $middleName, phoneNumber: $phoneNumber, address: $address, imageUrl: $imageUrl, department: $department, job: $job, workingDay: $workingDay}';
  }
}

class WorkingDay {
  late int id;
  late String workingDate;
  late String arrivalTime;
  late String exitTime;
  late bool inWork;
  WorkingDay({required this.id,required this.workingDate,required this.arrivalTime,required this.exitTime,required this.inWork});

  WorkingDay.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    workingDate = json['workingDate'] ?? '';
    arrivalTime = json['arrivalTime'] ?? '';
    exitTime = json['exitTime'] ?? '';
    inWork = json['inWork'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString() ?? '';
    data['workingDate'] = workingDate ?? '';
    data['arrivalTime'] = arrivalTime ?? '';
    data['exitTime'] = exitTime ?? '';
    data['inWork'] = inWork.toString() ?? '';
    return data;
  }

  @override
  String toString() {
    return 'WorkingDay{id: $id, workingDate: $workingDate, arrivalTime: $arrivalTime, exitTime: $exitTime, inWork: $inWork}';
  }
}

class Job {
  late int id;
  late String name;
  late String info;

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    info = json['info'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString() ?? '';
    data['name'] = name ?? '';
    data['info'] = info ?? '';
    return data;
  }

  @override
  String toString() {
    return 'Job{id: $id, name: $name, info: $info}';
  }
}

class Department {
  late int id;
  late String name;
  late String info;

  Department({required this.id,required this.name,required this.info});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    info = json['info'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString() ?? '';
    data['name'] = name ?? '';
    data['info'] = info ?? '';
    return data;
  }

  @override
  String toString() {
    return 'Department{id: $id, name: $name, info: $info}';
  }
}

class usersData {
  late List<Result> result;
  late String error;

  usersData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((dynamic v) {
        result.add(Result.fromJson(v));
      });
    }
    error = json['error'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }

  @override
  String toString() {
    return 'allUsersData{result: $result, error: $error}';
  }
}
