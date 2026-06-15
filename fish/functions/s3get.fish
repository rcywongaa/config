function s3get --description 'Recursively copy a subfolder from path-robotics-raw-datasets to a local dir'
    if test (count $argv) -ne 2
        echo "Usage: s3get <dataset> <subfolder>" >&2
        return 1
    end
    aws s3 cp "s3://path-robotics-raw-datasets/$argv[1]/$argv[2]" "./$argv[2]/" --recursive
end
