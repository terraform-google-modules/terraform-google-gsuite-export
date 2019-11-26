# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keep-a-changelog-site],
and this project adheres to
[Semantic Versioning][semantic-versioning-site].

Extending the adopted spec, each change should have a link to its corresponding pull request appended.

## [Unreleased]

## [1.0.0] - 2019-11-26

### Added

- Support for Terraform 0.12. [#5]
- Convert string variable `applications` to a list of strings. [#12]
- Add outputs `instance_name`, `instance_project`, `instance_zone`. [#15]
- Update examples to fit terraform-google-log-export reformat. [#11]

### Removed

- Support for Terraform 0.11. [#15]
- Removed output `instance_id`. [#15]

## [0.1.0] - 2019-03-29

### Added

- This is the initial release.

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/releases/tag/v0.1.0

[#15]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/pull/15
[#12]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/issues/12
[#11]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/issues/11
[#5]: https://github.com/terraform-google-modules/terraform-google-gsuite-export/issues/5

[keep-a-changelog-site]: https://keepachangelog.com/en/1.0.0/
[semantic-versioning-site]: https://semver.org/spec/v2.0.0.html
