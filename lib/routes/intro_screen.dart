import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/controllers/settings_controller.dart';
import 'package:my_notes/routes/home.dart';
import 'package:my_notes/widgets/select_language.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

int activeIndex = 0;
double _imageSize = 0.0;

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    _imageSize = MediaQuery.of(context).size.width;
    final controller = PageController();
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  setState(() => activeIndex = index);
                },
                children: [
                  ScreenView(
                    'assets/images/vector_a.png',
                    'Super Fast',
                    'Storing your notes and to-dos in the least amount of time.',
                  ),
                  ScreenView(
                    'assets/images/vector_b.png',
                    'High Security',
                    'In addition to being fast in storing. your notes are Stored encrypted. and your authentication is done using a password and a biometric system.',
                  ),
                  ScreenView(
                    'assets/images/vector_c.png',
                    'Simple And Advanced User Interface',
                    "for your convenience. We have considered a very attractive, beautiful and simple user interface so that you don't have any problems using this application.",
                  ),
                  SelectLanguageIntro(),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(15),
              ),
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: activeIndex == 0 ? Colors.grey.shade900 : Colors.blue.shade600,
                    ),
                  ),
                  buildIndicator(),
                  IconButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: activeIndex == 3? Colors.grey.shade900 : Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() {
    if (activeIndex == 3) {
      return TextButton(
        child: Text(
          'Get Started',
          style: TextStyle(
            color: Colors.blue.shade600,
            fontFamily: 'Comic',
            fontSize: 25,
            fontWeight: FontWeight.w200,
          ),
        ),
        onPressed: () {
         final controller = Get.find<SettingsController>();
          
          controller.language = language ==  'فارسی' ? 'فارسی': 'English';
          controller.isStarted = true;
          if (controller.language == 'English') {
            Get.updateLocale(const Locale('en', 'US'));
          } else {
            Get.updateLocale(const Locale('fa', 'IR'));
          }
          controller.saveData();
          Get.off(
            Home(),
            transition: Transition.leftToRightWithFade,
          );
        },
      );
    } else {
      return AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 4,
        effect: ExpandingDotsEffect(
          dotWidth: 12,
          dotHeight: 12,
          dotColor: Colors.grey.shade200,
          activeDotColor: Colors.blue.shade600,
        ),
      );
    }
  }

  Widget ScreenView(String imageAddress, String title, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          imageAddress,
          width: _imageSize >= 400 ? 400 : _imageSize,
          height: _imageSize >= 400 ? 400 : _imageSize,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Comic',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Comic',
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget SelectLanguageIntro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/vector_d.jpg',
          width: _imageSize >= 300 ? 300 : _imageSize,
          height: _imageSize >= 300 ? 300 : _imageSize,
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Select the application language',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Comic',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SelectLanguage(
          height: 84,
          text1: 'English',
          text2: 'فارسی',
          borderColor: Colors.blue.shade600,
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Select your desired language from the top section. Later, you can change the language of the app in the settings section.',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Comic',
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
