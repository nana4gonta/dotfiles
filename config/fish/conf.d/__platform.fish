function __is_osx
    test (uname) = "Darwin"
    return $status
end

function __is_linux
    test (uname) = "Linux"
    return $status
end

function __is_wsl
    __is_linux; and echo (uname -a) | grep "Microsoft"
end