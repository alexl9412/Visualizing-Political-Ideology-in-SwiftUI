# Visualizing Political Ideology in SwiftUI
Swift code for fetching, decoding, and displaying DW-NOMINATE data in SwiftUI. It includes:
- a generic network manager for fetching and decoding JSON, XML, and CSV data
- a service class and endpoint protocol for constructing URLs and handling multiple API calls
- a data model and SwiftUI chart showing how the ideologies of the major U.S. political parties have changed over time

Discussed in a 3-part blog post series on [beinformed.app/blog](https://beinformed.app/blog):
- Part 1: [Creating a generic network manager in Swift](https://beinformed.app/blog/swift-network-api-calls)
- Part 2: [Managing URL construction for APIs in Swift](https://beinformed.app/blog/url-construction-network-api-swift)
- Part 3: [Building a SwiftUI chart with DW-NOMINATE data](https://beinformed.app/blog/congress-political-ideology-swiftui-chart-ios)

## What is DW-NOMINATE?
DW-NOMINATE (dynamic weighted nominal three-step estimation) is a statistical method used to estimate the ideological positions of legislators based on their roll-call voting records. Developed by Keith T. Poole and Howard Rosenthal in the 1980s, it places each legislator on a two-dimensional ideological scale, with the first dimension representing the traditional liberal-conservative economic spectrum (from -1 for most liberal to 1 for most conservative), and the second dimension capturing differences in social and cultural issues, such as slavery, currency policy, immigration, civil rights, and abortion. Since about 2000, the second dimension has become less significant to the point where “almost every issue is voted along ‘liberal-conservative’ lines.”

DW-NOMINATE scores are designed to be comparable across different Congresses, allowing researchers to show the ideological positions of individual legislators, parties, and the entire Congress have evolved. The method has become a widely used tool in political science research to quantify polarization and study voting patterns in Congress and is often cited by leading news organizations to measure the ideology of major political figures.

DW-NOMINATE data is sourced from ![Voteview](https://voteview.com/) and cited below:
-  Lewis, Jeffrey B., Keith Poole, Howard Rosenthal, Adam Boche, Aaron Rudkin, and Luke Sonnet (2025). Voteview: Congressional Roll-Call Votes Database. https://voteview.com/ 

![DW-NOMINATE chart in SwiftUI](https://github.com/alexl9412/Visualizing-Political-Ideology-in-SwiftUI/blob/101a732cd1103277874cf55f709c1c999c939525/DW-NOMINATE%20SwiftUI%20Chart.png)
