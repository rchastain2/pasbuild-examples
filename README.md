# PasBuild examples

Reference: [PasBuild Quick Start Guide](https://github.com/graemeg/PasBuild/blob/master/docs/quick-start-guide.adoc)

## Create project

```bash
mkdir example1
cd example1
pasbuild init
```

## Build

```bash
pasbuild compile
./target/example1
## Build using a profile:
pasbuild compile -p debug
```

## Package

```bash
pasbuild package
pasbuild source-package
```
