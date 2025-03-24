import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/auth/presentation/pages/auth_page.dart';
import 'package:toktik/features/profile/presentation/pages/profile_page.dart';
import 'package:toktik/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()..checkAuthState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // authenticated
            if (state is Authenticated) {
              return Root();
            }

            // unauthenticated
            return AuthPage();
          },
        ),
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currIndex = 0;

  // final List<Widget> _pages = [];

  final List<Widget> _navBarItems = [
    NavigationDestination(
      icon: Icon(Icons.home, color: Colors.grey),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.search, color: Colors.grey),
      selectedIcon: Icon(Icons.search),
      label: 'Search',
    ),
    NavigationDestination(
      icon: Icon(Icons.add, color: Colors.grey),
      selectedIcon: Icon(Icons.add),
      label: 'Post',
    ),
    NavigationDestination(
      icon: Icon(Icons.message, color: Colors.grey),
      selectedIcon: Icon(Icons.message),
      label: 'Message',
    ),
    NavigationDestination(
      icon: Icon(Icons.person, color: Colors.grey),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currIndex,
        children: [
          Scaffold(),
          Scaffold(),
          Scaffold(),
          Scaffold(),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final userId = (state as Authenticated).user.id;
              return ProfilePage(userId: userId);
            },
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NavigationBar(
          selectedIndex: _currIndex,
          onDestinationSelected: (index) {
            if (index != 2) {
              setState(() {
                _currIndex = index;
              });
            }
          },
          destinations: _navBarItems,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthCubit>().logout(),
      ),
    );
  }
}
