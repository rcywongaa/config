#!/bin/bash

if [ -z $1 ]; then
  workspace_dir=$(pwd)
else
  workspace_dir="$1"
fi

if [ -z $2 ]; then
  build_dir="build"
else
  build_dir="$2"
fi

workspace_full_path=$(catkin locate --workspace ${workspace_dir})

pushd "$workspace_full_path"

concatenated="${build_dir}/compile_commands.json"

echo "[" > $concatenated

first=1
for d in "${build_dir}"/*
do
    f="$d/compile_commands.json"

    if test -f "$f"; then
        if [ $first -eq 0 ]; then
            echo "," >> $concatenated
        fi

        cat $f | sed '1d;$d' >> $concatenated
    fi

    first=0
done

echo "]" >> $concatenated

popd

sed -i "s%/code%$(pwd)%g" "$workspace_full_path/$concatenated"
