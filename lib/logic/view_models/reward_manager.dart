import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/reward_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';

class RewardManager extends ChangeNotifier{
RewardModel? rewards;
List<Rewards>? currentReward;
List<Rewards> levelOneReward =[];
List<Rewards> levelTwoReward =[];
List<Rewards> levelThreeReward =[];
  getRewards() async {
    levelOneReward = [];
    levelTwoReward = [];
    levelThreeReward = [];
    String url = "/user/rewards";
    String? token = getIt<SharedPreferences>().getString("token");
    dynamic responseData = await getIt<DioClient>().get(url, token: token);

    rewards = RewardModel.fromJson(responseData);

    currentReward = rewards!.data!.rewards;
    for(var i in currentReward!){
      if(i.level == 1){
        levelOneReward.add(i);
      }else if(i.level == 2){
        levelTwoReward.add(i);
      }else if(i.level == 3){
        levelThreeReward.add(i);
      }
    }

  return currentReward;

  }

}