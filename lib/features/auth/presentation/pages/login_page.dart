import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenhealth/core/di/injection.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';
import 'package:sevenhealth/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sevenhealth/features/auth/presentation/bloc/auth_event.dart';
import 'package:sevenhealth/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login successful!'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            } else if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(AppTheme.spacingMd),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Demo credentials text
                    Padding(
                      padding: EdgeInsets.only(bottom: AppTheme.spacingMd),
                      child: Text(
                        'Demo Credentials: test@example.com / password123',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppTheme.spacingMd),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppTheme.spacingLg),

                    // Login button
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(
                                      SignInEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: AppTheme.spacingMd,
                        ),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('LOGIN'),
                    ),
                    SizedBox(height: AppTheme.spacingMd),

                    // Register link
                    TextButton(
                      onPressed: () {
                        // Navigate to register page
                      },
                      child: const Text('Don\'t have an account? Register'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
