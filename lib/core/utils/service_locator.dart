import 'package:bookly/Features/home/data/data_source/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_source/home_remote_data_source.dart';
import 'package:bookly/Features/home/data/repo/home_repo_impl.dart';
import 'package:bookly/core/utils/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupSerivceLocator() {
  locator.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeRemoteDataSource: HomeRepoDataSourceImp(
        apiServices: ApiServices(
          Dio(),
        ),
      ),
      homeLocalDataSource: HomeLocalDataSourceImp(),
    ),
  );
  
}
