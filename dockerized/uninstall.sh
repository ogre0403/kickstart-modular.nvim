#!/bin/bash



#!/bin/bash

uninstall() {
    local function_name="$1"  # 第一個參數是函數名稱
    local zshrc_path="$2"     # 第二個參數是 .zshrc 的路徑

    # 檢查是否提供了足夠的參數
    if [[ -z "$function_name" || -z "$zshrc_path" ]]; then
        echo "Usage: uninstall_my_function <function_name> <zshrc_path>"
        return 1
    fi

    # 使用 grep 檢查 .zshrc 中是否存在該函數
    if grep -q "^[[:space:]]*${function_name}()" "$zshrc_path"; then
        # 使用 sed 刪除函數定義
        sed -i.bak "/^[[:space:]]*${function_name}()/,/^}/d" "$zshrc_path"
        echo "Function $function_name has been removed from $zshrc_path"
    else
        echo "Function $function_name does not exist in $zshrc_path"
    fi

    # 加載新的 .zshrc 配置
    #source "$zshrc_path"
}

# check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <shell_rc_path>"
    exit 1
fi

uninstall nvim $1
