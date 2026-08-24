# MakerWorld アップロード情報 — Parametric Cylinder

MakerWorld のアップロード画面で入力する内容と、アップロード対象ファイルの管理メモ。
`[要確認]` は公開前に MakerWorld の実画面または実機で確認する。

## 0. 管理情報

| 項目 | 内容 |
| --- | --- |
| モデル／プロジェクト名 | `Parametric Cylinder` |
| MakerWorld URL | 未公開 |
| 公開ステータス | 下書き |
| 最終更新日 | 2026-08-24 |
| 更新メモ | 上下エッジの丸みをはっきり見えるサイズに拡大。ハートに準拠したドーム上面（Design E、ソリッド限定）を追加。中空＋ドームの組み合わせは印刷不可のため実装せず、常にTop Edge Fillet扱いにフォールバック。5デザイン×24サイズの3MFを再生成し、Bambu Studioで全ファイルの読み込みを確認済み。 |

## 1. アップロード

### Bambu Studio ファイル

「このモデルの Bambu Studio ファイル (.3mf) はありますか？」は「はい」を選択する。
Customizerモデルがメイン。以下の3MFは、5種類のサンプルをすぐ印刷できるよう、各デザインについて3〜200 mmの24サイズを1サイズにつき1プレートで収録している。

| ファイル名 | 内容 | プレート数 |
| --- | --- | ---: |
| `3mf/parametric-cylinder-bambu_Design_A_part01.3mf` | Design A: 基本のソリッド円柱（フラット） | 24 |
| `3mf/parametric-cylinder-bambu_Design_B_part01.3mf` | Design B: 上下エッジを丸めたソリッド円柱 | 24 |
| `3mf/parametric-cylinder-bambu_Design_C_part01.3mf` | Design C: フラットな中空円柱（リング） | 24 |
| `3mf/parametric-cylinder-bambu_Design_D_part01.3mf` | Design D: 上下エッジを丸めた中空円柱 | 24 |
| `3mf/parametric-cylinder-bambu_Design_E_part01.3mf` | Design E: 上面をドーム状にしたソリッド円柱 | 24 |

収録外径:
`3` `4` `5` `6` `7` `8` `9` `10` `11` `12` `14` `16` `18` `20` `24` `28` `32` `38` `46` `60` `80` `100` `150` `200` mm

`3mf/parametric-cylinder-bambu_Demo_part01.3mf`（5プレート、確認用デモ）は形状確認・掲載レンダー撮影用の内部ファイルで、アップロード対象には含めない。

### 生モデルファイル

note欄は1行のみ。以下をそのまま入力する。

| ファイル名 | オープンソース | note（英語・1行） |
| --- | --- | --- |
| `parametric_cylinder.scad` | オフ（非公開） | `Parametric OpenSCAD model used by the MakerWorld Customizer; source access is disabled.` |
| `parametric_cylinder.json` | 該当なし | `OpenSCAD Customizer preset bundle with 125 ready-made variants.` |

- レーザー＆カット用モデル: 「いいえ」
- CyberBrickモデル: 「いいえ」

## 2. 基本情報

### モデル名

`Customizable Parametric Cylinder - 5 Designs`（44文字）

### カテゴリ

- 選択カテゴリ: `[要確認: MakerWorld の実画面で Tools / Household / Other に近い分類を選択]`
- 検索候補: `Tools` / `Household` / `Organization` / `Other`

### タグ

`cylinder` `solid` `hollow` `dome` `parametric` `customizable` `spacer` `disc` `openscad`

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
Use the Customize button on this MakerWorld model page to generate a cylinder without installing OpenSCAD. Set the outside diameter and total height independently. Enable Hollow to add a centered through-hole with adjustable wall thickness. Choose a Top Surface Style of Domed Surface (solid bodies only) or Top Edge Fillet, and round the outside bottom edge independently of the top treatment.

The model is solid by default. Hollow adds a centered hole through the body height. Domed Surface is not offered together with Hollow: a dome over an open cavity would need an unsupported bridge that could never be removed once printed, so Hollow bodies always use Top Edge Fillet regardless of the Top Surface Style setting. Dimensions that would collapse the wall or a fillet are automatically limited, while the outside diameter and total height remain the controlling overall dimensions.

Five ready-to-print sample design sets are included:
- Design A: basic solid cylinder, with height equal to 12% of the outside diameter
- Design B: solid cylinder with clearly rounded outside top and bottom edges (10% of the outside diameter)
- Design C: flat hollow cylinder (ring), with height equal to 50% and wall thickness equal to 10% of the outside diameter
- Design D: hollow cylinder with clearly rounded outside top and bottom edges (wall thickened to keep the larger fillet visible)
- Design E: solid cylinder with a domed cap above the body, like a capsule top

Each design is supplied as a separate 3MF containing 24 plates, one for each outside diameter: 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 38, 46, 60, 80, 100, 150, and 200 mm.

The models print upright without supports. PLA is recommended for general use. For fitted parts, print a small test first and compensate for your printer's dimensional tolerance. At the smallest sizes, use a clean build plate and reduce print speed if needed.
```

### 詳細 — 日本語版（内容確認用・入力しない）

```text
MakerWorldのモデルページにある「カスタマイズ」ボタンから、OpenSCADをインストールせずに円柱を生成できます。外径と全高を独立指定し、`Hollow`を有効にすると肉厚を指定できる中央貫通穴を追加できます。上面は`Top Surface Style`で「ドーム状（ソリッドのみ）」か「上端エッジのみ丸める」かを選べ、下端は上面の設定と独立して丸められます。

既定値は中身の詰まった円柱です。`Hollow`はボディの高さ分だけ中央に穴を追加します。ドーム状は中空とは併用できません。空洞の上にドームを載せると、印刷後に除去できない未サポートの橋渡しが空洞内部に必要になるためです。そのため`Hollow`が有効な場合は`Top Surface Style`の指定に関わらず常に上端エッジ丸め扱いになります。壁やフィレットが消失するような寸法は自動制限され、外径と全高は常に全体寸法として維持されます。

すぐに印刷できる5種類のサンプルデザインを収録しています。
- Design A: 高さが外径の12%の基本円柱
- Design B: 上下の外周エッジをはっきり丸めたソリッド円柱（丸みの半径は外径の10%）
- Design C: 高さが外径の50%、肉厚が10%のフラットな中空円柱（リング）
- Design D: 上下の外周エッジをはっきり丸めた中空円柱（丸みを見せるため肉厚を増加）
- Design E: 上面をカプセルのようなドーム状にしたソリッド円柱

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
| Design E | `Design E - Domed Solid Cylinder - 24 Sizes` | `design-E-render.png` |

各プロファイルの説明には、対応する英語版詳細のDesign行、24プレートであること、共通印刷設定、嵌合用途ではテスト印刷が必要であることを記載する。

### プレート対応

各3MFは次の順序で24プレートを収録する。

| No. | サイズ | Design A | Design B | Design C | Design D | Design E |
| ---: | ---: | --- | --- | --- | --- | --- |
| 1 | 3 mm | `Design_A_3mm` | `Design_B_3mm` | `Design_C_3mm` | `Design_D_3mm` | `Design_E_3mm` |
| 2 | 4 mm | `Design_A_4mm` | `Design_B_4mm` | `Design_C_4mm` | `Design_D_4mm` | `Design_E_4mm` |
| 3 | 5 mm | `Design_A_5mm` | `Design_B_5mm` | `Design_C_5mm` | `Design_D_5mm` | `Design_E_5mm` |
| 4 | 6 mm | `Design_A_6mm` | `Design_B_6mm` | `Design_C_6mm` | `Design_D_6mm` | `Design_E_6mm` |
| 5 | 7 mm | `Design_A_7mm` | `Design_B_7mm` | `Design_C_7mm` | `Design_D_7mm` | `Design_E_7mm` |
| 6 | 8 mm | `Design_A_8mm` | `Design_B_8mm` | `Design_C_8mm` | `Design_D_8mm` | `Design_E_8mm` |
| 7 | 9 mm | `Design_A_9mm` | `Design_B_9mm` | `Design_C_9mm` | `Design_D_9mm` | `Design_E_9mm` |
| 8 | 10 mm | `Design_A_10mm` | `Design_B_10mm` | `Design_C_10mm` | `Design_D_10mm` | `Design_E_10mm` |
| 9 | 11 mm | `Design_A_11mm` | `Design_B_11mm` | `Design_C_11mm` | `Design_D_11mm` | `Design_E_11mm` |
| 10 | 12 mm | `Design_A_12mm` | `Design_B_12mm` | `Design_C_12mm` | `Design_D_12mm` | `Design_E_12mm` |
| 11 | 14 mm | `Design_A_14mm` | `Design_B_14mm` | `Design_C_14mm` | `Design_D_14mm` | `Design_E_14mm` |
| 12 | 16 mm | `Design_A_16mm` | `Design_B_16mm` | `Design_C_16mm` | `Design_D_16mm` | `Design_E_16mm` |
| 13 | 18 mm | `Design_A_18mm` | `Design_B_18mm` | `Design_C_18mm` | `Design_D_18mm` | `Design_E_18mm` |
| 14 | 20 mm | `Design_A_20mm` | `Design_B_20mm` | `Design_C_20mm` | `Design_D_20mm` | `Design_E_20mm` |
| 15 | 24 mm | `Design_A_24mm` | `Design_B_24mm` | `Design_C_24mm` | `Design_D_24mm` | `Design_E_24mm` |
| 16 | 28 mm | `Design_A_28mm` | `Design_B_28mm` | `Design_C_28mm` | `Design_D_28mm` | `Design_E_28mm` |
| 17 | 32 mm | `Design_A_32mm` | `Design_B_32mm` | `Design_C_32mm` | `Design_D_32mm` | `Design_E_32mm` |
| 18 | 38 mm | `Design_A_38mm` | `Design_B_38mm` | `Design_C_38mm` | `Design_D_38mm` | `Design_E_38mm` |
| 19 | 46 mm | `Design_A_46mm` | `Design_B_46mm` | `Design_C_46mm` | `Design_D_46mm` | `Design_E_46mm` |
| 20 | 60 mm | `Design_A_60mm` | `Design_B_60mm` | `Design_C_60mm` | `Design_D_60mm` | `Design_E_60mm` |
| 21 | 80 mm | `Design_A_80mm` | `Design_B_80mm` | `Design_C_80mm` | `Design_D_80mm` | `Design_E_80mm` |
| 22 | 100 mm | `Design_A_100mm` | `Design_B_100mm` | `Design_C_100mm` | `Design_D_100mm` | `Design_E_100mm` |
| 23 | 150 mm | `Design_A_150mm` | `Design_B_150mm` | `Design_C_150mm` | `Design_D_150mm` | `Design_E_150mm` |
| 24 | 200 mm | `Design_A_200mm` | `Design_B_200mm` | `Design_C_200mm` | `Design_D_200mm` | `Design_E_200mm` |

## 4. 公開前チェック

- [ ] ライセンスとMW限定モデルプログラムを決定した
- [ ] MakerWorldの実画面でカテゴリを選択した
- [x] モデル名50文字以内、全プロファイル名60文字以内
- [x] タグがASCII文字のみ
- [x] Customizer用SCADと125プリセットのJSONを用意した
- [x] 5つの3MFが有効な3MF構造で、各24プレートを収録している（`build_bambulab_3mf.py`で再生成、125個のSTLから構築）
- [x] 5つの3MF（Design A〜E）とデモ3MFをBambu Studioで実際に開き、印刷設定（Bambu Lab H2C認識）とプレート形状を目視確認した（2026-08-24、ヘッドレスBambu Studioでスクリーンショット確認）
- [ ] SCADをMakerWorld Customizerへ読み込み、パラメーター表示と生成を確認した
- [ ] 5つの3MFをBambu Studioでスライスまで実行できることを最終確認した（読み込み・表示は確認済みだがスライス実行は未確認）
- [ ] 3 mm、50 mm、200 mmを含む代表サイズを実機印刷した
- [ ] 公開用の実物写真を用意した（同梱レンダーは形状確認用）
- [ ] 公開後のMakerWorld URLを管理情報へ記録した
