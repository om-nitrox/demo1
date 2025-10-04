import 'package:flutter/material.dart';
import 'widgets/donut_chart.dart';

class CallDashboardScreen extends StatelessWidget {
  const CallDashboardScreen({
    super.key,
    required this.listName,
    required this.calls,
    required this.pending,
    required this.done,
    required this.schedule,
  });

  final String listName;
  final int calls;
  final int pending;
  final int done;
  final int schedule;

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
        actions: const [
          Icon(Icons.support_agent_outlined),
          SizedBox(width: 12),
          Icon(Icons.settings_outlined),
          SizedBox(width: 12),
        ],
      ),
      drawer: _AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable section with list card and centered larger bold chart
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _ListCard(title: listName, calls: calls),
                    const SizedBox(
                      height: 32,
                    ), // Extra spacing for visual balance
                    Center(
                      child: SizedBox(
                        width: 280, // Increased size for larger chart
                        height: 280,
                        child: DonutChart(
                          values: <double>[
                            pending.toDouble(),
                            done.toDouble(),
                            schedule.toDouble(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Metrics row with bold labels, just above the button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _Metric(
                    label: 'Pending',
                    value: pending,
                    color: const Color(0xFFFFE9CF),
                  ),
                  const SizedBox(width: 12),
                  _Metric(
                    label: 'Done',
                    value: done,
                    color: const Color(0xFFDFF8E8),
                  ),
                  const SizedBox(width: 12),
                  _Metric(
                    label: 'Schedule',
                    value: schedule,
                    color: const Color(0xFFEDE8FF),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Start Calling Now button full-width at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Button action logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Calling Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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

class _ListCard extends StatelessWidget {
  const _ListCard({required this.title, required this.calls});
  final String title;
  final int calls;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$calls',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 4),
                    const Text('CALLS'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 40, 
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(
                8,
              ), // adjust for rounded corners
            ),
            alignment: Alignment.center,
            child: const Text(
              'o',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$value',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Text('Calls', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
