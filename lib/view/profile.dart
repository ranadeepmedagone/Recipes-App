import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black.withOpacity(0.3),
                backgroundImage: const NetworkImage(
                    "https://scontent.fhyd5-1.fna.fbcdn.net/v/t39.30808-6/216428908_1143450449464711_3174028747127270527_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=A33jqO4QggIAX_1Wyvt&_nc_ht=scontent.fhyd5-1.fna&oh=00_AfBryNgagrodgSY3DDOm1yQ6e50XTJJ4jHrhejUG9C3zKA&oe=63AAEE28",
                    scale: 1.0),
              ),
            ),
            const Text(
              "Hello Ranadeep!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       "",
            //       width: 60,
            //     ),
            //     const SizedBox(width: 10),
            //     Text(
            //       "https://github.com/SinaSys",
            //       style: Theme.of(context).textTheme.headline3,
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
