# Changelog

## [0.4.0](https://github.com/padok-team/terraform-google-sql/compare/v0.3.0...v0.4.0) (2022-11-18)


### Features

* **encryption:** encrypt db disks with kms key ([30500f9](https://github.com/padok-team/terraform-google-sql/commit/30500f9c9175c1a82f3ad975f5c2ac8ff0772948))

## [0.3.0](https://github.com/padok-team/terraform-google-sql/compare/v0.2.0...v0.3.0) (2022-11-04)


### Features

* add sql exporter ([#14](https://github.com/padok-team/terraform-google-sql/issues/14)) ([feb96c3](https://github.com/padok-team/terraform-google-sql/commit/feb96c380cd420c59c8b2a35c301b66802a580a3))

## [0.2.0](https://github.com/padok-team/terraform-google-sql/compare/v0.1.0...v0.2.0) (2022-10-07)


### Features

* **availability:** make availability_type explicit via a variable ([328d423](https://github.com/padok-team/terraform-google-sql/commit/328d423b1c16268df1369ac6939b0143990c5070))


### Bug Fixes

* **data:** add project_id for google_compute_zone data ([e6cfda0](https://github.com/padok-team/terraform-google-sql/commit/e6cfda0efe47a48cdbc40e88c7c61183af376912))
* **examples:** set public to false by default ([7dc21b7](https://github.com/padok-team/terraform-google-sql/commit/7dc21b737c7fab7a6e7ba868f8a21fcb5fa7dcee))
* **naming:** add random suffix to instance name ([f1dd95c](https://github.com/padok-team/terraform-google-sql/commit/f1dd95c0467369f676ba0f198cb4bdcf71df29e3))
* **naming:** remove additional_ prefix from users and dbs ([b6d3600](https://github.com/padok-team/terraform-google-sql/commit/b6d360047b5b9f41b72f2530f3e5dc289625301d))
* **network:** upgrade module version in examples ([fb1d767](https://github.com/padok-team/terraform-google-sql/commit/fb1d767e317238811cb617da9c2b421f1ba60b32))

## 0.1.0 (2022-09-09)


### Features

* **init:** initialize modules ([3574ed0](https://github.com/padok-team/terraform-google-sql/commit/3574ed04820ccd8ac2403708330378ffedccc0e6))
* **sql:** add sql and postgres submodules ([35b95ab](https://github.com/padok-team/terraform-google-sql/commit/35b95abf7248d9f44c1b4bf3564790692b0bfd1d))
