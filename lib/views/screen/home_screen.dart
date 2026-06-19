import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/providers/navbar/navbar_provider.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/sections/about_section.dart';
import 'package:portfolio/views/sections/contact_section.dart';
import 'package:portfolio/views/sections/on_the_table_section.dart';
import 'package:portfolio/views/sections/projects_section.dart';
import 'package:portfolio/views/sections/tech_stack_section.dart';
import 'package:portfolio/views/widgets/contact/right_panel.dart';
import 'package:portfolio/views/widgets/navbar/desktop_navbar.dart';
import 'package:portfolio/views/sections/hero_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  late final AnimationController _entranceController;

  // Staggered Layer Interpolators
  late final Animation<double> _navbarFade;
  late final Animation<Offset> _navbarSlide;

  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;

  Future<void> scrollToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    final renderObject = context.findRenderObject();
    if (renderObject == null) return;

    final viewport = RenderAbstractViewport.of(renderObject);
    final targetOffset = viewport.getOffsetToReveal(renderObject, 0.0).offset;

    await _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 850),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Layer 1: Navbar entrance sequence
    _navbarFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
    );
    _navbarSlide = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.50, curve: Curves.easeOutCubic),
    ));

    // Layer 2: Main Body delayed staggered transition layers
    _contentFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.20, 0.85, curve: Curves.linear),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.04), // Soft physics elevation entry
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.15, 0.90, curve: Curves.fastLinearToSlowEaseIn),
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });

    _scrollController.addListener(_handleScrollMonitoring);
  }

  void _handleScrollMonitoring() {
    final homeContext = _homeKey.currentContext;
    final aboutContext = _aboutKey.currentContext;
    final projectsContext = _projectsKey.currentContext;
    final contactContext = _contactKey.currentContext;

    final shouldShow = _scrollController.offset > 200;
    if (shouldShow != _showTitle) {
      setState(() {
        _showTitle = shouldShow;
      });
    }

    if (homeContext == null || aboutContext == null || projectsContext == null || contactContext == null) return;

    final homePosition = (homeContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero).dy;
    final aboutPosition = (aboutContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero).dy;
    final projectsPosition = (projectsContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero).dy;
    final contactPosition = (contactContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero).dy;

    final navbarNotifier = ref.read(navbarProvider.notifier);
    if (homePosition <= 0 && aboutPosition > 120) {
      navbarNotifier.changeNavItem('home');
    } else if (aboutPosition <= 120 && projectsPosition > 120) {
      navbarNotifier.changeNavItem('about');
    } else if (projectsPosition <= 120 && contactPosition > 120) {
      navbarNotifier.changeNavItem('projects');
    } else if (contactPosition <= 120) {
      navbarNotifier.changeNavItem('contact');
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(context),
      body: SafeArea(
        child: Stack(
          children: [
            // BODY CONTAINER LAYER (Staggered Entrance Animation)
            FadeTransition(
              opacity: _contentFade,
              child: SlideTransition(
                position: _contentSlide,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      Container(
                        key: _homeKey,
                        child: HeroSection(
                          width: width,
                          isMobile: isMobile,
                          onContactTap: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Contact',
                              barrierColor: Colors.black.withValues(alpha: 0.6), // Web Engine optimization safe fix
                              transitionDuration: const Duration(milliseconds: 350), // Elegant modal snap response
                              pageBuilder: (_, _, _) {
                                return SafeArea(
                                  child: Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 620,
                                            maxHeight: MediaQuery.of(context).size.height * 0.88,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.cardBackground(context),
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.15),
                                                blurRadius: 40,
                                                spreadRadius: -4,
                                                offset: const Offset(0, 24),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              SingleChildScrollView(
                                                padding: const EdgeInsets.fromLTRB(24, 42, 24, 24),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Material(
                                                          color: Colors.transparent,
                                                          child: InkWell(
                                                            borderRadius: BorderRadius.circular(14),
                                                            onTap: () => Navigator.pop(context),
                                                            child: Container(
                                                              padding: const EdgeInsets.all(10),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.cardBackground(context),
                                                                borderRadius: BorderRadius.circular(14),
                                                                border: Border.all(
                                                                  color: Theme.of(context).dividerColor.withValues(alpha: 0.08),
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons.arrow_back_rounded,
                                                                size: 20,
                                                                color: AppColors.primaryText(context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "Let’s Build ",
                                                                      style: TextStyle(color: AppColors.primaryText(context)),
                                                                    ),
                                                                    TextSpan(
                                                                      text: "Something Together ✨",
                                                                      style: TextStyle(color: AppColors.secondary),
                                                                    ),
                                                                  ],
                                                                ),
                                                                style: const TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight: FontWeight.w700,
                                                                  height: 1.2,
                                                                  letterSpacing: -0.5,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 8),
                                                              Text(
                                                                "Have an idea, internship, collaboration, or cool project in mind?\nI’m always excited to connect and build meaningful things. 🚀",
                                                                style: TextStyle(
                                                                  fontSize: 13,
                                                                  height: 1.6,
                                                                  color: AppColors.secondaryText(context),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 14),
                                                              Container(
                                                                height: 4,
                                                                width: 60,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                    colors: [AppColors.secondary, Colors.cyanAccent],
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 28),
                                                    RightPanel(isDialog: true),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              // 💎 PREMIUM MODAL TRANSITION: Cubic Scaling Curve Matrix
                              transitionBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
                                  child: ScaleTransition(
                                    scale: Tween<double>(begin: 0.94, end: 1.0).animate(
                                      CurvedAnimation(parent: animation, curve: Curves.elasticOut), // Senior fluid bounce effect
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      AboutSection(key: _aboutKey),
                      TechStackSection(),
                      OnTheTableSection(),
                      ProjectsSection(key: _projectsKey),
                      ContactSection(key: _contactKey),

                      // Premium Structural Footer Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldBackground(context),
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).dividerColor.withValues(alpha: 0.04),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "© 2026 Rahul Kumar Sah. All rights reserved.",
                            style: TextStyle(
                              color: AppColors.secondaryText(context).withValues(alpha: 0.5),
                              fontSize: isMobile ? 12.0 : 13.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // NAVBAR CONTAINER LAYER (Top Overlay Staggered Segments Entry)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _navbarFade,
                child: SlideTransition(
                  position: _navbarSlide,
                  child: DesktopNavbar(
                    name: 'rahulkumarsah',
                    tailname: 'com',
                    onHomeTap: () => scrollToSection(_homeKey),
                    onAboutTap: () => scrollToSection(_aboutKey),
                    onProjectsTap: () => scrollToSection(_projectsKey),
                    onContactTap: () => scrollToSection(_contactKey),
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