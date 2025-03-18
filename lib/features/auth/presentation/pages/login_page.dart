import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/widgets/auth_button.dart';
import 'package:toktik/features/auth/presentation/widgets/auth_nav.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),

            const SizedBox(height: 10),

            // password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),

            const SizedBox(height: 10),

            // login button
            AuthButton(
              text: 'Login',
              onTap: () {
                context.read<AuthCubit>().login(
                  _emailController.text,
                  _passwordController.text,
                );
              },
            ),

            const SizedBox(height: 10),

            // go to register page
            AuthNav(
              firstText: 'Don\'t have an account? ',
              secondText: 'Register.',
              togglePage: widget.togglePage,
            ),
          ],
        ),
      ),
    );
  }
}
