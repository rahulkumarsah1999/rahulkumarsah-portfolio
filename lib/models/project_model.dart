class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final String status;

  final bool isFeatured;

  final List<String> images;

  final List<String> keyFeatures;

  final List<Map<String, dynamic>> techStack;

  final List<String> challengesSolved;

  final String? githubUrl;
  final String? liveUrl;

  final bool isPortfolio;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.status,
    required this.isFeatured,
    required this.images,
    required this.keyFeatures,
    required this.techStack,
    required this.challengesSolved,
    this.githubUrl,
    this.liveUrl,
    this.isPortfolio = false,
  });
}