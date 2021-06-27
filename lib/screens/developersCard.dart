import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String link;
  final String image;
  const CardWidget(
      {required this.name, required this.link, required this.image});

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(link),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        elevation: 4,
        color: Colors.white.withOpacity(0.3), //colour of cards
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(24))), //Rounded rectangle border for cards
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              Padding(
                //padding between cards and edge of screen
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(image),
                                      fit: BoxFit.fill))),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold), //styleguide function
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: Colors.blue,
                              size: 40,
                            ),
                            onPressed: () => _launchURL(link),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
