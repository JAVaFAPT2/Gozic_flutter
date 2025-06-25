import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Temporary data model for a post while waiting for backend / real models.
class _Post {
  final String author;
  final String avatarUrl;
  final String role;
  final String timestamp;
  final String content;
  final String imageUrl;
  final int likes;
  final int comments;
  final int shares;

  const _Post({
    required this.author,
    required this.avatarUrl,
    required this.role,
    required this.timestamp,
    required this.content,
    required this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  // Dummy feed data – will be replaced once real assets/API are wired in.
  final _posts = const [
    _Post(
      author: 'Mot Nguyen',
      avatarUrl: 'https://via.placeholder.com/150',
      role: 'Thợ vườn tập sự',
      timestamp: '15 phút',
      content: 'Chào mọi người đây là cây mới của mình. Hãy theo dõi mình nhé!',
      imageUrl: 'https://via.placeholder.com/600x600',
      likes: 28,
      comments: 10,
      shares: 1,
    ),
    _Post(
      author: 'Dang Quang Vu',
      avatarUrl: 'https://via.placeholder.com/150',
      role: 'Người đóng góp tiêu biểu',
      timestamp: '2 giờ',
      content:
          'Có thể bạn chưa biết một số loại cây cần lau sạch lớp bụi trên lá thường xuyên để giúp...',
      imageUrl: 'https://via.placeholder.com/600x500',
      likes: 334,
      comments: 134,
      shares: 53,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: [
          _buildFeed(context),
          const Center(child: Text('Thư viện')),
          const Center(child: Text('Tạo bài viết')),
          const Center(child: Text('Thông báo')),
          const Center(child: Text('Vườn cây')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: const Color(0xFF777B84),
        type: BottomNavigationBarType.fixed,
        items: [
          _navItem(
            label: 'Trang chủ',
            icon: 'assets/icons/nav_home.svg',
            activeIcon: 'assets/icons/nav_home_active.svg',
          ),
          _navItem(
            label: 'Thư viện',
            icon: 'assets/icons/nav_book.svg',
            activeIcon: 'assets/icons/nav_book_active.svg',
          ),
          _navItem(
            label: 'Bài viết',
            icon: 'assets/icons/nav_plus.svg',
            activeIcon: 'assets/icons/nav_plus_active.svg',
          ),
          _navItem(
            label: 'Thông báo',
            icon: 'assets/icons/nav_bell.svg',
            activeIcon: 'assets/icons/nav_bell_active.svg',
          ),
          _navItem(
            label: 'Vườn cây',
            icon: 'assets/icons/nav_garden.svg',
            activeIcon: 'assets/icons/nav_garden_active.svg',
          ),
        ],
      ),
    );
  }

  Widget _buildFeed(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: theme.colorScheme.primary,
          pinned: true,
          expandedHeight: 54,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Color(0xFF777B84)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Tìm kiếm',
                              style: TextStyle(color: Color(0xFF777B84)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPersistentHeader(pinned: true, delegate: _CategoryTabsDelegate()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => _PostCard(post: _posts[i]),
            childCount: _posts.length,
          ),
        ),
      ],
    );
  }
}

class _CategoryTabsDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    return Container(
      height: 45,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFB7BBC1), width: 0.5),
        ),
        color: Colors.white,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        children: [
          _CategoryChip(label: 'Tất cả', selected: true),
          _CategoryChip(label: 'Kinh nghiệm'),
          _CategoryChip(label: 'Đời sống'),
          _CategoryChip(label: 'Hỏi đáp'),
          _CategoryChip(label: 'Khác'),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _CategoryChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : const Color(0xFF777B84);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.avatarUrl),
                  radius: 25,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.more_horiz, size: 20),
                        ],
                      ),
                      Text(post.role, style: const TextStyle(fontSize: 10)),
                      Row(
                        children: [
                          Text(
                            '${post.timestamp} • ',
                            style: const TextStyle(fontSize: 10),
                          ),
                          const Icon(
                            Icons.public,
                            size: 12,
                            color: Color(0xFF777B84),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(post.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${post.likes} lượt thích',
                  style: const TextStyle(fontSize: 10),
                ),
                Text(
                  '${post.comments} bình luận',
                  style: const TextStyle(fontSize: 10),
                ),
                Text(
                  '${post.shares} lượt chia sẻ',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _PostAction(icon: Icons.favorite_border, label: 'Thích'),
                _PostAction(
                  icon: Icons.mode_comment_outlined,
                  label: 'Bình luận',
                ),
                _PostAction(icon: Icons.send_outlined, label: 'Chia sẻ'),
                _PostAction(icon: Icons.bookmark_border, label: 'Lưu'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PostAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF777B84)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

BottomNavigationBarItem _navItem({
  required String label,
  required String icon,
  required String activeIcon,
}) {
  return BottomNavigationBarItem(
    icon: _SvgIcon(path: icon),
    activeIcon: _SvgIcon(path: activeIcon),
    label: label,
  );
}

class _SvgIcon extends StatelessWidget {
  final String path;
  const _SvgIcon({required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2), // align visually like Figma
      child: SizedBox(
        height: 22,
        width: 22,
        child: SvgPicture.asset(path, fit: BoxFit.contain),
      ),
    );
  }
}
