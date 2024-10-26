import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intermediate_mobile_amcc24/bloc/auth/auth_bloc.dart';
import 'package:intermediate_mobile_amcc24/shared/themes/theme.dart';

import '../routes/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menambahkan text editing controller
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Stack(
            children: [
              Container(
                color: primaryColor,
                height: 320,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Image.asset(
                      "lib/shared/assets/amcc-logo-putih.png",
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(82),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: Text(
                            'Login',
                            style: blackColorTextStyle.copyWith(
                              fontSize: 24,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 32,
                        ),
                        // Email Field
                        Text(
                          'Email',
                          style: blackColorTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: whiteColor,
                            hintText: 'Masukkan email kamu',
                            hintStyle: greyColorTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        Text(
                          'Password',
                          style: blackColorTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: whiteColor,
                            hintText: 'Masukkan password kamu',
                            hintStyle: greyColorTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                            ),
                            suffixIcon: const Icon(Icons.visibility),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    AuthEventLogin(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthStateError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else if (state is AuthStateLogin) {
                                  router.goNamed(Routenames.home);
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthStateLoading) {
                                  return const CircularProgressIndicator();
                                }
                                return Text(
                                  'Login',
                                  style: whiteColorTextStyle.copyWith(
                                      fontSize: 14),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Google Sign-in Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Tambahkan fungsi login dengan Google
                            },
                            icon: Image.asset(
                              'lib/shared/assets/super g (2).png',
                            ),
                            label: Text(
                              'Masuk Dengan Google',
                              style: blackColorTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Sign-up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum memiliki akun?',
                              style: blackColorTextStyle.copyWith(fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () {
                                router.goNamed(Routenames.signup);
                              },
                              child: Text(
                                'Daftar disini',
                                style: primaryColorTextStyle.copyWith(
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
