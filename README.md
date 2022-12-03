# git-config-action

GitHub Action to set the bot account in Git

<!-- actdocs start -->

## Description

Set the bot account to the Git configuration file. This action sets the following:

- **user.name**：`github-actions[bot]`
- **user.email**：`41898282+github-actions[bot]@users.noreply.github.com`

This configuration is useful for workflows that code commits or push tags.

## Usage

```yaml
  steps:
    - name: Git config
      uses: tmknom/git-config-action@v0
```

## Inputs

N/A

## Outputs

N/A

<!-- actdocs end -->

## Permissions

N/A

## Environment variables

N/A

## FAQ

N/A

## Changelog

- [CHANGELOG.md](/CHANGELOG.md)

## License

Apache 2 Licensed. See LICENSE for full details.
