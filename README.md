# Contract Templates

契約書テンプレートを Markdown で管理し、GitHub Actions で Word 文書に変換するプロジェクトです。

## 特徴

- **バージョン管理**: 契約書の変更履歴を Git で管理
- **品質チェック**: textlint で表記揺れ・モレを防止
- **自動変換**: Markdown → Word 変換を自動化
- **差分比較**: Markdown で差分を可視化

## ディレクトリ構成

```
contract-templates/
├── .github/workflows/    # GitHub Actions 設定
│   ├── build.yml         # MD → Word 変換
│   └── lint.yml          # textlint チェック
├── templates/            # Word テンプレート
│   └── reference.docx    # 書式テンプレート
├── contracts/            # 契約書 Markdown ファイル
│   └── nda-sample.md     # サンプル NDA
├── .textlintrc           # textlint 設定
├── package.json          # 依存関係
└── README.md             # このファイル
```

## 使い方

### 1. 契約書を作成

`contracts/` ディレクトリに Markdown ファイルを作成：

```bash
# 例：新しい NDA を作成
vim contracts/nda-2025-01.md
```

### 2. textlint でチェック

```bash
# インストール
npm install

# チェック実行
npm run lint

# 自動修正
npm run lint:fix
```

### 3. Pull Request 作成

```bash
git checkout -b feature/nda-2025-01
git add contracts/nda-2025-01.md
git commit -m "NDA 追加: 2025年1月版"
git push origin feature/nda-2025-01
```

PR 作成後、自動的に：
- textlint が実行（チェック）
- Word 文書が生成（ビルド）

### 4. Word 文書をダウンロード

PR がマージされると、Actions → Artifacts から Word 文書をダウンロード可能。

## ローカルで Word 変換

```bash
# Pandoc インストール（macOS）
brew install pandoc

# 変換実行
pandoc contracts/nda-sample.md -o output.docx --reference-doc=templates/reference.docx
```

## テンプレートのカスタマイズ

`templates/reference.docx` を編集して、以下をカスタマイズ：

- フォント・サイズ
- 余白・行間
- ヘッダー・フッター
- スタイル（見出し、本文など）

## textlint ルール

現在使用中のルール：

- `preset-japanese`: 日本語の基本チェック
- `preset-jtf-style`: JTF 日本語標準スタイルガイド
- `terminology`: 用語統一

カスタムルールの追加は `.textlintrc` を編集。

## 注意事項

- **Markdown を正とする**: Word 文書は生成物扱い
- **最終確認は Word で**: 必要に応じて Word で微調整
- **法務レビュー**: 弁護士確認は従来フローで実施

## 今後の拡張案

- [ ] 契約書テンプレートの種類を増やす
- [ ] 共通条項をモジュール化
- [ ] 変数置換機能（氏名、日付などを自動挿入）
- [ ] PDF 出力にも対応
- [ ] Slack/Discord 通知連携

## ライセンス

MIT

## 貢献

Issue、Pull Request 大歓迎！
