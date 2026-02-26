#!/bin/bash

# Word → Markdown 変換スクリプト
# 既存の Word ファイルを Markdown に変換して templates/ ディレクトリに配置

set -e

# 色付き出力の設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ヘルプ表示
show_help() {
    cat << EOF
使用方法: $0 [オプション] <入力ファイル.docx>

Word文書をMarkdownに変換してテンプレートディレクトリに配置

オプション:
    -c, --contract      契約書として処理（templates/contracts/に出力）
    -r, --regulation    社内規定として処理（templates/regulations/に出力）
    -o, --output DIR    出力ディレクトリを指定（デフォルト: 自動選択）
    -n, --name FILENAME 出力ファイル名を指定（.mdは不要）
    -h, --help          このヘルプを表示

例:
    $0 -c contract.docx
    $0 -r regulation.docx -n security-policy
    $0 -o templates/custom input.docx
EOF
}

# デフォルト値
OUTPUT_DIR=""
OUTPUT_NAME=""
DOC_TYPE=""

# 引数解析
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--contract)
            DOC_TYPE="contract"
            OUTPUT_DIR="templates/contracts"
            shift
            ;;
        -r|--regulation)
            DOC_TYPE="regulation"
            OUTPUT_DIR="templates/regulations"
            shift
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -n|--name)
            OUTPUT_NAME="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            INPUT_FILE="$1"
            shift
            ;;
    esac
done

# 入力ファイルチェック
if [ -z "$INPUT_FILE" ]; then
    echo -e "${RED}エラー: 入力ファイルが指定されていません${NC}"
    show_help
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}エラー: ファイルが見つかりません: $INPUT_FILE${NC}"
    exit 1
fi

# ファイルタイプが指定されていない場合、推測
if [ -z "$DOC_TYPE" ]; then
    echo -e "${YELLOW}警告: ドキュメントタイプが指定されていません${NC}"
    echo "どちらのタイプですか？"
    echo "  1) 契約書 (contracts)"
    echo "  2) 社内規定 (regulations)"
    echo "  3) カスタム (出力先を指定)"
    read -p "選択 (1-3): " choice
    
    case $choice in
        1)
            DOC_TYPE="contract"
            OUTPUT_DIR="templates/contracts"
            ;;
        2)
            DOC_TYPE="regulation"
            OUTPUT_DIR="templates/regulations"
            ;;
        3)
            read -p "出力ディレクトリ: " OUTPUT_DIR
            DOC_TYPE="custom"
            ;;
        *)
            echo -e "${RED}エラー: 無効な選択です${NC}"
            exit 1
            ;;
    esac
fi

# 出力ディレクトリの作成
mkdir -p "$OUTPUT_DIR"

# 出力ファイル名の決定
if [ -z "$OUTPUT_NAME" ]; then
    # 入力ファイル名から拡張子を除去
    BASENAME=$(basename "$INPUT_FILE" .docx)
    OUTPUT_NAME=$(echo "$BASENAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
fi

OUTPUT_FILE="$OUTPUT_DIR/${OUTPUT_NAME}.md"

# 変換実行
echo -e "${GREEN}変換中: $INPUT_FILE → $OUTPUT_FILE${NC}"

# pandocでMarkdownに変換
pandoc "$INPUT_FILE" \
    -f docx \
    -t markdown \
    -o "$OUTPUT_FILE" \
    --extract-media="$OUTPUT_DIR/media" \
    --wrap=none

# 変換成功確認
if [ -f "$OUTPUT_FILE" ]; then
    echo -e "${GREEN}✓ 変換成功！${NC}"
    echo "  出力: $OUTPUT_FILE"
    
    # textlintでチェック
    echo -e "${YELLOW}textlintチェックを実行中...${NC}"
    if npm run lint > /dev/null 2>&1; then
        echo -e "${GREEN}✓ textlintチェック: 合格${NC}"
    else
        echo -e "${YELLOW}⚠ textlintでエラーが見つかりました${NC}"
        echo "  修正を実行しますか？ (y/n)"
        read -p "> " fix_choice
        if [ "$fix_choice" = "y" ]; then
            npm run lint:fix
            echo -e "${GREEN}✓ 自動修正完了${NC}"
        fi
    fi
    
    # Gitに追加
    echo "Gitに追加しますか？ (y/n)"
    read -p "> " git_choice
    if [ "$git_choice" = "y" ]; then
        git add "$OUTPUT_FILE"
        echo -e "${GREEN}✓ Gitに追加しました${NC}"
    fi
else
    echo -e "${RED}✗ 変換失敗${NC}"
    exit 1
fi
