# SAIF Activity Lab

Internal productivity environment for the SAIF ecosystem.

## Installation

You can install the **SAIF** command line tool on macOS or Linux with a single command:

```bash
curl -fsSL https://ridloabelian.github.io/install.sh | bash
```

The installer will detect your operating system and download the appropriate pre‑built binary (`saif-mac` for macOS, `saif-linux` for Linux x86_64) and place it in a directory that is typically on your `$PATH` (e.g., `/usr/local/bin`).

## Usage

After installation, simply run:

```bash
saif
```

The program will display a busy terminal that simulates activity, just like the original **genact** tool. You can also pass any of the original `genact` options (e.g., `--list-modules`, `--modules cc,wpt`, `--speed-factor 5`).

## Files

- `bin/saif-mac` – Universal macOS binary (Apple Silicon & Intel)
- `bin/saif-linux` – Linux x86_64 musl binary
- `install.sh` – Helper script for easy installation

Enjoy being impressively busy! 🎉
