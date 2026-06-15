function merge_compile_commands --description 'Merge all compile_commands.json under cwd into ./compile_commands.json'
    if not command -q jq
        echo "merge_compile_commands: requires jq" >&2
        return 1
    end

    set -l files (find . -name compile_commands.json -not -path ./compile_commands.json)
    if test (count $files) -eq 0
        echo "merge_compile_commands: no compile_commands.json found under "(pwd) >&2
        return 1
    end

    set -l tmp (mktemp)
    if jq -s 'add | unique_by(.file)' $files >$tmp
        mv $tmp ./compile_commands.json
        echo "Merged "(count $files)" file(s) into ./compile_commands.json"
    else
        rm -f $tmp
        return 1
    end
end
