# Read me!

## Setup

### Manually

You need textual >= 0.11.0. It's possible your distro doesn't have that, so:

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Running:


```shell
source .venv/bin/activate
./markmedown FILE1.md FILE2.md …
```

### Automatedly

```shell
git clone https://github.com/marcusmueller/markmedown
cd markmedown
./markmedown.sh
```

Afterwards, copy `markmedown.sh` to a directory that is listed in your `$PATH`. 

## Usage

### Invocation

If you used the automated installation, you'll need to run `markmedown.sh`. If
you have a working `textual >= 0.11.0` installation that can be found at
runtime by default, you can directly run `markmedown` instead.

Show files:

```shell
markmedown.sh file1.md file2.md 
```

Show files and show the structure of each document in a sidebar:

```shell
markmedown.sh -t file1.md file2.md 
```

![Screencast of markmedown in use](???.gif)

### Navigation

- `←`/`→` keys to switch between files
- `q` to quit
- You can go "into" a document (from the tab/document switcher) using `Tab`,
  and then can use cursor and PageUp/Down keys to navigate the document. You
  can jump back into the navigation with `Shift+Tab`.
