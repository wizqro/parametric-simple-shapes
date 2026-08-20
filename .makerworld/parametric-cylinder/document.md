# MakerWorld アップロード情報 — Parametric Cylinder

MakerWorld のアップロード画面で入力する内容と、アップロード対象ファイルの管理メモ。
`[要確認]` は公開前に MakerWorld の実画面または実機で確認する。

## 0. 管理情報

| 項目 | 内容 |
| --- | --- |
| モデル／プロジェクト名 | `Parametric Cylinder` |
| MakerWorld URL | 未公開 |
| 公開ステータス | 下書き |
| 最終更新日 | 2026-08-13 |
| 更新メモ | 円柱を主形状に整理し、中空化を任意オプションへ変更 |

## 1. アップロード

### Bambu Studio ファイル

「このモデルの Bambu Studio ファイル (.3mf) はありますか？」は「はい」を選択する。
Customizerモデルがメイン。以下の3MFは、4種類のサンプルをすぐ印刷できるよう、各デザインについて3〜200 mmの24サイズを1サイズにつき1プレートで収録している。

| ファイル名 | 内容 | プレート数 |
| --- | --- | ---: |
| `3mf/parametric-cylinder-bambu_Design_A_part01.3mf` | Design A: basic solid cylinder | 24 |
| `3mf/parametric-cylinder-bambu_Design_B_part01.3mf` | Design B: rounded solid cylinder | 24 |
| `3mf/parametric-cylinder-bambu_Design_C_part01.3mf` | Design C: flat hollow cylinder | 24 |
| `3mf/parametric-cylinder-bambu_Design_D_part01.3mf` | Design D: rounded hollow cylinder | 24 |

収録外径:
`3` `4` `5` `6` `7` `8` `9` `10` `11` `12` `14` `16` `18` `20` `24` `28` `32` `38` `46` `60` `80` `100` `150` `200` mm

### 生モデルファイル

note欄は1行のみ。以下をそのまま入力する。

| ファイル名 | オープンソース | note（英語・1行） |
| --- | --- | --- |
| `parametric_cylinder.scad` | オフ（非公開） | `Parametric OpenSCAD model used by the MakerWorld Customizer; source access is disabled.` |
| `parametric_cylinder.json` | 該当なし | `OpenSCAD Customizer preset bundle with 100 ready-made variants.` |

- レーザー＆カット用モデル: 「いいえ」
- CyberBrickモデル: 「いいえ」

## 2. 基本情報

### モデル名

`Customizable Parametric Cylinder - 4 Designs`（44文字）

### カテゴリ

- 選択カテゴリ: `[要確認: MakerWorld の実画面で Tools / Household / Other に近い分類を選択]`
- 検索候補: `Tools` / `Household` / `Organization` / `Other`

### タグ

`cylinder` `solid` `hollow` `parametric` `customizable` `spacer` `disc` `openscad`

### ライセンス

公開方針がリポジトリ内に明記されていないため、公開者が最終決定する。

| 設定 | 選択 |
| --- | --- |
| 作品を修正して共有してもよいか | `[要確認]` |
| 商業目的で利用されてもよいか | `[要確認]` |
| 作品・派生物の共有や再配布を許可するか | `[要確認]` |
| 適用ライセンス | `[要確認]` |

### 詳細 — 英語版（MakerWorld入力用）

```text
Use the Customize button on this MakerWorld model page to generate a solid cylinder without installing OpenSCAD. Set the outside diameter and total height independently, and adjust the outside top and bottom edge radii. If you need a hollow cylinder, enable Hollow and set the wall thickness.

The model is solid by default. Hollow adds a centered hole through the full height. Dimensions that would collapse the wall or rounded edge are automatically limited, while the outside diameter and total height remain the controlling overall dimensions.

Four ready-to-print sample design sets are included:
- Design A: basic solid cylinder, with height equal to 12% of the outside diameter
- Design B: solid cylinder with rounded outside top and bottom edges
- Design C: flat hollow cylinder, with height equal to 50% and wall thickness equal to 10% of the outside diameter
- Design D: hollow cylinder with rounded outside top and bottom edges

Each design is supplied as a separate 3MF containing 24 plates, one for each outside diameter: 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 38, 46, 60, 80, 100, 150, and 200 mm.

The models print upright without supports. PLA is recommended for general use. For fitted parts, print a small test first and compensate for your printer's dimensional tolerance. At the smallest sizes, use a clean build plate and reduce print speed if needed.
```

### 詳細 — 日本語版（内容確認用・入力しない）

```text
MakerWorldのモデルページにある「カスタマイズ」ボタンから、OpenSCADをインストールせずに円柱を生成できます。外径と全高を独立指定し、外側の上端・下端の丸みを調整できます。中空円柱が必要な場合だけ`Hollow`を有効にし、肉厚を指定します。

既定値は中身の詰まった円柱です。`Hollow`は中央に全高を貫通する穴を追加します。壁や角丸が消失するような寸法は自動制限され、外径と全高は常に全体寸法として維持されます。

すぐに印刷できる4種類のサンプルデザインを収録しています。
- Design A: 高さが外径の12%の基本円柱
- Design B: 上下の外周エッジを丸めたソリッド円柱
- Design C: 高さが外径の50%、肉厚が10%のフラットな中空円柱
- Design D: 上下の外周エッジを丸めた中空円柱

各デザインの3MFには、外径3〜200 mmの24プレートが入っています。モデルは立てた向きでサポートなしで印刷できます。嵌合用途では、使用プリンターの寸法誤差を確認するため小さなテスト印刷を推奨します。
```

### Boost Me

```text
If you found this customizable cylinder family useful, please consider giving it a Boost! Your support helps me improve these practical parametric models and add more reusable shapes. Thank you!
```

## 3. 造形プロファイル

### 共通設定

| 項目 | 設定 |
| --- | --- |
| プリンター | Bambu Lab H2C |
| ノズル | 0.4 mm |
| 積層ピッチ | 0.2 mm |
| 壁 | 2 |
| インフィル | 15% grid |
| サポート | なし |
| フィラメント | PLA（Bambu PLA Basic） |
| 印刷プリセット | `0.20mm Standard @BBL H2C` |

### プロファイル名と画像

| 3MF | プロファイル名 | 画像 |
| --- | --- | --- |
| Design A | `Design A - Basic Solid Cylinder - 24 Sizes` | `design-A-render.png` |
| Design B | `Design B - Rounded Solid Cylinder - 24 Sizes` | `design-B-render.png` |
| Design C | `Design C - Flat Hollow Cylinder - 24 Sizes` | `design-C-render.png` |
| Design D | `Design D - Rounded Hollow Cylinder - 24 Sizes` | `design-D-render.png` |

各プロファイルの説明には、対応する英語版詳細のDesign行、24プレートであること、共通印刷設定、嵌合用途ではテスト印刷が必要であることを記載する。

## 4. 公開前チェック

- [ ] ライセンスとMW限定モデルプログラムを決定した
- [ ] MakerWorldの実画面でカテゴリを選択した
- [x] モデル名50文字以内、全プロファイル名60文字以内
- [x] タグがASCII文字のみ
- [x] Customizer用SCADと100プリセットのJSONを用意した
- [x] 4つの3MFが有効な3MF構造で、各24プレートを収録している
- [x] 全100プリセットをOpenSCADでmanifold STLとして生成した
- [ ] SCADをMakerWorld Customizerへ読み込み、パラメーター表示と生成を確認した
- [ ] 4つの3MFをBambu Studioで開いてスライスできることを最終確認した
- [ ] 3 mm、50 mm、200 mmを含む代表サイズを実機印刷した
- [ ] 公開用の実物写真を用意した（同梱レンダーは形状確認用）
- [ ] 公開後のMakerWorld URLを管理情報へ記録した
