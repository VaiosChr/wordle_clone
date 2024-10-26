import 'package:flutter/material.dart';
import 'package:wordle_clone/include/helpers.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Wordle Clone',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/home_page3.png')),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).dialogBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Theme.of(context).hoverColor.withOpacity(0.1),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.show_chart,
                            size: 40,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/stats_page');
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/game_page');
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/settings_page');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${getMonthName(today.month)} ${today.day}, ${today.year}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:wordle_clone/include/helpers.dart';

// class FirstPage extends StatelessWidget {
//   const FirstPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var today = DateTime.now();

//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//               'assets/images/home_page.png'), // You'll need to add this image to your assets
//           fit: BoxFit.cover, // This will cover the entire screen
//           // Optional: add an overlay to make the content more readable
//           colorFilter: ColorFilter.mode(
//             Colors.black26,
//             BlendMode.darken,
//           ),
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           scrolledUnderElevation: 0,
//           title: Text(
//             'Wordle Clone',
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   color: Colors.white,
//                 ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(
//                 Icons.help_outline,
//                 size: 28,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/help_page');
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 20,
//                     color: Theme.of(context).hoverColor.withOpacity(0.2),
//                   )
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Welcome back!',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.show_chart,
//                           size: 40,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           Navigator.of(context).pushNamed('/stats_page');
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.play_arrow,
//                           size: 40,
//                           color: Colors.green,
//                         ),
//                         onPressed: () {
//                           Navigator.of(context).pushNamed('/game_page');
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.settings_outlined,
//                           size: 40,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           Navigator.of(context).pushNamed('/settings_page');
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     '${getMonthName(today.month)} ${today.day}, ${today.year}',
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
