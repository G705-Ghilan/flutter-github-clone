import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';

class ReadmeWidget extends StatelessWidget {
  const ReadmeWidget({super.key, required this.username, this.repository});
  final String username;
  final String? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CodeBloc>(
      create: (context) => sl<CodeBloc>()
        ..add(
          LoadCodeEvent(
            CodeParams(
              username: username,
              repository: repository ?? username,
              path: "/README.md",
            ),
          ),
        ),
      child: BlocBuilder<CodeBloc, CodeState>(
        builder: (context, state) {
          if (state is ErrorLoadingFiles) {
            return const PageMessage(
              text: "No Readme",
              icon: Icons.error_outline_outlined,
            );
          }
          FileInfo? readme;
          if (state is LoadedFiles) {
            readme = state.files.first;
          }
          return PrimaryContainer(
            child: ShimmerSkeletonizer(
              enabled: readme == null,
              child: MarkdownWidget(
                text: readme?.content ?? "No Readme",
              ),
            ),
          );
        },
      ),
    );
  }
}
