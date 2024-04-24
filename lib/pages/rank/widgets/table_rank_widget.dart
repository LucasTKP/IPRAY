import 'package:flutter/material.dart';
import 'package:ipray/pages/rank/widgets/table_rank_controller.dart';

class TableRankPage extends StatelessWidget {
  final TableRankController tableRankController;
  const TableRankPage({super.key, required this.tableRankController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        tableRankController.usersTopRank.isNotEmpty
            ? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 228, 179),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      'Top Rezadores',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, fontFamily: AutofillHints.addressCity),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Divider(
                        thickness: 2,
                        color: Color.fromARGB(255, 0, 0, 0),
                        height: 10,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: tableRankController.usersTopRank.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 2,
                            color: Color(0XFFBF9000),
                            height: 10,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1}º',
                                  style: const TextStyle(fontSize: 22, fontFamily: AutofillHints.addressCity),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    tableRankController.usersTopRank[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text("  ${tableRankController.usersTopRank[index].total}", style: const TextStyle(fontSize: 20, fontFamily: AutofillHints.addressCity)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () => tableRankController.getTop10Rank(),
            child: const Icon(Icons.refresh),
          ),
        ),
        Visibility(
          visible: tableRankController.isLoading,
          child: Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 246, 217)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
