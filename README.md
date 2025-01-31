# git-config-action

Configure the bot account in Git.

<!-- actdocs start -->

## Description

This action configures the following bot account in the Git configuration file:

- **user.name**: `github-actions[bot]`
- **user.email**: `41898282+github-actions[bot]@users.noreply.github.com`

This configuration is useful for workflows that include code commits or pushes.
However, if the config has already been set, it will be skipped.

## Usage

```yaml
  steps:
    - name: Git Config
      uses: tmknom/git-config-action@v0
```

## Inputs

N/A

## Outputs

N/A

<!-- actdocs end -->

## Permissions

N/A

## FAQ

N/A

## Related projects

- [git-push-action](https://github.com/tmknom/git-push-action): Commit all modified files and push to the repository.

## Release notes

See [GitHub Releases][releases].

[releases]: https://github.com/tmknom/git-config-action/releases
