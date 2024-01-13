import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/vs2015.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/code/domain/domain.dart';
import 'package:github_clone/src/features/code/presentation/bloc/code_bloc.dart';
import 'package:github_clone/src/features/code/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({
    super.key,
    required this.params,
    required this.isFolder,
  });
  final CodeParams params;
  final bool isFolder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFolder ? null : vs2015Theme["root"]!.backgroundColor,
      body: SystemArea(
        systemNavigationBarColor: isFolder
            ? context.colorScheme.background
            : vs2015Theme["root"]!.backgroundColor,
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title: params.username,
              subtitle:
                  "${params.repository}${params.path.startsWith('/') ? '' : '/'}${params.path}",
            ),
            BlocProvider<CodeBloc>(
              create: (context) => sl<CodeBloc>()
                ..add(
                    isFolder ? LoadFilesEvent(params) : LoadCodeEvent(params)),
              child: BlocBuilder<CodeBloc, CodeState>(
                builder: (context, state) {
                  if (state is ErrorLoadingFiles) {
                    return SliverFillRemaining(
                      child: PageMessage(
                        icon: Icons.error_outline_rounded,
                        text: getFailureMessage(state.failure),
                      ),
                    );
                  }
                  List<FileInfo>? files;
                  if (state is LoadedFiles) {
                    files = state.files;
                    if (files.length > 1) {
                      files = sortedFiles(files);
                    }
                  }
                  if (files?.isEmpty ?? false) {
                    return const SliverFillRemaining(
                      child: PageMessage(
                        text: "No Files",
                        icon: Icons.show_chart_rounded,
                      ),
                    );
                  }
                  if (!isFolder) {
                    final FileInfo file = files?.first ?? FileInfo.fake();
                    return SliverToBoxAdapter(
                      child: ShimmerSkeletonizer(
                        enabled: files == null,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: HighlightView(
                                file.content.toString(),
                                language: file.name.split(".").last,
                                theme: vs2015Theme,
                                tabSize: 2,
                                padding: kPadding.copyWith(top: 50),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  await file.content?.copy(context);
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: kPadding,
                    sliver: SliverList.builder(
                      itemCount: files?.length ?? 6,
                      itemBuilder: (context, index) {
                        final FileInfo file = files?[index] ?? FileInfo.fake();
                        return ShimmerSkeletonizer(
                          enabled: files == null,
                          child: FileItem(
                            file: file,
                            onTap: () {
                              context.push(
                                "/contents/${params.username}/${params.repository}",
                                extra: [file.isFolder, file.path],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<FileInfo> sortedFiles(List<FileInfo> unsortedFiles) {
    List<FileInfo> folders = [];
    List<FileInfo> files = [];
    for (FileInfo file in unsortedFiles) {
      file.isFolder ? folders.add(file) : files.add(file);
    }

    folders.sort((a, b) => a.name.compareTo(b.name));
    files.sort((a, b) => a.name.compareTo(b.name));

    return [...folders, ...files];
  }
}
