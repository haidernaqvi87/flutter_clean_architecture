import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/weather_update/data/datasources/weather_remote_data_source.dart';
import 'features/weather_update/data/repositories/weather_repository_impl.dart';
import 'features/weather_update/domain/repositories/weather_repository.dart';
import 'features/weather_update/domain/usecases/get_weather_update.dart';
import 'features/weather_update/presentation/bloc/weather_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features - Weather Update
  // Bloc
  getIt.registerFactory(
    () => WeatherBloc(
      current: getIt(),
      inputConverter: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetWeatherUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  // Data source
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: getIt()),
  );


  //! Core
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
