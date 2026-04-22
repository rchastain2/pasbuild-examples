# PasBuild examples

Reference: [PasBuild Quick Start Guide](https://github.com/graemeg/PasBuild/blob/master/docs/quick-start-guide.adoc)

## Init

```bash
mkdir example1
cd example1
pasbuild init
```

## Compile

```bash
pasbuild compile
## Build using a profile
pasbuild compile -p debug
## Run compiled program
./target/example1
```

## Package

```bash
pasbuild package
pasbuild source-package
```
