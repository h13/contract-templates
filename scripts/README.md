# Scripts - 変換スクリプト

このディレクトリには、既存の文書をMarkdownに変換するためのスクリプトが含まれています。

## スクリプト一覧

### import-word.sh

Word文書をMarkdownに変換します。

**使用方法:**
```bash
# 契約書として変換
./scripts/import-word.sh -c existing-contract.docx

# 社内規定として変換
./scripts/import-word.sh -r existing-regulation.docx -n security-policy

# カスタム出力先を指定
./scripts/import-word.sh -o templates/custom input.docx
```

**オプション:**
- `-c, --contract`: 契約書として処理（templates/contracts/に出力）
- `-r, --regulation`: 社内規定として処理（templates/regulations/に出力）
- `-o, --output DIR`: 出力ディレクトリを指定
- `-n, --name FILENAME`: 出力ファイル名を指定（.mdは不要）
- `-h, --help`: ヘルプを表示

**必要なツール:**
- pandoc（`brew install pandoc`）

### import-pdf.sh

PDF文書をMarkdownに変換します。

**使用方法:**
```bash
# 契約書として変換
./scripts/import-pdf.sh -c existing-contract.pdf

# 社内規定として変換
./scripts/import-pdf.sh -r existing-regulation.pdf -n work-rules

# 変換方法を指定
./scripts/import-pdf.sh -m pdftotext input.pdf
```

**オプション:**
- `-c, --contract`: 契約書として処理
- `-r, --regulation`: 社内規定として処理
- `-o, --output DIR`: 出力ディレクトリを指定
- `-n, --name FILENAME`: 出力ファイル名を指定
- `-m, --method METHOD`: 変換方法を指定（pdftotext|pandoc）
- `-h, --help`: ヘルプを表示

**必要なツール:**
- pdftotext（`brew install poppler`）
- または pandoc（`brew install pandoc`）

**注意事項:**
- PDFからの変換は構造が保持されない場合があります
- 変換後の手動修正が必要です
- 見出し、リスト、表の整形を確認してください

## 変換後の作業

1. **構造の確認**: 見出しレベル、リスト形式を確認
2. **textlintチェック**: `npm run lint`で品質チェック
3. **手動修正**: 必要に応じて内容を修正
4. **Gitに追加**: 変更をコミット

## トラブルシューティング

### 文字化けする場合

PDFの文字コードが正しく認識されていない可能性があります。pdftotextのオプションを試してください：
```bash
pdftotext -layout -enc UTF-8 input.pdf output.txt
```

### 表が崩れる場合

PDFの表は複雑な構造を持つため、手動での修正が必要です。Markdownの表形式に書き換えてください。

### 画像が含まれる場合

Word文書の画像は `media/` サブディレクトリに抽出されます。必要に応じて適切な場所に移動してください。
