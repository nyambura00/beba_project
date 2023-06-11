import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Need help? Contact Us'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // background color
                foregroundColor: Colors.white, // text color
                elevation: 2, // button shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // button border radius
                ),
              ),
              child: const Text('Call Beba',)
            ),
            const SizedBox( width: 10.0 ,),
            ElevatedButton(
              onPressed: () => {
                
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // background color
                foregroundColor: Colors.white, // text color
                elevation: 5, // button shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // button border radius
                ),
              ),
              child: const Text('Email Beba')
            ),
          ],
        ),
      ],
    );
  }
}