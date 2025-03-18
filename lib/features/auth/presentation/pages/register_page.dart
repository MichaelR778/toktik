import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/widgets/auth_button.dart';
import 'package:toktik/features/auth/presentation/widgets/auth_nav.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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

            // confirm password
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Confirm password'),
            ),

            const SizedBox(height: 10),

            // register button
            AuthButton(
              text: 'Register',
              onTap: () {
                context.read<AuthCubit>().register(
                  _emailController.text,
                  _passwordController.text,
                  _confirmController.text,
                );
              },
            ),

            const SizedBox(height: 10),

            // go to login page
            AuthNav(
              firstText: 'Already have an account? ',
              secondText: 'Login.',
              togglePage: widget.togglePage,
            ),
          ],
        ),
      ),
    );
  }
}
