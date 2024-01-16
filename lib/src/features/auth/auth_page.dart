import 'package:flutter/material.dart';
import 'package:github_clone/dependencies_injection.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  static final GitHubSignIn _gitHubSignIn = GitHubSignIn(
    clientId: 'eab6d6464eafedf18cb0',
    clientSecret: '1c6cd0ef18ec4270ec8b760e79a32bc151dea205',
    redirectUrl: 'https://github-clone-27894.firebaseapp.com/__/auth/handler',
    title: 'GitHub Connection',
    centerTitle: true,
    // scope: "user,gist,user:email,repo",
    scope:
        "user,gist,user:email,repo,read:org,read:user,repo:status,public_repo",
  );

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;
  void signinWithGithub(BuildContext context) async {
    setState(() => isLoading = true);
    await AuthPage._gitHubSignIn.signIn(context).then((result) async {
      switch (result.status) {
        case GitHubSignInResultStatus.ok:
          if (result.token == null) {
            ErrorDialog.show(context, "Error no Token");
          } else {
            final prefs = sl<SharedPreferences>();

            await prefs.setString("token", result.token!).then((_) async {
              await serviceLocator();
              context.go("/profile/<DUSER>");
            });
          }
          setState(() => isLoading = false);

          break;

        case GitHubSignInResultStatus.cancelled:
          setState(() => isLoading = false);
          break;
        case GitHubSignInResultStatus.failed:
          setState(() => isLoading = false);
          ErrorDialog.show(context, result.errorMessage);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SystemArea(
      systemNavigationBarColor: context.colorScheme.surface,
      child: Scaffold(
        body: Padding(
          padding: kPadding,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    kGithubLogo,
                    width: context.screen.width / 3.6,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              Column(
                children: [
                  FilledButton(
                    onPressed: () {
                      if (!isLoading) signinWithGithub(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: kRadius),
                      ),
                      padding: const MaterialStatePropertyAll(kPadding),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 25),
                        const Spacer(),
                        const Text("GET STARTED"),
                        const Spacer(),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: context.colorScheme.primary,
                                  backgroundColor: context.colorScheme.surface,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Continue by Sign in with your personal Github account\nOr create one at Github.com",
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
