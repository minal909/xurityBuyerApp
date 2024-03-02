import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/logic/view_models/password_manager.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/reward_manager.dart';
import 'package:xuriti/logic/view_models/trans_history_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/models/services/user_info_service.dart';

import '../../logic/view_models/auth_manager.dart';
import '../../logic/view_models/kyc_manager.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<DioClient>(DioClient());
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  getIt.registerSingleton<UserInfoService>(UserInfoService());
  getIt.registerSingleton<AuthManager>(AuthManager());
  getIt.registerSingleton<CompanyDetailsManager>(CompanyDetailsManager());
  getIt.registerSingleton<TransactionManager>(TransactionManager());
  getIt.registerSingleton<ProfileManager>(ProfileManager());
  getIt.registerSingleton<PasswordManager>(PasswordManager());
  getIt.registerSingleton<KycManager>(KycManager());
  getIt.registerSingleton<TransHistoryManager>(TransHistoryManager());
  getIt.registerSingleton<RewardManager>(RewardManager());
}
