import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/signIn',
      name: 'signIn',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/signUpClient',
      name: 'signUpClient',
      builder: (context, state) => const SignUpClientScreen(),
    ),
    GoRoute(
      path: '/showProfiles',
      name: 'showProfiles',
      builder: (context, state) => const ShowProfilesScreen(),
    ),
    GoRoute(
      path: '/showProfileClient',
      name: 'showProfileClient',
      builder: (context, state) => const ShowProfileClientScreen(),
    ),
    GoRoute(
      path: '/showProfileDriver',
      name: 'showProfileDriver',
      builder: (context, state) => const ShowProfileDriverScreen(),
    ),
    GoRoute(
      path: '/showProfileVehicle',
      name: 'showProfileVehicle',
      builder: (context, state) => const ShowProfileVehicleScreen(),
    ),
    GoRoute(
      path: '/profileVehicleInfo',
      name: 'profileVehicleInfo',
      builder: (context, state) => ProfileInfoVehicleScreen(
        vehicle: (state.extra as RegisterVehicleFormEntity),
      ),
    ),
    GoRoute(
      path: '/profileDriverInfo',
      name: 'profileDriverInfo',
      builder: (context, state) => ProfileInfoDriverScreen(
        driver: (state.extra as RegisterTransportFormEntity),
      ),
    ),
    GoRoute(
      path: '/profileClientInfo',
      name: 'profileClientInfo',
      builder: (context, state) => ProfileInfoClientScreen(
          client: (state.extra as RegisterClientFormEntity)),
    ),
    GoRoute(
      path: '/signUpTransport',
      name: 'signUpTransport',
      builder: (context, state) => const SignUpTransportScreen(),
    ),
    GoRoute(
      path: '/homeClient',
      name: 'homeClient',
      builder: (context, state) => const HomeClientScreen(),
    ),
    GoRoute(
      path: '/homeAdmin',
      name: 'homeAdmin',
      builder: (context, state) => const HomeAdminScreen(),
    ),
    GoRoute(
      path: '/homeDriver',
      name: 'homeDriver',
      builder: (context, state) => const HomeDriverScreen(),
    ),
    GoRoute(
      path: '/orderClient',
      name: 'orderClient',
      builder: (context, state) => OrderScreen(
        initView: (state.extra as int),
      ),
    ),
    GoRoute(
      path: '/orderDriver',
      name: 'orderDriver',
      builder: (context, state) => OrdersDriverScreen(
        initView: (state.extra as int),
      ),
    ),
    GoRoute(
      path: '/orderHistoryClient',
      name: 'orderHistoryClient',
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    GoRoute(
      path: '/incident',
      name: 'incident',
      builder: (context, state) => const IncidentScreen(),
    ),
    GoRoute(
      path: '/incidentListOrder',
      name: 'incidentListOrder',
      builder: (context, state) => const IncidentOrdersScreen(),
    ),
    GoRoute(
      path: '/incidentDetail',
      name: 'incidentDetail',
      builder: (context, state) => const IncidentDetailScreen(),
    ),
    GoRoute(
      path: '/registerOrder',
      name: 'registerOrder',
      builder: (context, state) => const RegisterOrderScreen(),
    ),
    GoRoute(
      path: '/registerClient',
      name: 'registerClient',
      builder: (context, state) => const RegisterClientScreen(),
    ),
    GoRoute(
      path: '/registerTransport',
      name: 'registerTransport',
      builder: (context, state) => const RegisterTransportScreen(),
    ),
    GoRoute(
      path: '/registerVehicle',
      name: 'registerVehicle',
      builder: (context, state) => const RegisterVehicleScreen(),
    ),
    GoRoute(
      path: '/showPerishable',
      name: 'showPerishable',
      builder: (context, state) => const ShowPerishableWidget(),
    ),
    GoRoute(
      path: '/showShipment',
      name: 'showShipment',
      builder: (context, state) => const ShowShipmentScreen(),
    ),
    GoRoute(
      path: '/showShipmentUbication',
      name: 'showShipmentUbication',
      builder: (context, state) => const ShowShipmentUbicationScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/route',
      name: 'route',
      builder: (context, state) => const RouteScreen(),
    ),
    GoRoute(
      path: '/searchDestination',
      name: 'searchDestination',
      builder: (context, state) => const SearchDestinationScreen(),
    ),
    GoRoute(
      path: '/rutaDriver',
      name: 'rutaDriver',
      builder: (context, state) => RutaDriverScreen(
        mapa: (state.extra as Map<String, dynamic>),
      ),
    ),
    GoRoute(
      path: '/rutaClient',
      name: 'rutaClient',
      builder: (context, state) => RutaClientScreen(
        mapa: (state.extra as Map<String, dynamic>),
      ),
    ),
    GoRoute(
      path: '/incidenteRegister',
      name: 'incidenteRegister',
      builder: (context, state) => IncidentRegisterScreen(
        idDriver: (state.extra as String),
      ),
    ),
  ],
);
