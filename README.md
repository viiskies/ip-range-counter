# IP range counter

Implementation of a function that receives two IP addresses and returns the number of addresses between them (including the first one, excluding the last one).

## Prerequisites

**Lua 5.3** is required to run program:

```bash
sudo apt install lua5.3
```

## Usage

- Use valid IPv4 or IPv6 addresses.
- Supported address format examples:
  - `1.55.103.104`
  - `01.055.103.104`
  - `2001:db8:3333:0:5555:6666:7777:8888`
  - `2001:db8:3333:4444:CCCC:DDDD:EEEE:FFFF`
  - `::`
  - `2001:db8::`
  - `::1234:5678`
  - `2001:db8::1234:5678`
  - `2001:0db8:1:00:0:0ab9:C0A8:0102`
  - `2001:db8:3333:4444:5555:6666:1.2.3.4`
  - `::11.22.33.44`
  - `2001:db8::1234:5678:5.6.7`
- Main program file is **main.lua**.
- **helpers.lua** and **program.lua** must be in the same folder as **main.lua**.
- Application receives two ip addresses separated by space character.
- Second IP must be greater than first one.
- Program prints to the console number of IP addresses between second and first IP.
- File **tests.lua** is created for development purposes and is not required.

### Examples

```bash
lua main.lua 10.0.0.0 10.0.0.50
50
```

```bash
lua main.lua 2001:0db8:0000:0000:0000:8a2e:0370:7334 2001:0db8:0000:0000:0000:8a2e:0370:7555
545
```

```bash
lua main.lua ::1 ::2:5
131076
```
