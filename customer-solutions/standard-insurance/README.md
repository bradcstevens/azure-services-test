# Golden Image Pipeline 
## DevOps in Azure - Standard Insurance 

Progressing from Standard Insurance’s (SIC) current way of thinking into the future, a core concept worth embracing is understanding the difference between "pets" and "cattle". Currently, systems at SIC are treated as "pets" - they are cared for and coddled as members of the family.  Going forward, SIC needs to adopt a strategy of replacing servers at will, which is where the analogy of treating them as "cattle" originates. There are many stages in this progression with the final state typically incorporating immutable infrastructure. The first step is to stop relying on long-lived instances. Organizations widespread are beginning to adopt a practice of replacing servers every 30 days, which forces them to rely on automation to keep things in sync in a timely fashion. This is a big shift and needs to be approached in stages.

## Key Components

|   |   | Tool(s) | Description |
| - | - | ------- | ----------- |
| Continuous Integration  | Version Control               | Github                       | Workflow and source of truth | 
|                         | Build/Package Code Artificats | Mavin/Gradle, make, ant, pip | Over time, will include more tools for test/validation/static analysis and InfoSec oversight |

