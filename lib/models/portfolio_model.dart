
class PortfolioModel {
  // Hero section
  final String name;
  final String role;

  final String imagePath;
  final String available;

  // About Section
final String about;

// Contact
final String email;
final String phone;
final String location;

// Social Links
final List<Map<String, dynamic>> socialLinks;
final List<Map<String, dynamic>> availableFor;
final Map<String, dynamic> formHeader;
final Map<String, dynamic> heroDescription;

// Skills
final List<Map<String, dynamic>> skills;

// stats
final List<Map<String, dynamic>> stats;

  // Snapshot Item
final List<Map<String, dynamic>> snapItems;

// Projects

// Card

// TechStack
  final List<Map<String, dynamic>> techStack;
  final List<Map<String, dynamic>> otherIcons;

  // card
  final List<Map<String, dynamic>> cardDetail;

PortfolioModel({
    required this.name,
    required this.email,
    required this.role,
    required this.imagePath,
    required this.available,
    required this.about,
    required this.phone,
    required this .location,
    required this .socialLinks,
    required this .availableFor,
    required this .cardDetail,
    required this .skills,
    required this .stats,
    required this .formHeader,
    required this .snapItems,
    required this .techStack,
    required this .otherIcons,
    required this .heroDescription,
});
}