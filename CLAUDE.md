## Release Management

### Creating New Releases

This project follows [Semantic Versioning (SemVer)](https://semver.org/):
- **MAJOR** (X.0.0) - Breaking changes that require user action
- **MINOR** (0.X.0) - New features that are backward compatible
- **PATCH** (0.0.X) - Bug fixes and improvements that are backward compatible

This project maintains detailed release notes for each version. Follow these steps to create a new release:

#### 1. Analyze Changes and Determine Version
First, identify the version range and examine the changes to determine the appropriate version number:

```bash
# Get the latest tag
git tag | sort -V | tail -1

# View commits since last release
git log <last-tag>..HEAD --oneline --no-merges

# Generate detailed diff statistics
git diff <last-tag>..HEAD --stat

# Analyze specific changes for breaking changes
git diff <last-tag>..HEAD -- src/ --name-status
```

**Automatic Version Determination:**
Analyze the changes and automatically determine the version bump according to Semantic Versioning:

- **PATCH (0.0.X)** - If changes only include:
  - Bug fixes without API changes
  - Internal code improvements
  - Documentation updates
  - Test improvements
  - Development tool updates

- **MINOR (0.X.0)** - If changes include:
  - New public methods or classes
  - New features that maintain backward compatibility
  - New optional parameters with defaults
  - Deprecation warnings (but not removals)

- **MAJOR (X.0.0)** - If changes include:
  - Removed or renamed public methods/classes
  - Changed method signatures (parameters, return types)
  - Changed class constructors
  - Removed or changed public properties
  - Changed behavior of existing methods
  - Minimum PHP version requirements changes
  - Required dependency major version updates

**When to ask for confirmation:**
- If interface changes are detected but it's unclear if they break compatibility
- If new required parameters are added to existing methods
- If enum values are changed or removed
- If constructor signatures change
- If unclear whether a change constitutes a breaking change

**Example analysis:**
```bash
# Check for interface/class signature changes
git diff <last-tag>..HEAD -- src/ | grep -E "^\+.*public function|^\-.*public function"

# Check for removed files
git diff <last-tag>..HEAD --name-status | grep "^D"

# Check composer.json for dependency changes
git diff <last-tag>..HEAD -- composer.json
```

#### 2. Create Release Notes
Create a new file `docs/RELEASE-X.X.X.md` following the established format:

**Structure to follow:**
- Start directly with `## ✨ New Features` (no H1 title)
- Use sections: `## ✨ New Features`, `## 🛠️ Improvements`, `## 🔧 Breaking Changes`, `## 📦 Dependencies`, `## 🛡️ Security`
- Include `## Full Changelog` with GitHub compare URL

**Reference existing files:**
- Follow the emoji conventions and section structure

#### 3. Commit Release Notes
```bash
git add docs/RELEASE-X.X.X.md
git commit -m "Add release notes for vX.X.X"
git push
```

#### 4. Create GitHub Release
Use GitHub CLI to create the release with the markdown content:
```bash
gh release create vX.X.X --notes-file docs/RELEASE-X.X.X.md --title "KurrentDB PHP Client X.X.X"
```

**Important:** The release notes markdown should NOT include an H1 title to avoid duplication in GitHub releases.
