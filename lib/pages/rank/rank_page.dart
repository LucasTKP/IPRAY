import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ipray/pages/rank/widgets/table_rank_presenter.dart';
import 'package:ipray/pages/routes/routes_controller.dart';
import 'package:ipray/shared/dependencies.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => {Dependencies.instance.get<RoutesController>().changePage(0)},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 1,
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rank',
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Color(0XFFBF9000)),
                          ),
                          Text(
                            'Top usuários que mais rezaram.',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: SvgPicture.asset(
                        'assets/icons/podium.svg',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TableRankPresenter(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
