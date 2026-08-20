# MakerWorld アップロード情報 — Parametric Star

MakerWorld のアップロード画面で入力する内容と、アップロード対象ファイルの管理メモ。
`[要確認]` は公開前に MakerWorld の実画面または実機で確認する。

## 0. 管理情報

| 項目 | 内容 |
| --- | --- |
| モデル／プロジェクト名 | `Parametric Star` |
| MakerWorld URL | 未公開 |
| 公開ステータス | 下書き |
| 最終更新日 | 2026-08-12 |
| 更新メモ | Customizer用SCAD/JSON、4デザイン×24サイズの3MF、掲載文面、確認用レンダーを作成 |

## 1. アップロード

### Bambu Studio ファイル

「このモデルの Bambu Studio ファイル (.3mf) はありますか？」は「はい」を選択する。
MakerWorld の「カスタマイズ」ボタンから作るモデルがメイン。以下の3MFは、4種類のサンプルをすぐ印刷できるよう、各デザインについて3〜200 mmの24サイズを1サイズにつき1プレートで収録している。

| ファイル名 | 内容 | プレート数 |
| --- | --- | ---: |
| `3mf/parametric-star-bambu_Design_A_part01.3mf` | Design A: flat top / sharp points | 24 |
| `3mf/parametric-star-bambu_Design_B_part01.3mf` | Design B: flat top / rounded points | 24 |
| `3mf/parametric-star-bambu_Design_C_part01.3mf` | Design C: faceted apex / sharp points | 24 |
| `3mf/parametric-star-bambu_Design_D_part01.3mf` | Design D: flat center / strong top-edge fillet / rounded points | 24 |

収録サイズ:
`3` `4` `5` `6` `7` `8` `9` `10` `11` `12` `14` `16` `18` `20` `24` `28` `32` `38` `46` `60` `80` `100` `150` `200` mm

### 生モデルファイル

note欄は1行のみ。以下をそのまま入力する。

| ファイル名 | オープンソース | note（英語・1行） |
| --- | --- | --- |
| `parametric_star.scad` | オフ（非公開） | `Parametric OpenSCAD model used by the MakerWorld Customizer; source access is disabled.` |
| `parametric_star.json` | 該当なし | `OpenSCAD Customizer preset bundle with 98 ready-made variants.` |

`parametric_star.scad` はオンラインカスタマイズに使用するが、オープンソースとして公開しない方針。個別STLは3MFと内容が重複するため、通常はアップロード不要。

- レーザー＆カット用モデル: 「いいえ」
- CyberBrickモデル: 「いいえ」

## 2. 基本情報

### モデル名

`Customizable Parametric Star - 4 Designs`（40文字）

### カテゴリ

- 選択カテゴリ: `[要確認: MakerWorld の実画面で Art / Decor / Other に近い分類を選択]`
- 検索候補: `Art` / `Decor` / `Sculptures` / `Other`

### タグ

`star` `parametric` `customizable` `decoration` `craft` `ornament` `openscad` `makerworld`

### ライセンス

公開方針がリポジトリ内に明記されていないため、公開者が最終決定する。

| 設定 | 選択 |
| --- | --- |
| 作品を修正して共有してもよいか | `[要確認]` |
| 商業目的で利用されてもよいか | `[要確認]` |
| 作品・派生物の共有や再配布を許可するか | `[要確認]` |
| 適用ライセンス | `[要確認]` |

### 公開設定

- 「公開」
- コミュニティ投稿: オフ
- ドキュメント: 追加なし（単一パーツで組み立て不要）
- MW限定モデルプログラム: `[要確認]`
- BOM: オフ（購入部品なし）

### 詳細 — 英語版（MakerWorld入力用）

```text
Use the Customize button on this MakerWorld model page to generate your own five-point star without installing OpenSCAD. The online Parametric Model Maker lets you adjust the overall tip-to-tip size, inner valley radius, body height, top surface style, apex height or top-edge fillet radius, and point rounding.

To customize it, open Customize on the MakerWorld website, adjust the parameters, generate the model, and download it as 3MF or STL. In Bambu Handy, open Customize from the model page and follow the in-app flow to generate and print your version.

The customizable model is the main feature. Four ready-to-print sample design sets are also included:
- Design A: flat top with sharp points
- Design B: flat top with smoothly rounded points
- Design C: ten planar facets meeting at a raised center apex
- Design D: 50% inner radius, flat center, 8% top-edge fillet, and 8% rounded points

Each sample design is provided as a separate 3MF file containing 24 plates, one for each overall size: 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 38, 46, 60, 80, 100, 150, and 200 mm. Select the plate for the size you want to print.

Small stars work well as decorative flakes, confetti-like craft pieces, and resin craft inclusions. Larger stars are suitable for ornaments, wall decorations, displays, gifts, and other craft projects.

The models print flat on the build plate and do not require supports. PLA is recommended. For very small sizes, use a clean build plate, verify first-layer adhesion, and reduce print speed if necessary.
```

### 詳細 — 日本語版（内容確認用・入力しない）

```text
MakerWorldのモデルページにある「カスタマイズ」ボタンから、OpenSCADをインストールせずに五芒星を生成できます。オンラインのParametric Model Makerで、先端間の全体サイズ、谷部分の半径、本体の高さ、上面スタイル、頂点の高さまたは上面外周の角丸半径、星の先端の丸みを調整できます。

カスタマイズする場合、MakerWorld Web版では「Customize」からパラメーターを調整してモデルを生成し、3MFまたはSTLをダウンロードします。Bambu Handyでは、モデルページの「Customize」を開き、アプリ内の案内に沿って生成・印刷します。

カスタマイズ機能に加え、すぐに印刷できる4種類のサンプルデザインを収録しています。
- Design A: 平らな上面とシャープな先端
- Design B: 平らな上面と丸みのある先端
- Design C: 中央の高い頂点へ10枚の平面ファセットが集まる上面
- Design D: Inner Radius 50%、中央が平ら、8%の上面外周フィレット、8%の先端角丸

各デザインの3MFには、全体サイズ3〜200 mmの24プレートが入っています。印刷したいサイズのプレートを選択してください。小さい星は装飾用フレークやレジン工作の封入素材に、大きい星はオーナメント、壁飾り、ディスプレイ、プレゼントなどに利用できます。
```

### Boost Me

```text
If you enjoyed customizing this star, please consider giving it a Boost! Your support helps me improve this model, add new parametric designs, and keep sharing customizable models with the MakerWorld community. Thank you!
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

| 3MF | プロファイル名 | 文字数 | 画像候補 |
| --- | --- | ---: | --- |
| Design A | `Design A - Flat Top & Sharp Points - 24 Sizes` | 45 | `design-A-render.png` |
| Design B | `Design B - Flat Top & Rounded Points - 24 Sizes` | 47 | `design-B-render.png` |
| Design C | `Design C - Faceted Apex & Sharp Points - 24 Sizes` | 49 | `design-C-render.png` |
| Design D | `Design D - Flat Center, Rounded Edge - 24 Sizes` | 47 | `design-D-render.png` |

レンダーは形状確認用として使用できる。公開時は、Design A〜Dの対応が分かるラベル入りの実物写真へ差し替えることを推奨する。

### プロファイル説明

Design A:

```text
Design A has a flat top and sharp star points. This 3MF contains 24 plates covering overall sizes from 3 mm to 200 mm. Each plate contains one star at a different size; select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. Configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic. PLA is recommended. For very small stars, reduce print speed and check first-layer adhesion carefully.
```

Design B:

```text
Design B has a flat top and smoothly rounded star points. This 3MF contains 24 plates covering overall sizes from 3 mm to 200 mm. Each plate contains one star at a different size; select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. Configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic. PLA is recommended. For very small stars, reduce print speed and check first-layer adhesion carefully.
```

Design C:

```text
Design C has ten planar top facets meeting at a raised center apex, with a sharp star outline. This 3MF contains 24 plates covering overall sizes from 3 mm to 200 mm. Each plate contains one star at a different size; select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. Configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic. PLA is recommended. For very small stars, reduce print speed and check first-layer adhesion carefully.
```

Design D:

```text
Design D uses a 50% inner radius, keeps the center flat, applies a top-edge fillet equal to 8% of the overall size, and rounds the points by 8%. This 3MF contains 24 plates covering overall sizes from 3 mm to 200 mm. Each plate contains one star at a different size; select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. Configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic. PLA is recommended. For very small stars, reduce print speed and check first-layer adhesion carefully.
```

### プレート対応

各3MFは次の順序で24プレートを収録する。

| No. | サイズ | Design A | Design B | Design C | Design D |
| ---: | ---: | --- | --- | --- | --- |
| 1 | 3 mm | `Design_A_3mm` | `Design_B_3mm` | `Design_C_3mm` | `Design_D_3mm` |
| 2 | 4 mm | `Design_A_4mm` | `Design_B_4mm` | `Design_C_4mm` | `Design_D_4mm` |
| 3 | 5 mm | `Design_A_5mm` | `Design_B_5mm` | `Design_C_5mm` | `Design_D_5mm` |
| 4 | 6 mm | `Design_A_6mm` | `Design_B_6mm` | `Design_C_6mm` | `Design_D_6mm` |
| 5 | 7 mm | `Design_A_7mm` | `Design_B_7mm` | `Design_C_7mm` | `Design_D_7mm` |
| 6 | 8 mm | `Design_A_8mm` | `Design_B_8mm` | `Design_C_8mm` | `Design_D_8mm` |
| 7 | 9 mm | `Design_A_9mm` | `Design_B_9mm` | `Design_C_9mm` | `Design_D_9mm` |
| 8 | 10 mm | `Design_A_10mm` | `Design_B_10mm` | `Design_C_10mm` | `Design_D_10mm` |
| 9 | 11 mm | `Design_A_11mm` | `Design_B_11mm` | `Design_C_11mm` | `Design_D_11mm` |
| 10 | 12 mm | `Design_A_12mm` | `Design_B_12mm` | `Design_C_12mm` | `Design_D_12mm` |
| 11 | 14 mm | `Design_A_14mm` | `Design_B_14mm` | `Design_C_14mm` | `Design_D_14mm` |
| 12 | 16 mm | `Design_A_16mm` | `Design_B_16mm` | `Design_C_16mm` | `Design_D_16mm` |
| 13 | 18 mm | `Design_A_18mm` | `Design_B_18mm` | `Design_C_18mm` | `Design_D_18mm` |
| 14 | 20 mm | `Design_A_20mm` | `Design_B_20mm` | `Design_C_20mm` | `Design_D_20mm` |
| 15 | 24 mm | `Design_A_24mm` | `Design_B_24mm` | `Design_C_24mm` | `Design_D_24mm` |
| 16 | 28 mm | `Design_A_28mm` | `Design_B_28mm` | `Design_C_28mm` | `Design_D_28mm` |
| 17 | 32 mm | `Design_A_32mm` | `Design_B_32mm` | `Design_C_32mm` | `Design_D_32mm` |
| 18 | 38 mm | `Design_A_38mm` | `Design_B_38mm` | `Design_C_38mm` | `Design_D_38mm` |
| 19 | 46 mm | `Design_A_46mm` | `Design_B_46mm` | `Design_C_46mm` | `Design_D_46mm` |
| 20 | 60 mm | `Design_A_60mm` | `Design_B_60mm` | `Design_C_60mm` | `Design_D_60mm` |
| 21 | 80 mm | `Design_A_80mm` | `Design_B_80mm` | `Design_C_80mm` | `Design_D_80mm` |
| 22 | 100 mm | `Design_A_100mm` | `Design_B_100mm` | `Design_C_100mm` | `Design_D_100mm` |
| 23 | 150 mm | `Design_A_150mm` | `Design_B_150mm` | `Design_C_150mm` | `Design_D_150mm` |
| 24 | 200 mm | `Design_A_200mm` | `Design_B_200mm` | `Design_C_200mm` | `Design_D_200mm` |

## 4. 公開前チェック

- [ ] ライセンスとMW限定モデルプログラムを決定した
- [ ] MakerWorldの実画面でカテゴリを選択した
- [x] モデル名50文字以内、全プロファイル名60文字以内
- [x] タグがASCII文字のみ
- [x] Customizer用SCADと98プリセットのJSONを用意した
- [x] 4つの3MFが有効な3MF構造で、各24プレートを収録している
- [x] プレート順、プレート名、プリセットの対応を機械検証した
- [ ] SCADをMakerWorld Customizerへ読み込み、パラメーター表示と生成を確認した
- [ ] 4つの3MFをBambu Studioで開いてスライスできることを最終確認した
- [ ] 3 mm、150 mm、200 mmを含む代表サイズの実機印刷を確認した
- [ ] 公開用の実物写真を用意した（同梱レンダーは形状確認用）
- [ ] 公開後のMakerWorld URLを管理情報へ記録した
