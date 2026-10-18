
#!/bin/bash
set -euo pipefail

# ========== 配置区 ==========
FINGER_TXT="release_sha256_fingerprint.txt"
# ============================

# 检查参数
if [ $# -ne 1 ]; then
    echo "Usage: $0 <target_file>"
    echo "Example: $0 my_release.exe"
    exit 1
fi

TARGET_FILE="$1"

# 检查文件是否存在
if [ ! -f "${TARGET_FILE}" ]; then
    echo "ERROR: 文件 '${TARGET_FILE}' 不存在"
    exit 1
fi

# 检查 sha256sum 命令是否存在
if ! command -v sha256sum &> /dev/null; then
    echo "ERROR: sha256sum 命令不存在，请安装 coreutils (Linux) 或使用 shasum (Mac)"
    # Mac 兼容提示
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "提示: Mac 用户可以使用 'shasum -a 256' 替代"
    fi
    exit 1
fi

echo "=== 正在计算文件 SHA256 指纹 ==="
echo "目标文件: ${TARGET_FILE}"

# 生成指纹并保存到文件
# sha256sum 输出格式通常为: hash  filename
sha256sum "${TARGET_FILE}" > "${FINGER_TXT}"

echo -e "\n==== 完成！SHA256指纹 ===="
cat "${FINGER_TXT}"
echo "指纹已保存至: ${FINGER_TXT}"

