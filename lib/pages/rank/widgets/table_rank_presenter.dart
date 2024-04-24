import 'package:flutter/material.dart';
import 'package:ipray/pages/rank/widgets/table_rank_controller.dart';
import 'package:ipray/pages/rank/widgets/table_rank_widget.dart';
import 'package:ipray/shared/dependencies.dart';

class TableRankPresenter extends StatefulWidget {
  const TableRankPresenter({super.key});

  @override
  State<TableRankPresenter> createState() => _TableRankPresenterState();
}

class _TableRankPresenterState extends State<TableRankPresenter> {
  late TableRankController tableRankController;

  @override
  void initState() {
    super.initState();
    tableRankController = TableRankControllerImp(supabaseController: Dependencies.instance.get(), appNavigator: Dependencies.instance.get());
    tableRankController.getTop10Rank();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: tableRankController,
        builder: (_, child) {
          return TableRankPage(
            tableRankController: tableRankController,
          );
        });
  }
}
