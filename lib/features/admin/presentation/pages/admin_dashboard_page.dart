import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';
import '../../../booking/domain/entities/booking.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(LoadAllBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Light Slate background
      appBar: AppBar(
        title: const Text('Admin Command Center', 
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A), // Very dark blue
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined, color: Colors.blueAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => context.read<AdminBloc>().add(LoadAllBookingsEvent()),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: isMobile ? Drawer(child: _buildSidebarContent()) : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 260,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: _buildSidebarContent(),
            ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 15.0 : 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modern Analytics Cards
                  _buildAnalyticsHeader(isMobile),
                  
                  const SizedBox(height: 30),
                  
                  const Text(
                    'Real-time Activity Feed',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 15),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, spreadRadius: 5)
                      ],
                    ),
                    child: BlocBuilder<AdminBloc, AdminState>(
                      builder: (context, state) {
                        if (state is AdminLoading) {
                          return const Center(child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: CircularProgressIndicator(),
                          ));
                        } else if (state is AdminBookingsLoaded) {
                          if (state.bookings.isEmpty) {
                            return const Center(child: Padding(
                              padding: EdgeInsets.all(40.0),
                              child: Text('Hozircha faollik yo\'q'),
                            ));
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.bookings.length,
                            separatorBuilder: (context, index) => const Divider(height: 1, indent: 70),
                            itemBuilder: (context, index) {
                              final booking = state.bookings[index];
                              return _buildModernTableRow(context, booking, isMobile);
                            },
                          );
                        }
                        return const Center(child: Text('Ma\'lumot yuklashda xato'));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsHeader(bool isMobile) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: isMobile ? 2 : 4,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: isMobile ? 1.2 : 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard('Bandlik', '85%', Icons.door_front_door, Colors.blue),
        _buildStatCard('Bugungi tushum', '\$2,450', Icons.payments_outlined, Colors.green),
        _buildStatCard('Yangi bronlar', '12', Icons.add_chart, Colors.orange),
        _buildStatCard('Xizmatlar', '8', Icons.room_service, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSidebarContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          color: const Color(0xFF0F172A),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.orange,
                child: Icon(Icons.security, color: Colors.white, size: 35),
              ),
              SizedBox(height: 10),
              Text('Asilbek Xushvaqtov', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text('Super Admin', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
        _buildMenuItem(Icons.dashboard_customize_outlined, 'Dashboard', isActive: true),
        _buildMenuItem(Icons.hotel_class_outlined, 'Smart Xonalar'),
        _buildMenuItem(Icons.people_alt_outlined, 'Mehmonlar'),
        _buildMenuItem(Icons.settings_input_component_outlined, 'IoT Sozlamalar'),
        const Spacer(),
        _buildMenuItem(Icons.logout, 'Chiqish', isDestructive: true),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isActive = false, bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : (isActive ? Colors.blue : Colors.blueGrey)),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : (isActive ? Colors.blue : Colors.blueGrey),
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildModernTableRow(BuildContext context, Booking booking, bool isMobile) {
    final bool isPending = booking.status == 'Pending';
    final String formattedDate = DateFormat('HH:mm | dd.MM').format(booking.createdAt);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isPending ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isPending ? Icons.bolt_outlined : Icons.verified_user_outlined,
              color: isPending ? Colors.orange : Colors.green,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Room ${booking.roomId}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Booking ID: ${booking.id}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          if (!isMobile)
            Text(formattedDate, style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500)),
          const SizedBox(width: 20),
          if (isPending)
            ElevatedButton(
              onPressed: () => context.read<AdminBloc>().add(UpdateBookingStatusEvent(bookingId: booking.id, status: 'Confirmed')),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Confirm'),
            )
          else
            const Chip(
              label: Text('Verified'),
              backgroundColor: Color(0xFFDCFCE7),
              labelStyle: TextStyle(color: Color(0xFF166534), fontSize: 12),
            ),
        ],
      ),
    );
  }
}
