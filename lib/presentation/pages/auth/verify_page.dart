  import 'dart:async';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:study_hub/logic/backend/fire_funcs.dart';
  import 'package:study_hub/presentation/pages/auth/sign_up_in.dart';
  import 'package:study_hub/presentation/pages/user/user_details.dart';
  import 'package:study_hub/logic/config/theme/app_theme.dart';

  class VerifyPage extends StatefulWidget {
    const VerifyPage({super.key});

    @override
    State<VerifyPage> createState() => _VerifyPageState();
  }

  class _VerifyPageState extends State<VerifyPage> {
    bool isEmailVerified = false;
    bool canResendEmail = false;
    Timer? _timer;
    int _remainingSeconds = 120;
    Timer? _checkVerificationTimer;
    String? _userId;

    void _getCurrentUser() async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          _userId = user.uid;
        });
      }
    }

    @override
    void initState() {
      final user = FirebaseAuth.instance.currentUser;
      _getCurrentUser();
      isEmailVerified = user!.emailVerified;

      if (!isEmailVerified) {
        sendVerificationEmail();
        startTimer();
        startVerificationCheckTimer();
      }

      super.initState();
    }

    @override
    void dispose() {
      _timer?.cancel();
      _checkVerificationTimer?.cancel();
      super.dispose();
    }

    void startTimer() {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_remainingSeconds > 0) {
          if (mounted) {
            setState(() {
              _remainingSeconds--;
            });
          }
        } else {
          timer.cancel();
          if (mounted) {
            setState(() {
              canResendEmail = true;
            });
          }
        }
      });
    }

    void startVerificationCheckTimer() {
      _checkVerificationTimer?.cancel();
      _checkVerificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        await checkEmailVerified();
        if (isEmailVerified) {
          timer.cancel();
          _checkVerificationTimer = null;
        }
      });
    }

    Future<void> checkEmailVerified() async {
      if (!mounted) return;
      
      await FirebaseAuth.instance.currentUser!.reload();
      if (!mounted) return;

      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      if (isEmailVerified) {
        _timer?.cancel();
        _timer = null;
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserData()),
          );
        }
      }
    }

    Future<void> sendVerificationEmail() async {
      try {
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification();
        if (mounted) {
          setState(() {
            canResendEmail = false;
            _remainingSeconds = 120; // Reset timer for resend
            startTimer();
          });
        }
      } catch (e) {
        debugPrint('$e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e.'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Container(
                    height: 620,
                    width: 350,
                    decoration: BoxDecoration(
                        color: AppTheme.mainColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Проверка Email',
                                style: TextStyles.ruberoidLight22,
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 535,
                            width: 400,
                            decoration: BoxDecoration(
                                color: AppTheme.secondaryColor,
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  (_remainingSeconds > 0)
                                      ? 'Осталось: $_remainingSeconds секунд'
                                      : 'Время истекло',
                                  style: TextStyles.ruberoidRegular20,
                                ),
                                const Icon(Icons.mark_email_unread,
                                    color: Colors.white54, size: 200),
                                GestureDetector(
                                  onTap: canResendEmail
                                      ? sendVerificationEmail
                                      : null,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 100),
                                    height: 60,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: canResendEmail
                                            ? AppTheme.mainElementColor
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(40)),
                                    child: const Center(
                                        child: Text(
                                      'Отправить повторно',
                                      style: TextStyles.ruberoidLight16,
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpInPage()),
                                        );
                                        FirebaseService().deleteAcc(_userId!);
                                      },
                                      child: const Text(
                                        'Вернуться назад?',
                                        style: TextStyles.ruberoidLight15,
                                      )),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
