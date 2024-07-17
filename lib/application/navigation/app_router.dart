import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/application/views/authentication/authentication_view.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_view.dart';
import 'package:pokedex/application/views/splash/splash_view.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute.guarded(
            page: PokemonListRoute.page,
            onNavigation: (NavigationResolver resolver, StackRouter router) {
              if (FirebaseAuth.instance.currentUser != null) {
                resolver.next(true);
              } else {
                router.push(const AuthenticationRoute());
              }
            },
            initial: true,
            keepHistory: false),
        AutoRoute(page: AuthenticationRoute.page, keepHistory: false)
      ];

  PageInfo<dynamic> get initialPage {
    if (FirebaseAuth.instance.currentUser == null) {
      return AuthenticationRoute.page;
    }

    return PokemonListRoute.page;
  }
}
