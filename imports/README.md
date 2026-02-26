# このディレクトリにWord/PDFファイルを配置してください

このディレクトリは、既存のWord/PDF文書を自動的にMarkdownに変換するための場所です。

## 使い方

1. **ファイルを追加**: Word（.docx）またはPDF（.pdf）ファイルをこのディレクトリに配置
2. **コミット & プッシュ**: 変更をコミットしてプッシュ
3. **自動変換**: GitHub Actionsが自動的にMarkdownに変換
4. **PR作成**: 変換結果がPull Requestとして作成されます
5. **確認 & マージ**: 内容を確認してマージ

## ディレクトリ構成

```
imports/
├── contracts/        # 契約書を配置
│   ├── nda-2024.docx
│   └── service-agreement.pdf
└── regulations/      # 社内規定を配置
    ├── work-rules.docx
    └── security-policy.pdf
```

## 注意事項

- **Word（.docx）**: 高品質な変換が可能
- **PDF**: 構造が保持されない場合があります。手動修正が必要です
- **ファイル名**: 英数字とハイフンを使用してください（例：`contract-001.docx`）
- **エンコーディング**: UTF-8を推奨

## 手動変換

自動変換を待たずに手動で変換したい場合：

```bash
# Word → Markdown
./scripts/import-word.sh -c imports/contracts/sample.docx

# PDF → Markdown
./scripts/import-pdf.sh -r imports/regulations/sample.pdf
```

## 変換後の作業

1. **内容確認**: 変換結果を目視確認
2. **フロントマター調整**: タイトル、タグ等を編集
3. **textlintチェック**: エラーがあれば修正
4. **マージ**: 問題なければマージ

## アーカイブ

変換が完了したファイルは、`imports/archive/` ディレクトリに移動することを推奨します。

```
imports/
├── archive/          # 変換済みファイルのアーカイブ
│   ├── 2025-01/
│   └── 2025-02/
├── contracts/
└── regulations/
```

---

**注意**: このディレクトリのファイルは、変換後にアーカイブまたは削除することを推奨します。
