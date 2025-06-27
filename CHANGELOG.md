# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Complete Phase 1-5 test suite and improve VM core implementation** (2025-06-26 – jarroddavis68)
  - Expand test coverage from 97 to 257 tests across 5 complete phases
  - Fix constants pool management with proper count tracking
  - Convert static arrays to dynamic TArray<T> for better memory management
  - Add comprehensive Stack, Constants, and Bytecode test fixtures
  - Improve native function callback system with reference to procedure
  - Fix access violations in constants initialization
  - Update documentation to reflect 100% completion of core test phases
  - Add new bytecode access methods (GetBytecode, GetConstants, GetBytecodeSize)

- **Create FUNDING.yml** (2025-06-26 – Jarrod Davis)


### Changed
- **Merge branch 'main' of https://github.com/tinyBigGAMES/JetVM** (2025-06-26 – jarroddavis68)

- **Update README.md** (2025-06-26 – jarroddavis68)

- **Repo Update** (2025-06-26 – jarroddavis68)
  - Initial commit

- **Initial commit** (2025-06-26 – Jarrod Davis)


### Removed
- **Remove unneeded units from  JetVMTests project** (2025-06-26 – jarroddavis68)

