# Documentation as code

*Markdown is just another language*

The documentation as code practice is based on this simple idea, because it is just another language we can apply all the DevOps principles.

## DevOps principles

### The First Way: Principles of Flow

- **Everything is code**: Nowaday, we use API almost everywhere which implies we can easily remove manual operations, thus improve the lead time by automate everything which can be automated
- **High-Trust Culture**: This is both a practice and an outcome result from a single source of truth, peer reviews, and shared goals
- **Cross functional team**: Gather multiple role inside a single team allows more reactivity and efficiency. Companies are moving to cloud, thus DevOps teams must be composed of skills from Cloud architect to Operations, going through Developer, Security officer, Network architect, ... . Moreover it also permits to share competences and develop people.
- **Make work visible**: Make work visible enables feedbacks which improve product quality. It also permits to measure the move and trace the changes.

!!! info "Definition"
    Lead time: total time elapsed from the creation of work items to their completion
    Cycle time: time it takes for your team to complete work items once they begin actively working on them

### The Second Way: Principles of Feedback

- **Fail fast**: Test as soon as you can. You can test hypothesis such as new feature or you can test code. In matter of code we talk about move left to move tests as close as possible to developers.

- **Everything is monitored**: Monitor you CI/CD to get a feedback about your changes as soon as possible. Monitor your infrastructure to be able to identify any issue.

- **Everything is observable**: The observability pattern enables the proactivity. Take the example of a disk, either you can monitor the disk logs and wait for an out of space error, or you can observe its size growing to be able to predict when it will be full and increase the capacity before an error occur.

### The Third Way: Principles of Continuous Learning

- **Safety culture**: Don't blame teammate because they fail, either in trying something new or because they broke the production environment. Each experience must allow the team to grow up in order to improve the product quality. It is important to create a confident climate fostering innovation, people are always more innovative and productive in a trust environment.
- **Culture of continuous improvement**: Take time empty your technical debt, your product and your teammate will thank you.
- **Learning culture**: Take time to learn and share what you have learnt, everybody will grow-up, even you.

!!! info "Reference"
    [DevOps the three ways](https://blog.sonatype.com/principle-based-devops-frameworks-three-ways){target=_blank}
    [DevOps practices](https://www.perforce.com/blog/vcs/7-devops-practices-outstanding-results){target=_blank}

## Why documentation as code

### Scale

Make your documentation inner / open sourced will allow the users to improve it by them selves, which will drastically improve the documentation quality and completeness.

This is possible only because the documentation source code is available on a Source Control Management system.

### Review

Once of the interesting SCM feature is the ability to submit a change request (PullRequest, MergeRequest, ...), this change will then be automatically tested with a pipeline which can as example check the broken web link. Once the pipeline succeed, a documentation owner can reviewed the request and accept or reject it.

### Control

Your documentation web site can be shared between teams, if you don't want all teams to be able to approve changes against the full website, you can limit their permission with the [code owner mechanism](https://docs.gitlab.com/ee/user/project/code_owners.html){target=_blank} to approve changes only on some subpart of the web site.

### Monitor

As any web site you can monitor the usage in order identify the most useful page as well as the one to rework in order to  make it more attractive. You can also measure the contribution rate thanks to the underlying source control management system.

## Tools

> In this section I will list the tools I used to use as part of the documentation as code pipeline. This list is non exhaustive and probably not complete as it does not cover all the area.

### Editor

- [Code Space](https://github.com/features/codespaces){target=_blank}
- [VSCode](https://code.visualstudio.com/){target=_blank}
- [VSCode - Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one){target=_blank}
- [VSCode - Drawio](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio){target=_blank}

### Tests

- Code quality: [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint){target=_blank}
- Spell Check: [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker){target=_blank}
- Link Check: [Link Checker](https://marketplace.visualstudio.com/items?itemName=wilhelmer.link-checker-2){target=_blank}
- Grammar, style Check: [Vale](https://marketplace.visualstudio.com/items?itemName=errata-ai.vale-serve){target=_blank}

!!! info
    All the VSCode extension above have a CLI which help to integrate those tools in a pipeline

### Static website generator

- [MkDocs](https://www.mkdocs.org/){target=_blank}
- [MkDocs template site](https://github.com/documentation-as-code/doc-as-code-template){target=_blank}

### Source Code Management

- [GitHub](https://github.com){target=_blank}
- [GitLab](https://gitlab.com){target=_blank}

### Pipeline orchestrator

- [Jenkins](https://www.jenkins.io/){target=_blank}
- [GitHub Actions](https://github.com/features/actions){target=_blank}
- [GitLab CI](https://docs.gitlab.com/ee/ci/){target=_blank}

!!! info "Reference"
    - [CI and CD for documentation](https://documentation-as-code.github.io/ci-cd-for-documentation/){target=_blank}
    - [Conference replay](../../Conferences/index.md)