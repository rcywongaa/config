if status is-interactive
  set -g fish_greeting

  # Auto-attach to a shared zellij session, but only inside Ghostty,
  # and never recursively. Comment out `exit` if you'd rather drop
  # back to plain fish after detaching instead of closing the window.
  if not set -q ZELLIJ
      and test "$TERM_PROGRAM" = "ghostty"
      zellij attach -c main
      exit
  end

  # Editor
  set -gx EDITOR nvim
  set -gx VISUAL nvim

  # PATH
  fish_add_path $HOME/.local/bin
  fish_add_path $HOME/.cargo/bin   # Commands to run in interactive sessions can go here
end

bind -k nul accept-autosuggestion
set --universal tide_left_prompt_items pwd
alias source_ros "bass source /opt/ros/jazzy/setup.bash"
set --export PYTHONPATH $PYTHONPATH /opt/drake/lib/python$(python3 -c 'import sys; print("{0}.{1}".format(*sys.version_info))')/site-packages
alias this_branch "git rev-parse --abbrev-ref HEAD"


