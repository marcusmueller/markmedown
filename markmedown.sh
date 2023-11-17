#!/bin/sh
venvdir="$HOME/.local/share/markmedown/venv"
[[ -r "$venvdir/bin/activate" ]] || (
  mkdir -p "$venvdir"
  python3 -m venv "$venvdir"
  . "$venvdir/bin/activate"
  pip install 'textual>=0.11.0'
  cp markmedown "$venvdir/bin"
  chmod 755 "$venvdir/bin/markmedown"
)
. "$venvdir/bin/activate" && "$venvdir/bin/markmedown" $@
