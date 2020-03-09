# Intuit Craft Demo

I'll keep this short and sweet. Since Intuit has kindly sped up standard processes in my case, I've done my best in turn to expose my step-by-step process. I've put (hopefully not too) copious notes inline in the code to call out my thinking along the way. Additionally, here's an overview of my top-to-bottom process in creating the demo project: 

1. Review spec and determine needed endpoints:

2. Create project (choosing iPhone-only, no `SplitViewController` for time’s sake), adding repo and Unit/UI Test targets). Clear boilerplate code and organize base assets.

3. Review `JSON`, identifying issue with keyless properties, resolving these with unkeyed containers. 

4. Create `Codable` structs in Playground and add to project. Add Date+ with extension for relative date string needed for Issues view. 

5. Find GitHub colors for each language (in hex) in GitHub repo([https://github.com/IonicaBizau/github-colors/blob/HEAD/colors.md)](https://github.com/IonicaBizau/github-colors/blob/HEAD/colors.md). For demo purposes, get a distinct set of languages now used in Intuit repos and match to their corresponding hex colors. Since we also need to directly consume hex colors for Issue labels, I extended `UIColor` to enable instantiation from any valid hex value, and also added a static `githubDefaltColor` to consistently handle any unexpected cases. Finally, I made the hex colors of both Issue Labels and Repositories private, in both cases exposing a UIColor to the public API instead.
6. Pause to clean up the last few steps so that the models are self-consistent and self-documenting.
7. Set up `RepositoriesService.swift`. I hadn’t realized that the endpoint’s `language` property could be `null`, so I had to track that down, then update the Repository model to gracefully account for that.
8. Set up `MainTableViewController` and `MainTableViewCell`. I didn’t get a chance to ask if it’d be ok to do this entirely in code, so I used a conventional UIKit storyboard approach, executing Auto Layout directly in IB rather than code. For demo purposes, I left cell statically sized, so I vertically centered content and allowed repo descriptions to take up to 3 lines. I used attributed text for the topmost repo name with mixed content.  Additionally, I wanted an easy way to both separate concerns for enable proof of concept tests against mocks, so I set up a simple public `setRepositories(_ :reloadingTableView)` method to provide a clean way to insert test data as needed.
9. Stub out IssuesTableViewController and IssuesTableViewCell, connecting to `MainTableViewCell` via a simple Modal segue. Add `prepare(for: sender:)` with simple demo-appropriate stringly typed checks and pass needed `repoName` property to destination VC.
10. Set up IssueService. Initially, I thought to set up a simple cache, but realized that was beyond demo scope (notes in place in code). I hit a few issues with an incorrect endpoint (my error) and some additional unexpected nullable JSON properties (milestone creator and createdAt can surprisingly both be null!) and had to drop into a quick Playground to find and update the `Decodable` model structs.
11. Set up Issue cell in IB and connect outlets to `IssuesTableViewCell.swift`.  I waffled here between doing this all (or at least the Horizontal Stack View and dynamic labels) programmatically, but stayed with doing everything in IB as much as possible for consistency throughout the demo. 
12. Resolve misc.h issues: Switch from table header to navigation controller title for MainTableViewController for more platform-appropriate title.  Increase modally presented IssuesTableView header height to better match main.  Detect several repos not displaying issues, manually test JSON and confirm that this is correct. Improve presentation of “Open by… when” presentation when this info isn’t present in GitHub JSON. 
13. Embed `IssuesTableViewController` in `TabBarController` and update  `prepare(for: sender:)` to match. 
14. Duplicate `IssuesTableViewController` programmatically and add to TabBarController with appropriate icon. Add state property to VC and add state filtering based on passed value. (Note: I’m not seeing any closed issues coming through the GitHub API).  Add closed state gray colors for `.closed` state. 
15. Add labels to Horizontal Stack View programmatically, with background color, rounded corners.
16. Set main table view cells to dynamic height, updating constraints. Note issues in both simulator and on device with issue cell horizontal stack view. Force clear preexisting stack view contents partially resolves, but rendering issues persist when cells are redrawn.
17. Resolve the rendering issues by replacing UIStackView with static UILabel template objects, adjusting code to match. This likely wouldn't be a production-worthy solution, but fully resolves the issues experienced for present purposes.
18. I missed the GitHub "desktop" affordance in the Issues table initially, so I had to quickly backtrack, find the JSON property for the link, add this to the Codable model and add a matching property in the Issues VC.
19. Set up second prototype cell for the GitHub link. Create GitHub octicon assets, wire up IBAction for button, add autolayout constraints and test.
20. Set up simple proof of concept unit tests. I've run out of time, so these are simple… Making final commit.