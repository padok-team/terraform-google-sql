# Changelog

## [0.7.0](https://github.com/padok-team/terraform-google-sql/compare/v0.6.0...v0.7.0) (2024-10-21)


### Features

* **upgrade:** pg-v22 ([4625d16](https://github.com/padok-team/terraform-google-sql/commit/4625d16737275a5af2c41479dee166626f3977f9))
* **upgrade:** pg-v22 ([09c34d6](https://github.com/padok-team/terraform-google-sql/commit/09c34d686a8e8c1ff35019e4dcfb5a234da5da81))
* **upgrade:** pg-v22 ([7e5cf17](https://github.com/padok-team/terraform-google-sql/commit/7e5cf171143276a8f093c1376919135117d76bb5))

## [0.6.0](https://github.com/padok-team/terraform-google-sql/compare/v0.5.1...v0.6.0) (2024-07-23)


### Features

* **replica:** add availability type and disk-size parameters ([#63](https://github.com/padok-team/terraform-google-sql/issues/63)) ([b1acda2](https://github.com/padok-team/terraform-google-sql/commit/b1acda204f1555b98a33655bdeac25e0a41067bc))


### Bug Fixes

* **deps:** update module golang.org/x/oauth2 to v0.9.0 ([#46](https://github.com/padok-team/terraform-google-sql/issues/46)) ([8c51f1d](https://github.com/padok-team/terraform-google-sql/commit/8c51f1d2f8c9dc97b1629ebb3900232762bfe8b2))
* **deps:** update module google.golang.org/api to v0.126.0 ([#42](https://github.com/padok-team/terraform-google-sql/issues/42)) ([5216436](https://github.com/padok-team/terraform-google-sql/commit/5216436f11e5c80e7827e9c9c2614aa960def255))
* **deps:** update module google.golang.org/api to v0.128.0 ([#45](https://github.com/padok-team/terraform-google-sql/issues/45)) ([7e82648](https://github.com/padok-team/terraform-google-sql/commit/7e826480168e2d34bfdd6451766d686b49159d16))
* **deps:** update module google.golang.org/api to v0.129.0 ([#47](https://github.com/padok-team/terraform-google-sql/issues/47)) ([c78c202](https://github.com/padok-team/terraform-google-sql/commit/c78c202a41bf7ee32ffc0fb7aba2075701a8844c))
* **deps:** update module google.golang.org/api to v0.134.0 ([#48](https://github.com/padok-team/terraform-google-sql/issues/48)) ([697db22](https://github.com/padok-team/terraform-google-sql/commit/697db22a0b8ff1c72a3e5218304cb2d46e8b6fa3))
* **sql-exporter:** fix runtime version ([10dfe9e](https://github.com/padok-team/terraform-google-sql/commit/10dfe9e206114b357495da332ca94dde7a88a456))

## [0.5.1](https://github.com/padok-team/terraform-google-sql/compare/v0.5.0...v0.5.1) (2023-05-19)


### Bug Fixes

* **deps:** update module golang.org/x/oauth2 to v0.8.0 ([#30](https://github.com/padok-team/terraform-google-sql/issues/30)) ([ded5c51](https://github.com/padok-team/terraform-google-sql/commit/ded5c5139a4528a19de4fb8d1391e5fc6cee9c54))
* **deps:** update module google.golang.org/api to v0.123.0 ([#31](https://github.com/padok-team/terraform-google-sql/issues/31)) ([a4c21a9](https://github.com/padok-team/terraform-google-sql/commit/a4c21a96cfd3739f88e9a153f4f544c4e178acbe))

## [0.5.0](https://github.com/padok-team/terraform-google-sql/compare/v0.4.2...v0.5.0) (2023-05-05)


### Features

* 38 module does not export secret details ([#39](https://github.com/padok-team/terraform-google-sql/issues/39)) ([460fe1e](https://github.com/padok-team/terraform-google-sql/commit/460fe1e40c22c9a30e735e94d0c7ccb9b9d5424f))


### Bug Fixes

* **enablers:** fix lint and security issues ([7af6a0b](https://github.com/padok-team/terraform-google-sql/commit/7af6a0bad02fb270694705e7edfb04848cd6398a))

## [0.4.2](https://github.com/padok-team/terraform-google-sql/compare/v0.4.1...v0.4.2) (2023-03-02)


### Bug Fixes

* **encryption:** missing project_id/project variable in submodule ([#32](https://github.com/padok-team/terraform-google-sql/issues/32)) ([6a2662f](https://github.com/padok-team/terraform-google-sql/commit/6a2662ffde457ac97a8547e08ab5c831a99654e2))

## [0.4.1](https://github.com/padok-team/terraform-google-sql/compare/v0.4.0...v0.4.1) (2023-02-03)


### Bug Fixes

* **deps:** update module golang.org/x/oauth2 to v0.4.0 ([d8d1e6f](https://github.com/padok-team/terraform-google-sql/commit/d8d1e6fd9277f629c063ae6264d29ce55a109fa6))

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
