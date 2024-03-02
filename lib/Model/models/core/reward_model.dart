class RewardModel {
  Data? data;
  bool? status;

  RewardModel({this.data, this.status});

  RewardModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? totalRewardPoints;
  List<Rewards>? rewards;

  Data({this.totalRewardPoints, this.rewards});

  Data.fromJson(Map<String, dynamic> json) {
    totalRewardPoints = json['totalRewardPoints'];
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new Rewards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRewardPoints'] = this.totalRewardPoints;
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rewards {
  int? level;
  String? reward;
  String? status;

  Rewards({this.level, this.reward, this.status});

  Rewards.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    reward = json['reward'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['reward'] = this.reward;
    data['status'] = this.status;
    return data;
  }
}
