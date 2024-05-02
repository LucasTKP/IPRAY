import 'package:flutter/material.dart';
import 'package:ipray/pages/rank/widgets/table_rank_controller.dart';

class TableRankPage extends StatelessWidget {
  final TableRankController tableRankController;
  const TableRankPage({super.key, required this.tableRankController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => tableRankController.setIsTopTotal(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tableRankController.isTopTotal ? const Color.fromARGB(255, 237, 222, 177) : Colors.transparent,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0), 
                          ),
                        ),
                        foregroundColor: const Color.fromARGB(255, 124, 110, 67),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Total",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: double.infinity,
                    color: const Color(0XFFBF9000),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => tableRankController.setIsTopTotal(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !tableRankController.isTopTotal ? const Color.fromARGB(255, 237, 222, 177) : Colors.transparent,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0), 
                          ),
                        ),
                        foregroundColor: const Color.fromARGB(255, 124, 110, 67),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Seguidos",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: const Color(0XFFBF9000),
                width: MediaQuery.sizeOf(context).width,
                height: 2,
              ),
            )
          ],
        ),
        Stack(children: [
          Column(
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(top: 10, right: 10, bottom: 3),
                child: InkWell(
                  onTap: () {
                    if (tableRankController.isTopTotal) {
                      tableRankController.getTop10Rank();
                    } else {
                      tableRankController.getTop10ConsecutiveDays();
                    }
                  },
                  child: const Icon(Icons.refresh),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 228, 179),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(children: [
                  Container(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: tableRankController.isTopTotal ? tableRankController.usersTopRank.length : tableRankController.usersTopConsecultiveDays.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 2,
                          color: Color(0XFFBF9000),
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var dataRank = tableRankController.isTopTotal ? tableRankController.usersTopRank[index] : tableRankController.usersTopConsecultiveDays[index];
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
                                  dataRank.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 22),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${tableRankController.isTopTotal ? dataRank.total : dataRank.streak}",
                                style: const TextStyle(fontSize: 20, fontFamily: AutofillHints.addressCity),
                              ),
                            ],
                          ),
                        );
                      },
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
                ]),
              ),
            ],
          ),
        ]),
      ],
    );
  }
}
