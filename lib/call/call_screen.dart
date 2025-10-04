import 'package:demo/call/call_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://app.getcalley.com');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        actions: const <Widget>[
          Icon(Icons.support_agent_outlined),
          SizedBox(width: 12),
          Icon(Icons.notifications_outlined),
          SizedBox(width: 12),
        ],
      ),
      drawer: _AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Blue header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: const <Widget>[
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Hello Swati',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Welcome to Calley!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // White box floating over blue header with curves
                        Positioned(
                          top: 100,
                          left: 16,
                          right: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1E3365),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1E3365),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'LOAD NUMBER TO CALL',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(26),color: Colors.white),
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: _launchUrl,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'Visit https://app.getcalley.com to upload\nnumbers that you wish to call using Calley\nMobile App.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                height: 1.4,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/img2.png",
                                              height: 260,
                                              width: 280,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(color: const Color.fromARGB(255, 13, 223, 38)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Color(0xFF25D366),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          _showCallingLists(context);
                        },
                        child: const Text(
                          'Start Calling Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7FB),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              Icon(Icons.home_outlined, color: Color(0xFF666666)),
              Icon(Icons.list_alt, color: Color(0xFF666666)),
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF2563EB),
                child: Icon(Icons.play_arrow, color: Colors.white, size: 20),
              ),
              Icon(Icons.link_outlined, color: Color(0xFF666666)),
              Icon(Icons.settings_outlined, color: Color(0xFF666666)),
            ],
          ),
        ),
      ),
    );
  }

  void _showCallingLists(BuildContext rootContext) {
    showModalBottomSheet<void>(
      context: rootContext,
      backgroundColor: Color(0xFF1E3365),
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: const Color(0xFF1E3365),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top blue header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3365),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'CALLING LISTS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // White container with rounded rows
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Select Calling List row
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: const Text('Select Calling List'),
                                trailing: FilledButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.refresh, size: 18),
                                  label: const Text('Refresh'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF2563EB),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Test List row
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: const Text('Test List'),
                                trailing: const Icon(Icons.chevron_right_rounded),
                                onTap: () {
                                  Navigator.push(rootContext, MaterialPageRoute(builder: (context) => CallDashboardScreen(listName:"Calls", calls: 50, pending: 28, done: 22, schedule: 09),));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(0, 203, 213, 225), // Drawer background
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Curved Header
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(26)
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const <Widget>[
                  // Square Avatar instead of circle
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Om  •  Personal',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Om.nitrox.21@gmail.com',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Items
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Color(0xFFCBD5E1)),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const <Widget>[
                    _DrawerItem(
                      icon: Icons.flag_outlined,
                      label: 'Getting Started',
                    ),
                    _DrawerItem(icon: Icons.sync, label: 'Sync Data'),
                    _DrawerItem(
                      icon: Icons.emoji_events_outlined,
                      label: 'Gamification',
                    ),
                    _DrawerItem(
                      icon: Icons.bug_report_outlined,
                      label: 'Send Logs',
                    ),
                    _DrawerItem(
                        icon: Icons.settings_outlined, label: 'Settings'),
                    _DrawerItem(icon: Icons.help_outline, label: 'Help?'),
                    _DrawerItem(
                      icon: Icons.cancel_outlined,
                      label: 'Cancel Subscription',
                    ),
                
                    // Divider + App Info Heading
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        'App Info',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF2563EB), // Blue heading
                        ),
                      ),
                    ),
                
                    _DrawerItem(icon: Icons.info_outline, label: 'About Us'),
                    _DrawerItem(
                      icon: Icons.privacy_tip_outlined,
                      label: 'Privacy Policy',
                    ),
                    _DrawerItem(
                      icon: Icons.verified_outlined,
                      label: 'Version 1.01.52',
                    ),
                    _DrawerItem(icon: Icons.share_outlined, label: 'Share App'),
                    _DrawerItem(icon: Icons.logout, label: 'Logout'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Drawer Item with rounded square icon background
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DrawerItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF4FE), // Icon background
          borderRadius: BorderRadius.circular(12), // Rounded square
        ),
        child: Icon(
          icon,
          color: const Color(0xFF2563EB), // Icon color
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF223A74),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {},
    );
  }
}