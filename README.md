# Screenbright

Simple tool to control screen brightness

## Install

1. Generate the deb package using the **GNU make**
```sh
$ make package-deb
```
2. Use the deb package to install the tool
```sh
# dpkg -i screenbright-YYYY.mm.n.deb
```

## Usage

Increment bright
```sh
screenbright inc
```

Decrement bright
```sh
screenbright dec
```

Turn it all on
```sh
screenbright clear
```

See the man page for more details.
```sh
$ man screenbright
```
