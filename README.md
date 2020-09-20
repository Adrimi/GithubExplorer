## Github Explorer

This is a sample project of a Github Explorer.

1. For your convenience, there is already generated GithubExplorer.xcodeproj file. You could skip to point 5. But if you want to generate it by yourself, go to step 2.
2. You should have the xcodegen framework to create project (https://github.com/yonaskolb/XcodeGen#installing, easiest way to install is by brew install xcodegen )
3. Use git clone to download repository on your disk
4. Open directory of the repo
5. Launch terminal (if not have done yet) and type in "sh Scripts/generateProject.sh"
6. Done! Now you need to open Project Navigator -> GithubExplorer -> Tab: Signing & Capabilities -> Targets: "GithubExplorer"
7. There you need to provide a team by yourself to run the app
8. To run unit tests you need to specify the team also in Targets: "GithubExplorerTests"
