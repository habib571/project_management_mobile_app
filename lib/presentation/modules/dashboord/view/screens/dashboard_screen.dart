import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_card.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h,) ,
              Text(
                  'My Workspaces(projects)' ,
                  style: robotoBold.copyWith(fontSize: 18)
              ),
              SizedBox(height: 25,) ,
              _showProjects() ,
              const SizedBox(height: 30,) ,
              Center(child: _showIndicators())

            ],
          ),
        ),
      ),
    );
  }

  Widget _showProjects() {
    return CarouselSlider(
        items: const [ProjectCard(), ProjectCard(), ProjectCard()],
        options: CarouselOptions(
          height: 150.h,
          padEnds: false,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 200),
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
          scrollDirection: Axis.horizontal,
        ));
  }
  Widget _showIndicators()  {
    return AnimatedSmoothIndicator(

      axisDirection: Axis.horizontal,
      activeIndex: _current,
      count: 3,
      effect: const WormEffect(),
    ) ;

  }
}
