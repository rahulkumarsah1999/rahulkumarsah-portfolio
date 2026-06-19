import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart'; // Aapke customized project colors ke liye

class ProjectData {
  static final List<ProjectModel> myProjects = [
    // 1. NEW FEATURED PROJECT: Portfolio Website
    ProjectModel(
      title: "Portfolio Website",
      subtitle: "Personal Flutter Web Portfolio",
      description:
          "A fully responsive and interactive portfolio website built using Flutter Web featuring smooth animations, dark/light mode, project showcases, and modern UI design.",
      status: "Completed",
      isFeatured: true,
      isPortfolio: true,
      images: [
        'assets/images/portfolio_mockup.png',
      ],
      keyFeatures: [
        'Fully responsive UI',
        'Dark & light theme',
        'Smooth animations',
        'Project showcase system',
        'Interactive contact section',
        'Reusable architecture',
      ],
      techStack: [
        {
          'name': 'Flutter',
          'color': const Color(0xFF02569B),
        },
        {
          'name': 'Dart',
          'color': const Color(0xFF0175C2),
        },
        {
          'name': 'Riverpod',
          'color': const Color(0xFF5E35B1),
        },
        {
          'name': 'Rest API',
          'color': const Color(0xFFC3B480),
        },
        {
          'name': 'EmailJS',
          'color': const Color(0xFFFF8E1A),
        },
      ],
      challengesSolved: [
        'Responsive layout system',
        'Theme switching logic',
        'Smooth navigation flow',
        'Reusable widget architecture',
      ],
      githubUrl: 'https://github.com/rahulkumarsah1999',
      liveUrl: null,
    ),

    // 2. FEATURED PROJECT: QuizOPro
    ProjectModel(
      title: "QuizOPro",
      subtitle: "Smart Quiz & Learning Platform",
      description:
          "A modern quiz platform built with Flutter allowing users to explore categories, attempt quizzes, track progress, and compete through a real-time leaderboard system.",
      status: "Completed",
      isFeatured: true,
      isPortfolio: false,
      images: [
        'assets/images/project_mockup.png',       // Main Foreground Phone
        'assets/images/project_mockup_back.png',  // Background Phone (UI overlay image)
      ],
      keyFeatures: [
        'Dynamic quiz generation',
        'Firebase authentication',
        'Multiple quiz categories',
        'Real-time leaderboard',
        'Offline support with Hive',
        'Progress tracking',
        'Responsive modern UI',
      ],
      techStack: [
        {'name': 'Flutter', 'color': const Color(0xFF02569B)},
        {'name': 'Dart', 'color': const Color(0xFF0175C2)},
        {'name': 'Firebase', 'color': const Color(0xFFFFCA28)},
        {'name': 'Hive', 'color': const Color(0xFFE57373)},
        {'name': 'REST API', 'color': const Color(0xFFFFB300)},
      ],
      challengesSolved: [
        'Duplicate question filtering',
        'Efficient API handling',
        'Offline caching support',
        'Scalable category architecture',
      ],

      githubUrl: 'https://github.com/rahulkumarsah1999/Complete-QuizApp', // Dynamic GitHub Link
      liveUrl: null,
    ),

    // 3. OTHER PROJECT: LocalMate
    ProjectModel(
      title: "LocalMate",
      subtitle: "Location-Based Community Service App",
      description: "A location-based service application designed to connect users with nearby skilled professionals and local services through an intuitive mobile experience.",
      status: "Experiments & Side Projects",
      isFeatured: false,
      isPortfolio: false,
      images: [
        'assets/images/project_mockup.png',
      ],
      keyFeatures: [
        'Nearby service discovery',
        'Real-time location matching',
        'Google Maps integration',
        'In-app communication',
      ],
      techStack: [
        {'name': 'Flutter', 'color': const Color(0xFF02569B)},
        {'name': 'Firebase', 'color': const Color(0xFFFFCA28)},
        {'name': 'Google Maps', 'color': const Color(0xFF34A853)},
      ],
      challengesSolved: [
        'Geo-location optimization',
        'Real-time Firebase sync',
      ],
      githubUrl: "https://github.com/rahulkumarsah1999/LocalMate",
      liveUrl: null,
    ),

    // 4. OTHER PROJECT: SafeTrack
    ProjectModel(
      title: "SafeTrack",
      subtitle: "Real-Time Safety & Emergency App",
      description: "A personal safety application focused on real-time location sharing, emergency SOS alerts, and safety tracking to help users stay connected during critical situations.",
      status: "Experiments & Side Projects",
      isFeatured: false,
      isPortfolio: false,
      images: [
        'assets/images/project_mockup.png',
      ],
      keyFeatures: [
        'Live location sharing',
        'Emergency SOS system',
        'Background tracking',
        'Offline SMS fallback',
      ],
      techStack: [
        {'name': 'Flutter', 'color': const Color(0xFF02569B)},
        {'name': 'Firebase', 'color': const Color(0xFFFFCA28)},
        {'name': 'Location API', 'color': const Color(0xFF9C27B0)},
      ],
      challengesSolved: [
        'Background tracking stability',
        'Emergency SMS fallback',
      ],
      githubUrl: "https://github.com/rahulkumarsah1999/SafeTrack",
      liveUrl: null,
    ),
  ];
}