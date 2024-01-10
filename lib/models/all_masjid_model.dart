
class GetAllMasjid {
  String? status;
  int? results;
  Data? data;

  GetAllMasjid({this.status, this.results, this.data});

  GetAllMasjid.fromJson(Map<String, dynamic> json) {
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["results"] is int) {
      results = json["results"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["results"] = results;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  List<Mosques>? mosques;

  Data({this.mosques});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["mosques"] is List) {
      mosques = json["mosques"] == null ? null : (json["mosques"] as List).map((e) => Mosques.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(mosques != null) {
      _data["mosques"] = mosques?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Mosques {
  List<String>? timings;
  String? id;
  String? mosqueName;
  double? latitude;
  double? longitude;

  Mosques({this.timings, this.id, this.mosqueName, this.latitude, this.longitude});

  Mosques.fromJson(Map<String, dynamic> json) {
    if(json["timings"] is List) {
      timings = json["timings"] == null ? null : List<String>.from(json["timings"]);
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["mosqueName"] is String) {
      mosqueName = json["mosqueName"];
    }
    if(json["latitude"] is double) {
      latitude = json["latitude"];
    }
    if(json["longitude"] is double) {
      longitude = json["longitude"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(timings != null) {
      _data["timings"] = timings;
    }
    _data["_id"] = id;
    _data["mosqueName"] = mosqueName;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    return _data;
  }
}