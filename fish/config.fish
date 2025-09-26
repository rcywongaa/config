if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind -k nul accept-autosuggestion
set --universal tide_left_prompt_items pwd
alias source_ros "bass source /opt/ros/jazzy/setup.bash"
set --export PYTHONPATH $PYTHONPATH /opt/drake/lib/python$(python3 -c 'import sys; print("{0}.{1}".format(*sys.version_info))')/site-packages
alias this_branch "git rev-parse --abbrev-ref HEAD"

fish_add_path ~/.juliaup/bin/
