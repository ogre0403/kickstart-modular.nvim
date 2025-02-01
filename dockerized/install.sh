nvim() {

  local image=ogre0403/nvim:latest

  # check nvim:latest image exist locally or not
  if [ -z "$(docker images -q $image 2>/dev/null)" ]; then

    # download https://github.com/ogre0403/kickstart-modular.nvim.git into a random named folder under /tmp
    random_name=$(date +%s)
    mkdir -p /tmp/$random_name
    git clone https://github.com/ogre0403/kickstart-modular.nvim.git /tmp/$random_name

    make -C /tmp/$random_name
    rm -rf /tmp/$random_name
  fi

  local nvim_vol=nvim
  docker volume create $nvim_vol >/dev/null

  if [ -z "$1" ]; then
    docker run -it --rm \
      -e AZURE_OPENAI_API_KEY=$OPENAI_API_KEY \
      -v $(pwd):/workspace \
      -v ${nvim_vol}:/root/.config/github-copilot \
      -w /workspace \
      ${image}
    return 0
  fi

  local real_path=$1
  if [ -L $1 ]; then
    real_path=$(readlink -f $1)
  fi

  folder_name=$(dirname "$(realpath $real_path)")
  file_name=$(basename $real_path)

  docker run -it --rm \
    -e AZURE_OPENAI_API_KEY=$OPENAI_API_KEY \
    -v ${folder_name}:/workspace \
    -v ${nvim_vol}:/root/.config/github-copilot \
    -w /workspace \
    ${image} \
    /workspace/${file_name}
}

install_fun() {
  local function_name="$1"    # 第一個參數是函數名稱
  local zshrc_path="$2"       # 第二個參數是 .zshrc 的路徑
  local source_file_path="$0" # 獲取當前腳本的路徑

  # 檢查是否提供了足夠的參數
  if [[ -z "$function_name" || -z "$zshrc_path" ]]; then
    echo "Usage: install_my_function <function_name> <zshrc_path>"
    return 1
  fi

  # 使用 grep 檢查 .zshrc 中是否已經定義了該函數
  if grep -q "^[[:space:]]*${function_name}()" "$zshrc_path"; then
    echo "Function $function_name already exists in $zshrc_path"
  else
    # 使用 sed 提取並追加函數定義
    echo "

        " >>$zshrc_path

    sed -n "/^[[:space:]]*${function_name}()/,/^}/p" "$source_file_path" >>"$zshrc_path"
    echo "Function $function_name has been added to $zshrc_path"
  fi

  # 加載新的 .zshrc 配置
  #source "$zshrc_path"
}

# check if there is one parameter

if [ -z "$1" ]; then
  echo "Usage: setup.sh <shell_rc_file>"
  exit 1
fi

install_fun nvim $1
