# CHANGELOG

TBD


## Usage

```shell
$ lua changelog -h

Usage: changelog <command> [options]

Commands:
  add <filename> [options]           add a changelog file.
  release <version> [options]        release a release note based on the files in the CHANGELOG/unreleased directory.
  preview <version> [options]        preview a release note based on the files in the CHANGELOG/unreleased directory.

Options:
  -h, --help                         display help for command
  -m, --message (optional string)    changelog message
  -t, --type (optional string)       changelog type
  --pr (optional string)             changelog pr
  --folder (string default kong)     which folder under unreleased

Examples:
  changelog preview 1.0.0
  changelog release 1.0.0
  changelog add 1.yaml
```

**Add a changelog file**
```shell
./changelog add 1001.yaml -m 'add a feature' -t feature --pr 1001 --folder kong
```

**Preview a release note**
```shell
./changelog preview 1.0.0
```

**Release a release note**
```shell
./changelog release 1.0.0
```

### Tasks:

- [ ] Add a GitHub workflow to automatically add the changelog file when PR created
