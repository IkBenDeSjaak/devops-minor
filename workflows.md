# Workflows

## Continuous integration

Continuous Integration is about making sure our changes are always visible.
Branching is about isolating change.
Running continuous integration on feature branches causes you to test a piece of code that is not the truth.
When you work on the master branch you are very close to the truth.

Continuous Integration:

- Members of a team integrate their work frequently (at least daily)

CI strategies (hide behaviour rather than code):

- Dark launch: We deploy something that people can't see yet. Example: building backend first before creating the UI.
- Branch by abstraction: Improve abstraction into our code. Evolving cleaner interfaces step by step. Then we replace small components with new ones.
- Feature flags: We hide a new incomplete feature behind a software switch (Con: What are you going to test?).

Voordelen Trunk-Based development:

- Better stability
- Higher job satisfaction
- Lower rates of burnout

Implications of CI:

- We need to become comfortable committing partially complete features and also deploying them to production

Long lived branches: Commonly known feature branches you check in after working on a feature for a week.
Short lived branches: You check them in at the end of the day already.

## Flows

### GitHub flow

De Github workflow maakt gebruikt van twee soorten branches: de master branch en feature branches. Als je een feature maakt maak je een nieuwe branch vanuit de master. Zodra een feature af is maak je een pull request die gemerged kan worden in master.

### Git flow

De Git workflow maakt gebruik van 5 soorten branches. De belangrijkste zijn master en develop. De master is the source code en production ready. Develop bevat de laatste development changes. Daarnaast zijn er feature branches die worden gemaakt vanaf de develop branch. Ook zijn er release branches die vanaf develop gemaakt worden zodra develop klaar lijkt voor een nieuwe release. In tussentijd tot daadwerkelijke release worden fixes naar deze branch gezet. Bij daadwerkelijke release wordt de branch in master en develop gemerged. Ook zijn er hotfix branches die vanaf master komen die alleen gemaakt worden voor belangrijke snelle fixes. Deze worden gemerged into master en develop.
