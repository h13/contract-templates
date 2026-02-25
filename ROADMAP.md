# Contract Templates - 開発ロードマップ

## 🎯 ビジョン

**Markdown を SSoT（Single Source of Truth）として、契約書ひな形・社内規定を統一管理する。**

### 方針
- **管理対象**: ひな形の改訂履歴のみ（実際の契約書は別管理）
- **入力**: 既存 Word/PDF → Markdown 変換
- **出力**: Markdown → Word/PDF 変換
- **対象**: 契約書ひな形 + 社内規定

---

## 📅 Phase 1: 基盤強化（1-2週間）

### ✅ 完了
- [x] 基本リポジトリ構成
- [x] GitHub Actions による Word 変換
- [x] textlint による品質チェック

### 🔄 進行中
- [ ] **CI/CD の動作確認**
  - 手動実行テスト
  - paths フィルターの調整
  - エラー時の通知設定

### 📝 TODO
- [ ] **テンプレートの種類拡充**
  - 契約書ひな形
    - NDA（双方向/片方向）
    - 業務委託契約書
    - 雇用契約書
    - 秘密保持誓約書
  - 社内規定
    - 就業規則
    - 経費精算規程
    - 情報セキュリティ規程
    - 出退勤管理規程
    - 育児・介護休業規程

- [ ] **Word テンプレートのカスタマイズ**
  - フォント設定（游明朝/ゴシック）
  - 余白・行間調整
  - ヘッダー・フッター設定
  - スタイル定義（見出し1〜3、本文）
  - 社内規定用テンプレート

- [ ] **textlint ルールの調整**
  - 法律用語の統一
  - 社内用語の登録
  - 誤字脱字パターンの追加
  - 除外ルールの設定
  - 社内規定特有のルール

- [ ] **ドキュメント整備**
  - 使い方ガイド（README.md 拡充）
  - トラブルシューティング
  - サンプルコード集
  - 「SSoT = ひな形のみ」の明記

---

## 📅 Phase 2: 双方向変換・既存文書取り込み（2-3週間）

### 🎯 目標
**既存の Word/PDF を取り込んで Markdown で管理** + **Markdown から Word/PDF 出力**

### 📝 TODO
- [ ] **Word → Markdown 変換**
  - Pandoc を使った逆変換の実装
  - 複雑な表・画像の対応
  - フォーマットの保持
  - バッチ処理スクリプト作成

- [ ] **PDF → Markdown 変換**
  - pdf2txt / pdfplumber の検討
  - OCR 連携（必要に応じて）
  - レイアウト保持の工夫
  - 手動修正フローの確立

- [ ] **変換品質の向上**
  - 変換前後の比較ツール
  - 自動修正パターンの学習
  - 手動修正ガイドライン
  - 変換ログの記録

- [ ] **双方向ワークフローの確立**
  ```
  既存文書 → Markdown → 編集 → Word/PDF
         ↑                      ↓
         └───────── フィードバックループ ─────┘
  ```

- [ ] **取り込み用スクリプト**
  - `scripts/import-word.sh`
  - `scripts/import-pdf.sh`
  - 一括取り込み機能
  - 変換結果の自動コミット

---

## 📅 Phase 3: メタデータ・検索機能（2-3週間）

### 🎯 目標
**ひな形のバージョン管理と検索性の向上**

### 📝 TODO
- [ ] **フロントマター（YAMLヘッダー）の標準化**
  ```yaml
  ---
  id: template-nda-001
  title: 秘密保持契約書（雛形）
  type: nda
  version: 2.1
  category: contract
  applicable_to:
    - パートナー企業
    - 業務委託先
  created_by: legal-team
  created_at: 2025-01-20
  last_modified: 2025-02-25
  review_frequency: annual
  next_review: 2026-02-25
  tags: [nda, confidentiality, partner]
  related_templates:
    - template-employment-001
  source:
    - imported_from: legacy.docx
    - imported_date: 2025-01-15
  ---
  ```

- [ ] **ひな形インデックスの自動生成**
  - `templates/index.md` を自動生成
  - テーブル形式で一覧表示
  - フィルタリング機能（種類、カテゴリ、タグ）
  - GitHub Actions で定期更新

- [ ] **検索機能の実装**
  - 全文検索（ripgrep/fzf）
  - メタデータ検索
  - タグベース検索
  - CLI ツールの作成

- [ ] **バージョン管理の強化**
  - 変更履歴の可視化
  - 差分比較機能
  - ロールバック機能

---

## 📅 Phase 4: 入出力フォーマット対応（1-2週間）

### 🎯 目標
**入力**: 既存文書取り込み | **出力**: 多様なフォーマット生成

### 📝 TODO

#### 入力（インポート）
- [ ] **Word インポート強化**
  - 複雑な表の取り込み
  - 画像の埋め込み対応
  - スタイルの保持
  - 手動修正の最小化

- [ ] **PDF インポート**
  - テキスト抽出
  - OCR 連携（必要時）
  - 構造認識
  - 品質チェック

- [ ] **その他フォーマット**
  - Google Docs 取り込み
  - HTML 取り込み
  - プレーンテキスト取り込み

#### 出力（エクスポート）
- [ ] **Word 出力**（現状）
  - テンプレートベース
  - スタイル適用
  - メタデータ埋め込み

- [ ] **PDF 出力**
  - pandoc による PDF 生成
  - 日本語フォントの設定
  - レイアウト調整
  - 印刷品質の確保

- [ ] **HTML 出力**
  - Web 表示用 HTML 生成
  - スタイリング（CSS）
  - GitHub Pages での公開
  - レスポンシブ対応

- [ ] **その他フォーマット**
  - LaTeX 出力（学術用途）
  - EPUB 出力（電子書籍）
  - プレーンテキスト出力

---

## 📅 Phase 5: Web UI（3-4週間）

### 🎯 目標
非エンジニアでも使いやすい Web インターフェース

### 📝 TODO
- [ ] **GitHub Pages サイト構築**
  - React/Vue.js ベースの SPA
  - 契約書一覧ページ
  - 検索・フィルタリング UI
  - プレビュー機能

- [ ] **Markdown エディタ統合**
  - Monaco Editor / CodeMirror
  - シンタックスハイライト
  - リアルタイムプレビュー
  - 変数ハイライト

- [ ] **フォームベース入力**
  - 変数入力フォーム
  - バリデーション
  - プレビュー機能
  - YAML/JSON エクスポート

- [ ] **GitHub API 連携**
  - OAuth 認証
  - ファイル作成・編集
  - PR 作成
  - コミット履歴表示

---

## 📅 Phase 6: 通知・アラート（1-2週間）

### 🎯 目標
契約書の有効期限管理と変更通知

### 📝 TODO
- [ ] **有効期限監視**
  - GitHub Actions で定期チェック（毎日）
  - 期限切れ契約書のリストアップ
  - 30日前・7日前・当日のアラート

- [ ] **通知チャネル連携**
  - Slack 通知
  - Discord 通知
  - メール通知（SendGrid/SES）
  - Webhook 対応

- [ ] **変更通知**
  - 新規契約書追加時の通知
  - 既存契約書の更新通知
  - PR 作成・マージ通知
  - CI 失敗通知

---

## 📅 Phase 7: 多言語対応（2-3週間）

### 🎯 目標
英語・中国語など多言語契約書の自動生成

### 📝 TODO
- [ ] **多言語テンプレート構造**
  ```
  contracts/
  ├── nda/
  │   ├── ja.md
  │   ├── en.md
  │   └── zh.md
  ```

- [ ] **用語集管理**
  - YAML での用語定義
  - 言語間マッピング
  - 翻訳メモリ機能

- [ ] **自動翻訳連携**
  - DeepL API 統合
  - Google Translate API 統合
  - 翻訳品質のレビューフロー

- [ ] **言語切替 UI**
  - Web UI での言語選択
  - 比較表示機能
  - 翻訳差分ハイライト

---

## 📅 Phase 8: 高度な機能（継続的）

### 🎯 目標
実務でさらに役立つ機能の追加

### 📝 TODO
- [ ] **契約書比較機能**
  - 2つのバージョンの差分表示
  - 変更箇所のハイライト
  - 変更理由の記録

- [ ] **条項ライブラリの拡充**
  - 業界別条項集
  - 法改正対応
  - ベストプラクティス集

- [ ] **監査ログ**
  - 全変更の履歴記録
  - アクセスログ
  - 承認フロー

- [ ] **API 提供**
  - REST API エンドポイント
  - 外部システム連携
  - Webhook 受信

- [ ] **電子署名連携**
  - DocuSign 連携
  - Adobe Sign 連携
  - 署名状況の追跡

---

## 📊 優先度マトリックス

| 機能 | 重要度 | 緊急度 | 工数 | 優先度 |
|------|--------|--------|------|--------|
| CI/CD 動作確認 | 高 | 高 | 小 | **P0** |
| Word テンプレート調整 | 高 | 中 | 小 | **P1** |
| 社内規定テンプレート追加 | 高 | 中 | 小 | **P1** |
| Word → Markdown 変換 | 高 | 高 | 中 | **P1** |
| PDF → Markdown 変換 | 中 | 中 | 中 | **P2** |
| メタデータ管理 | 中 | 低 | 中 | **P2** |
| PDF 出力 | 中 | 低 | 小 | **P2** |
| Web UI | 中 | 低 | 大 | **P3** |
| 通知・アラート | 低 | 低 | 中 | **P4** |
| 多言語対応 | 低 | 低 | 大 | **P4** |

---

## 🏁 マイルストーン

### Milestone 1: MVP（Minimum Viable Product）
**目標: 2週間**
- CI/CD 完全動作
- 基本的なひな形5種類（契約書3種 + 社内規定2種）
- textlint ルール調整完了
- 基本的な Word 出力

### Milestone 2: 双方向変換版
**目標: 4-6週間**
- Word → Markdown 変換機能
- PDF → Markdown 変換機能（基本）
- 既存文書の取り込みフロー確立
- PDF 出力対応

### Milestone 3: 本格運用版
**目標: 8-12週間**
- メタデータ管理
- ひな形インデックス自動生成
- 検索機能
- Web UI（基本機能）

### Milestone 4: エンタープライズ版
**目標: 3-6ヶ月**
- 多言語対応
- 高度なインポート機能
- API 提供
- 監査ログ

---

## 🤝 貢献ガイドライン

### 開発に参加するには
1. Issue を作成して機能提案
2. フォークして機能ブランチ作成
3. PR を作成してレビュー
4. マージ後にリリース

### コーディング規約
- Markdown: JTF 日本語標準スタイルガイド準拠
- コミットメッセージ: Conventional Commits
- ブランチ命名: `feature/機能名` `fix/バグ名`

---

## 📂 ディレクトリ構成案

```
contract-templates/
├── .github/workflows/
│   ├── build.yml           # MD → Word/PDF 変換
│   ├── lint.yml            # textlint チェック
│   └── import.yml          # 既存文書取り込み
├── templates/
│   ├── contracts/          # 契約書ひな形
│   │   ├── nda-bilateral.md
│   │   ├── nda-unilateral.md
│   │   ├── service-agreement.md
│   │   └── employment.md
│   ├── regulations/        # 社内規定
│   │   ├── work-rules.md
│   │   ├── expense-policy.md
│   │   ├── security-policy.md
│   │   └── attendance-policy.md
│   ├── reference.docx      # Word テンプレート
│   └── clauses/            # 共通条項（将来用）
├── scripts/
│   ├── import-word.sh      # Word取り込みスクリプト
│   ├── import-pdf.sh       # PDF取り込みスクリプト
│   ├── build-all.sh        # 全テンプレート変換
│   └── validate.sh         # メタデータ検証
├── imports/                # 取り込み済み文書（履歴）
│   ├── legacy/
│   └── archive/
├── dist/                   # 生成されたWord/PDF
├── .textlintrc             # textlint 設定
├── package.json            # 依存関係
├── README.md               # 使い方
└── ROADMAP.md              # このファイル
```

---

## 📚 参考リソース

- [Pandoc ドキュメント](https://pandoc.org/)
- [textlint ルール一覧](https://github.com/textlint/textlint/wiki/Collection-of-textlint-rule)
- [GitHub Actions ドキュメント](https://docs.github.com/en/actions)
- [JTF 日本語標準スタイルガイド](https://www.jtf.jp/jp/style_guide/styleguide_top.html)

---

## 📝 変更履歴

- 2025-02-25: 初版作成
- 2025-02-25: **方針転換** - SSoT = ひな形のみ、双方向変換重視、社内規定追加
- ロードマップ策定完了
