class Mentor {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double hourlyRate;
  final List<String> skills;
  final bool isCertified;
  final String bio;
  final List<String> languages;

  const Mentor({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.hourlyRate,
    required this.skills,
    this.isCertified = false,
    required this.bio,
    required this.languages,
  });
}

class Session {
  final String id;
  final Mentor mentor;
  final DateTime dateTime;
  final String topic;
  final bool isUpcoming;

  const Session({
    required this.id,
    required this.mentor,
    required this.dateTime,
    required this.topic,
    required this.isUpcoming,
  });
}

// Mock Data
final List<Mentor> kMockMentors = [
  Mentor(
    id: '1',
    name: 'Sarah Jenkins',
    title: 'Senior Flutter Developer',
    imageUrl: 'https://i.pravatar.cc/150?u=1',
    rating: 4.9,
    reviewCount: 120,
    hourlyRate: 50.0,
    skills: ['Flutter', 'Dart', 'Firebase', 'Clean Architecture'],
    isCertified: true,
    bio:
        'Passionate Flutter developer with 5+ years of experience building scalable mobile apps. I love teaching and helping others grow.',
    languages: ['English', 'Spanish'],
  ),
  Mentor(
    id: '2',
    name: 'David Chen',
    title: 'Product Designer',
    imageUrl: 'https://i.pravatar.cc/150?u=2',
    rating: 4.8,
    reviewCount: 85,
    hourlyRate: 45.0,
    skills: ['UI/UX', 'Figma', 'Prototyping'],
    isCertified: true,
    bio:
        'Product designer focused on creating intuitive and beautiful user experiences.',
    languages: ['English', 'Mandarin'],
  ),
  Mentor(
    id: '3',
    name: 'Emily Davis',
    title: 'Backend Engineer',
    imageUrl: 'https://i.pravatar.cc/150?u=3',
    rating: 4.7,
    reviewCount: 60,
    hourlyRate: 55.0,
    skills: ['Node.js', 'Python', 'AWS'],
    isCertified: false,
    bio:
        'Backend wizard who loves solving complex problems and optimizing performance.',
    languages: ['English'],
  ),
  Mentor(
    id: '4',
    name: 'Michael Brown',
    title: 'Mobile Architect',
    imageUrl: 'https://i.pravatar.cc/150?u=4',
    rating: 5.0,
    reviewCount: 200,
    hourlyRate: 80.0,
    skills: ['iOS', 'Android', 'System Design'],
    isCertified: true,
    bio:
        'Architecting mobile solutions for enterprise clients. Let\'s build something great together.',
    languages: ['English', 'German'],
  ),
];

final List<Session> kMockSessions = [
  Session(
    id: 's1',
    mentor: kMockMentors[0],
    dateTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
    topic: 'Flutter State Management Review',
    isUpcoming: true,
  ),
  Session(
    id: 's2',
    mentor: kMockMentors[1],
    dateTime: DateTime.now().subtract(const Duration(days: 2)),
    topic: 'Portfolio Review',
    isUpcoming: false,
  ),
];
