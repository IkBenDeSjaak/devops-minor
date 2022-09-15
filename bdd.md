# Behaviour Driven Development

## Process

1. Illustrate (how a user would interact with the application, team talks through conrete examples of how features would work => acceptatiecriteria & business rules)
2. Formulate (turn rules and examples into format that can act as specifications a business person can read and also in a form that can be used for automated acceptance testing => Cucumber)
3. Automate (write test automation code to turn the given when then statements into automated acceptance tests)
4. Validate (show the business concrete evidence their criteria are met)

### Illustrate

Three people are necessary:

- Business
- Development
- QA

When? Before the sprint starts leading up to the sprint planning.
What? Team talks to business to decide what would be most valuable to build next.

## Benefits

- Be agile, don't just 'do' agile
- Bridge the communication gap
- Understanding of what the business actually needs
- Faster feedback
- Less defects

## Gherkin

Feature: Consists of multiple scenarios.

Scenario: Business context or situation. You can group scenarios together to form user stories.

Background: This will be executed at the start of each scenario in feature file.

- State (given, can be multiple)
- Action (when)
- Outcome (then, can be multiple)

### Data tables

![Data tables pre](/images/gherkin-pre-data-table.png)

![Data tables after](/images/gherkin-after-data-table.png)

![Data tables after 2](/images/gherkin-after-data-table-2.png)

### Scenario Outlines

![Scenario outline pre](/images/gherkin-pre-scenario-outline.png)

![Scenario outline after](/images/gherkin-after-scenario-outline.png)

### Glue code

Matching the sentences with the code.

![Glue code](/images/gherkin-glue-code.png)

### Good documentation

- Written as business specifications, not test scripts
- Business language, not technical
- Self explanatory
