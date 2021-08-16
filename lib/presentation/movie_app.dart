import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../common/constants/route_constants.dart';
import '../common/screenutil/screenutil.dart';
import '../di/get_it.dart';
import 'app_localizations.dart';
import 'blocs/loading/loading_cubit.dart';
import 'fade_page_route_builder.dart';
import 'journeys/loading/loading_screen.dart';
import 'routes.dart';
import 'themes/theme_color.dart';
import 'themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LoadingCubit _loadingCubit;

  @override
  void initState() {
    super.initState();
    _loadingCubit = getItInstance<LoadingCubit>();
  }

  @override
  void dispose() {
    _loadingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepOrangeAccent,
            textTheme: ButtonTextTheme.primary,
          ),
          unselectedWidgetColor: AppColor.royalBlue,
          primaryColor: Colors.white,
          accentColor: AppColor.royalBlue,
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          cardTheme: CardTheme(
            color: AppColor.vulcan,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeText.getLightTextTheme(),
          appBarTheme: const AppBarTheme(elevation: 0),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: Theme.of(context).textTheme.greySubtitle1,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.vulcan,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: (context, child) {
          return LoadingScreen(
            screen: child!,
          );
        },
        initialRoute: RouteList.initial,
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder? builder = routes[settings.name];
          return FadePageRouteBuilder(
            builder: builder!,
            settings: settings,
          );
        },
      ),
    );
  }
}
