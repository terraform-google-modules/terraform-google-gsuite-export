# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keep-a-changelog-site],
and this project adheres to
[Semantic Versioning][semantic-versioning-site].

Extending the adopted spec, each change should have a link to its corresponding pull request appended.

## [2.0.1](https://github.com/terraform-google-modules/terraform-google-gsuite-export/compare/v2.0.0...v2.0.1) (2022-12-30)


### Bug Fixes

* update machine_image to debian-11 ([#38](https://github.com/terraform-google-modules/terraform-google-gsuite-export/issues/38)) ([0336295](https://github.com/terraform-google-modules/terraform-google-gsuite-export/commit/033629556814cfe06185ea501aacfec878471138))

## [2.0.0](https://github.com/terraform-google-modules/terraform-google-gsuite-export/compare/v1.0.0...v2.0.0) (2022-05-09)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#21)

### Features

* add Terraform 0.13 constraint and module attribution ([#21](https://github.com/terraform-google-modules/terraform-google-gsuite-export/issues/21)) ([0a94a2d](https://github.com/terraform-google-modules/terraform-google-gsuite-export/commit/0a94a2ddb4b320bb3530227e2842716ce0d4520c))
* update TPG version constraints to allow 4.0 ([#25](https://github.com/terraform-google-modules/terraform-google-gsuite-export/issues/25)) ([0fda657](https://github.com/terraform-google-modules/terraform-google-gsuite-export/commit/0fda657fb79f300e6782a332a76e6fda6048c652))


### Bug Fixes

* update gsuite-exporter to version 0.0.4 ([527a241](https://github.com/terraform-google-modules/terraform-google-gsuite-export/commit/527a24113c38c771eccaaa5afbd08c54d740fe52))

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
