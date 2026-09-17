import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la8iny/core/utils/app_colors.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/widgets/search_results_view.dart';
import 'package:la8iny/features/tabs/chat_tab/presentation/widgets/search_text_field.dart';

class SearchScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkTeal,
        title: const Text('Search Screen', style: TextStyle(fontWeight: .bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchTextField(
              onChanged: (query) {
                context.read<SearchBloc>().add(SearchEvent(query));
              },
            ),
            const SizedBox(height: 12),
            const Expanded(child: SearchResultsView()),
          ],
        ),
      ),
    );
  }
}
