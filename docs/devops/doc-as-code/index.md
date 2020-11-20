# Documentation as code

*Markdown is just another language*

The documentation as code practice is based on this simple idea, because it is just another language we can apply all the DevOps principles.

## DevOps principles

### The First Way: Principles of Flow

- Everything is code
- Establish "trust"
- Cross functional team
- Make work visible

### The Second Way: Principles of Feedback

- Fail fast => Move tests to left
- Everything is monitored
- Everything is observable

### The Third Way: Principles of Continuous Learning

- Safety culture => Allow mistake, Blameless post mortem
- Culture of continuous improvement => Share learning and improvements
- Learning culture

!!! info "Reference"
    [DevOps the three ways](https://blog.sonatype.com/principle-based-devops-frameworks-three-ways)

## Benefits

### Scale

Make your documentation inner / open sourced will allow the users to improve it by them selves, which will drastically improve the documentation quality and completeness.

This is possible only because the documentation source code is available on a Source Control Management system.

### Review

Once of the interesting SCM feature is the ability to submit a change request (PullRequest, MergeRequest, ...), this change will then be automatically tested with a pipeline which can as example check the broken web link. Once the pipeline succeed, a documentation owner can reviewed the request and accept or reject it.

### Control

Your documentation web site can be shared between teams, if you don't want all teams to be able to approve changes against the full website, you can limit their permission with the [code owner mechanism](https://docs.gitlab.com/ee/user/project/code_owners.html) to approve changes only on some subpart of the web site.

### Monitor

As any web site you can monitor the usage in order identify the most useful page as well as the one to rework in order to  make it more attractive. You can also measure the contribution rate thanks to the underlying source control management system.

## Tools

> In this section I will list the tools I used to use as part of the documentation as code pipeline. This list is non exhaustive and probably not complete as it does not cover all the are.

### Editor

- [Code Space](https://github.com/features/codespaces)
- [VSCode](https://code.visualstudio.com/)
- [VSCode - Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
- [VSCode - Drawio](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)

### Tests

- Code quality: [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- Spell Check: [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- Link Check: [Link Checker](https://marketplace.visualstudio.com/items?itemName=wilhelmer.link-checker-2)
- Grammar, style Check: [Vale](https://marketplace.visualstudio.com/items?itemName=errata-ai.vale-serve)

!!! info
    All the VSCode extension above have a CLI which help to integrate those tools in a pipeline

### Static website generator

- [MkDocs](https://www.mkdocs.org/)
- [MkDocs template site](https://github.com/documentation-as-code/doc-as-code-template)

### Source Code Management

- [GitHub](https://github.com)
- [GitLab](https://gitlab.com)

### Pipeline orchestrator

- [Jenkins](https://www.jenkins.io/)
- [GitHub Actions](https://github.com/features/actions)
- [GitLab CI](https://docs.gitlab.com/ee/ci/)

!!! info "Reference"
    - [CI and CD for documentation](https://documentation-as-code.github.io/ci-cd-for-documentation/
    - [Conference replay](../../Conferences/index.md)