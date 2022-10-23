

class ParticipantModel {
  int? id;
  String? firstName;
  String? lastName;
  String? contact;

  ParticipantModel({this.id, this.firstName, this.lastName, this.contact});

  ParticipantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contact'] = this.contact;
    return data;
  }
}

