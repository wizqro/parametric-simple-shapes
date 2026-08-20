# MakerWorld アップロード情報テンプレート

MakerWorld のアップロード画面で入力する内容の下書き・記録用テンプレート。
`{{...}}` をモデル固有の内容に置き換え、不要な項目は削除する。

## 0. 管理情報

| 項目 | 内容 |
| --- | --- |
| モデル／プロジェクト名 | `{{PROJECT_NAME}}` |
| MakerWorld URL | `{{MODEL_URL_OR未公開}}` |
| 公開ステータス | `{{下書き／公開済み／更新予定}}` |
| 最終更新日 | `{{YYYY-MM-DD}}` |
| 更新メモ | `{{今回の変更内容}}` |

## 1. アップロード (Upload)

### このモデルの Bambu Studio ファイル (.3mf) はありますか？

- `{{はい（追加ポイント報酬を獲得）／いいえ}}`

### Bambu Studio ファイル（造形プロファイル）

- `{{MODEL_PROFILE_FILE}}.3mf`

### 生モデルファイル

note 欄は1行のみ（複数行不可）。海外ユーザー向けに英語で入力する。

| ファイル名 | 種別 | オープンソース | note（英語・1行） |
| --- | --- | --- | --- |
| `{{SOURCE_OR_MODEL_FILE_1}}` | `{{SCAD／STEP／STL／その他}}` | `{{オン／オフ}}` | `{{FILE_NOTE_1}}` |
| `{{SOURCE_OR_MODEL_FILE_2}}` | `{{SCAD／STEP／STL／その他}}` | `{{オン／オフ}}` | `{{FILE_NOTE_2}}` |

ファイル数が多い場合は、以下の行を複製する。

| ファイル名 | note（英語・1行） |
| --- | --- |
| `{{MODEL_FILE_01}}` | `{{MODEL_FILE_NOTE_01}}` |
| `{{MODEL_FILE_02}}` | `{{MODEL_FILE_NOTE_02}}` |

### 追加ファイル（任意）

- `{{PRESET／README／設定ファイルなど}}`
  - note: `{{ADDITIONAL_FILE_NOTE}}`

### このモデルにレーザー＆カット用モデルは含まれていますか？

- `{{はい／いいえ}}`

### アップロードしたモデルは CyberBrick モデルですか？

- `{{はい／いいえ}}`

## 2. 基本情報 (Basic Info)

海外ユーザー向けに、モデル名・タグ・詳細は原則として英語で用意する。

### モデル名 (0/50)

`{{MODEL_TITLE}}`（`{{CHAR_COUNT}}`文字）

タイトル方針・候補:

- `{{TITLE_NOTE_OR_ALTERNATIVE}}`

### カテゴリ

- 選択カテゴリ: `{{CATEGORY_OR未確定}}`
- 検索キーワード候補: `{{CATEGORY_KEYWORD_1}}` / `{{CATEGORY_KEYWORD_2}}` / `{{CATEGORY_KEYWORD_3}}`

### タグ (0/50, 0/100)

タグ入力欄は ASCII 文字のみを受け付けるため、英語ワードで統一する。
文字数上限を超える場合は、優先度の低いタグから削る。

`{{TAG_1}}` `{{TAG_2}}` `{{TAG_3}}` `{{TAG_4}}` `{{TAG_5}}`

### ライセンス

| 設定 | 選択 |
| --- | --- |
| 作品を修正して共有してもよいか | `{{はい／いいえ}}` |
| 商業目的で利用されてもよいか | `{{はい／いいえ}}` |
| 作品・派生物の共有や再配布を許可するか | `{{はい／いいえ}}` |
| 適用ライセンス | `{{LICENSE_NAME}}` |

### 公開設定

- `{{公開／非公開}}`

### 詳細（説明文、リッチテキスト）

以下を貼り付ける（原則英語。必要なら末尾に短い日本語案内を追加）:

```text
{{ONE_SENTENCE_SUMMARY}}

{{FEATURES_AND_SUPPORTED_USE_CASES}}

Included files / presets:
- {{INCLUDED_ITEM_1}}
- {{INCLUDED_ITEM_2}}
- {{INCLUDED_ITEM_3}}

How to use / customize:
{{USAGE_OR_CUSTOMIZATION_STEPS}}

Print notes:
{{IMPORTANT_PRINTING_OR_COMPATIBILITY_NOTES}}

（日本語: {{SHORT_JAPANESE_DESCRIPTION}}）
```

### コミュニティ投稿

- `{{オン／オフ}}`
- 投稿メモ: `{{COMMUNITY_POST_NOTE_ORなし}}`

### ドキュメント

- `{{追加ファイル名／追加なし}}`
- 理由・内容: `{{DOCUMENT_NOTE}}`

### MW 限定モデルプログラム

- `{{対象／対象外／要確認}}`

### 部品表 (BOM)

- `{{オン／オフ}}`
- 部品: `{{PURCHASED_PARTS_ORなし}}`

## 3. 造形プロファイルの詳細 (Print Profile Details)

### Bambu Studio ファイル

- `{{MODEL_PROFILE_FILE}}.3mf`

### プロファイル名 (0/60)

`{{LAYER_HEIGHT}} layer, {{WALL_COUNT}} walls, {{INFILL_PERCENT}} infill`（`{{CHAR_COUNT}}`文字）

### プロファイル画像

- 使用画像: `{{PROFILE_IMAGE_FILE}}`
- 状態: `{{実物写真／仮画像／差し替え予定}}`
- メモ: `{{PROFILE_IMAGE_NOTE}}`

### プロファイル説明

以下を貼り付ける（英語）:

```text
{{LAYER_HEIGHT}} layer height, {{WALL_COUNT}} perimeter walls, {{INFILL_PERCENT}} {{INFILL_PATTERN}} infill, {{SUPPORT_REQUIREMENT}}.

{{PLATE_AND_MODEL_CONTENTS}}

{{RECOMMENDED_MATERIAL_AND_PRINTING_ADVICE}}
```

### プリンター互換性チェック

- `{{全機種／対応機種のみ}}`
- 対応機種・除外理由: `{{PRINTER_COMPATIBILITY_NOTE}}`

### プレート

3MF 内のプレートと生モデルファイルが同じ順序・内容になっているか確認する。

| No. | プレート名 | 対応モデルファイル | 確認 |
| ---: | --- | --- | :---: |
| 1 | `{{PLATE_NAME_1}}` | `{{MODEL_FILE_1}}` | [ ] |
| 2 | `{{PLATE_NAME_2}}` | `{{MODEL_FILE_2}}` | [ ] |

## 4. 公開前チェック

- [ ] `{{...}}` の未置換プレースホルダーが残っていない
- [ ] モデル名が50文字以内、プロファイル名が60文字以内
- [ ] タグが ASCII 文字のみで、文字数上限内
- [ ] ファイル名と note の対応が正しい
- [ ] 3MF が Bambu Studio で正常に開ける
- [ ] プレート順・プレート名・生モデルファイルの対応が正しい
- [ ] スライス結果、サポート要否、材料、積層設定を確認済み
- [ ] サムネイル／プロファイル画像に実物の完成品が分かりやすく写っている
- [ ] 説明文の寸法、数量、対応規格、使用方法が実ファイルと一致する
- [ ] ライセンスとオープンソース設定が意図どおり
- [ ] カテゴリ、公開設定、MW 限定モデル、BOM の選択を確認済み
- [ ] 公開後の MakerWorld URL と更新日を「管理情報」に記録した
