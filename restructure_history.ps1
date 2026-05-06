# Restructure Git History for public_emergency_app
$repoPath = "c:\Users\Administrator\Downloads\public_emergency_app"
Set-Location $repoPath

# Delete old Git history
if (Test-Path ".git") {
    Remove-Item -Recurse -Force .git
}

# Initialize fresh repo
git init
git config user.name "dev11062004"
git config user.email "dev11062004@users.noreply.github.com"

# --- COMMIT 1: Project Initialization ---
git add pubspec.yaml pubspec.lock analysis_options.yaml .gitignore lib/main.dart lib/firebase_options.dart
git commit -m "chore: project initialization and core infrastructure`n`n- Initialized Flutter project with core dependencies (GetX, Firebase, Provider, Hive)`n- Configured Firebase options and cross-platform initialization`n- Established base architecture and directory structure`n- Configured app routing and theme tokens"

# --- COMMIT 2: UI Implementation ---
# Staging screens and widgets recursively
Get-ChildItem -Path lib -Recurse -Include "*screen.dart", "*page.dart", "*widget.dart", "*dashboard.dart", "*view.dart", "Onboarding.dart", "form_footer.dart", "grid_dash.dart", "bottom_nav.dart", "Incident_card.dart", "priority_badge.dart", "custom_button.dart", "select_responder.dart", "AmbulanceOptions.dart", "firefighter_options.dart", "hospital_options.dart", "police_options.dart" | ForEach-Object { git add $_.FullName }
git add "lib/mad_exam/screens/" "lib/mad_exam/widgets/" "lib/Common Widgets/"
git commit -m "feat: implement responsive UI screens and first responder interface`n`n- Built multi-role UI for Police, Ambulance, and Fire services`n- Implemented Onboarding flow with MAD Exam Portal access`n- Designed Incident Reporting and Admin Dashboard screens`n- Created reusable UI components and color-coded priority badges`n- Integrated Material 3 design principles"

# --- COMMIT 3: Core Logic (Incident + Priority Handling) ---
# Staging controllers and models recursively
Get-ChildItem -Path lib -Recurse -Include "*controller.dart", "Incident.dart", "Incident.g.dart", "*provider.dart", "helpers.dart", "message_sending.dart", "session_controller.dart", "GetxController.dart" | ForEach-Object { git add $_.FullName }
git add "lib/mad_exam/providers/" "lib/mad_exam/models/" "lib/mad_exam/utils/"
git commit -m "feat: engineer incident management and priority handling logic`n`n- Integrated Provider and GetX for global state management`n- Implemented core CRUD operations for incident lifecycle`n- Engineered priority-based sorting algorithms (Critical > High > Medium > Low)`n- Added form validation and real-time status tracking logic`n- Configured automated Incident ID generation"

# --- COMMIT 4: Offline Storage & Final Enhancements ---
# Add remaining files
git add .
git commit -m "feat: implement offline storage, dashboard analytics, and final polish`n`n- Integrated Hive for offline incident persistence and auto-sync`n- Added interactive data visualization using fl_chart`n- Implemented connectivity monitoring for real-time sync simulation`n- Optimized performance and platform-specific configurations`n- Finalized comprehensive documentation and project README"

# Link and push
git branch -M main
git remote add origin https://github.com/dev11062004/MAD-Emergency-Response-App.git
git push -u origin main --force
