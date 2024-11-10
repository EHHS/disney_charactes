import 'package:flutter/material.dart';
import 'package:infinit_task/models/paginated_info.dart';
import 'package:infinit_task/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<PaginationProvider, PaginationInfo?>(
      selector: (context, provider) => provider.paginationInfo,
      builder: (context, paginationInfo, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dashboard Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            if (paginationInfo != null)
              Column(
                children: [
                  Text('Total Pages: ${paginationInfo.totalPages}'),
                  Text('Total Characters: ${paginationInfo.count}'),
                  if (paginationInfo.previousPage != null)
                    Text('Previous Page: ${paginationInfo.previousPage}'),
                  if (paginationInfo.nextPage != null)
                    Text('Next Page: ${paginationInfo.nextPage}'),
                ],
              )
            else
              const Text('Loading pagination info...'),
          ],
        );
      },
    );
  }
}
