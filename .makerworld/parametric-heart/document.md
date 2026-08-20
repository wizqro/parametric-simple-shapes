# MakerWorld アップロード情報 — Parametric Heart

MakerWorld のアップロード画面で入力する内容の下書き・記録用メモ。
`[要確認]` は公開前に MakerWorld の実画面または実機で確認する。

## 0. 管理情報

| 項目 | 内容 |
| --- | --- |
| モデル／プロジェクト名 | `Parametric Heart` |
| MakerWorld URL | 未公開 |
| 公開ステータス | 下書き |
| 最終更新日 | 2026-08-12 |
| 更新メモ | SCADを非オープンソースに確定し、詳細説明にBambu Handy向けの公開背景を追加 |

## 1. アップロード (Upload)

### このモデルの Bambu Studio ファイル (.3mf) はありますか？

- 「はい（追加ポイント報酬を獲得）」

### Bambu Studio ファイル（造形プロファイル）

MakerWorld の「カスタマイズ」ボタンから作るモデルがメイン。
以下の3MFは、4種類のデザインサンプルをすぐ印刷できるよう、各デザインについて3〜200 mmの24サイズを1サイズにつき1プレートで収録したもの。

| ファイル名 | 内容 | プレート数 |
| --- | --- | ---: |
| `3mf/parametric-heart-bambu-design_Design_A_part01.3mf` | Design A: flat top / sharp tip | 24 |
| `3mf/parametric-heart-bambu-design_Design_B_part01.3mf` | Design B: flat top / rounded tip | 24 |
| `3mf/parametric-heart-bambu-design_Design_C_part01.3mf` | Design C: domed top / rounded tip | 24 |
| `3mf/parametric-heart-bambu-design_Design_D_part01.3mf` | Design D: flat center / top-edge fillet / sharp tip | 24 |

収録サイズ:
`3` `4` `5` `6` `7` `8` `9` `10` `11` `12` `14` `16` `18` `20` `24` `28` `32` `38` `46` `60` `80` `100` `150` `200` mm

### 生モデルファイル

note 欄は1行のみ（複数行不可）。海外ユーザー向けに英語で入力する。

| ファイル名 | リポジトリ内の場所 | オープンソース | note（英語・1行） |
| --- | --- | --- | --- |
| `parametric_heart.scad` | `scad/parametric_heart.scad` | オフ（非公開） | `Parametric OpenSCAD model used by the MakerWorld Customizer; source access is disabled.` |
| `parametric_heart.json` | `presets/parametric_heart.json` | 該当なし | `OpenSCAD Customizer preset bundle with 98 ready-made variants.` |

`parametric_heart.scad` は MakerWorld のオンラインカスタマイズ機能に使用するが、オープンソースとして公開しない。

個別 STL は `output/stl/parametric_heart/` に98個生成されるが、4つの3MFに印刷用の96バリエーションを収録済み。
個別 STL も生モデルとしてアップロードするかは `[要確認]`。アップロードする場合の共通 note 例:
`Ready-to-print heart preset; see the filename for its design and overall width.`

### このモデルにレーザー＆カット用モデルは含まれていますか？

- 「いいえ」

### アップロードしたモデルは CyberBrick モデルですか？

- 「いいえ」

## 2. 基本情報 (Basic Info)

海外ユーザー向けに、モデル名・タグ・詳細は英語で用意する。

### モデル名 (0/50)

`Customizable Parametric Heart - 4 Designs`（41文字）

### カテゴリ

- 選択カテゴリ: `[要確認: MakerWorld の実画面で選択]`
- 検索候補: `Art` / `Decor` / `Sculptures` / `Other`

### タグ (0/50, 0/100)

タグ入力欄は ASCII 文字のみを受け付けるため、英語ワードで統一する。
文字数上限を超える場合は右側から削る。

`heart` `valentine` `parametric` `customizable` `decoration` `gift` `love` `openscad`

### ライセンス

公開方針がリポジトリ内に明記されていないため、すべて公開前に決定する。

| 設定 | 選択 |
| --- | --- |
| 作品を修正して共有してもよいか | `[要確認]` |
| 商業目的で利用されてもよいか | `[要確認]` |
| 作品・派生物の共有や再配布を許可するか | `[要確認]` |
| 適用ライセンス | `[要確認]` |

### 公開設定

- 「公開」

### 詳細（説明文、リッチテキスト）

実際に MakerWorld へ入力するのは英語版のみ。日本語版は内容確認用で、アップロード画面には入力しない。

#### 英語版（MakerWorld入力用）

```text
Use the Customize button on this MakerWorld model page to generate your own heart without installing OpenSCAD. The online Parametric Model Maker lets you adjust the overall width, body height, top surface style, dome height or top-edge fillet radius, and rounding at the pointed tip.

To customize it, use Customize on the MakerWorld website, adjust the parameters, generate the model, and download it as 3MF or STL. In Bambu Handy, open Customize from the model page and follow the in-app flow to generate and print your version.

I published this model because I wanted an easy way to customize and print hearts in different sizes and shapes directly from Bambu Handy.

The customizable model is the main feature. Four ready-to-print sample design sets are also included so you can quickly try different looks:
- Design A: flat top with a sharp tip
- Design B: flat top with a rounded tip
- Design C: domed top with a rounded tip
- Design D: flat center with a rounded top edge and a sharp tip

Each sample design is provided as a separate 3MF file containing 24 plates, one for each width: 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 38, 46, 60, 80, 100, 150, and 200 mm. Simply select the plate for the size you want to print.

The smaller sizes work well as decorative heart flakes and can also be used in resin craft projects. Larger sizes are suitable for Valentine's Day decorations, gifts, displays, and other craft projects.
```

#### 日本語版（内容確認用・入力しない）

```text
MakerWorldのモデルページにある「カスタマイズ」ボタンから、OpenSCADをインストールせずに自分好みのハートを生成できます。オンラインのParametric Model Makerで、全体幅、本体の高さ、上面のスタイル、ドームの高さまたは上面外周の角丸半径、下側の先端の丸みを調整できます。

カスタマイズする場合、PCのMakerWorld Web版では「Customize」からパラメーターを調整してモデルを生成し、3MFまたはSTLをダウンロードします。スマートフォンのBambu Handyでは、モデルページの「Customize」を開き、アプリ内の案内に沿って生成・印刷します。

Bambu Handyから、必要なサイズや形のハートを手軽にカスタマイズして印刷したくて、このモデルを公開しました。

このモデルのメイン機能はカスタマイズです。異なる見た目をすぐに試せるよう、以下の4種類の印刷用サンプルデザインも収録しています。
- Design A: 平らな上面とシャープな先端
- Design B: 平らな上面と丸みのある先端
- Design C: ドーム状の上面と丸みのある先端
- Design D: 中央が平らで、上面外周のみを丸めた形状とシャープな先端

各サンプルデザインは個別の3MFファイルになっており、全体幅3、4、5、6、7、8、9、10、11、12、14、16、18、20、24、28、32、38、46、60、80、100、150、200 mmの24プレートを収録しています。印刷したいサイズのプレートを選択してください。

小さいサイズは装飾用のハートフレークとして使いやすく、レジン工作にも利用できます。大きいサイズはバレンタインの飾り、プレゼント、ディスプレイなどの工作に適しています。
```

### Boost Me

詳細説明の末尾に `Boost Me` を挿入する。

- ボタン名: `Boost Me`
- メッセージ文字数: 222/500

#### 英語版（MakerWorld入力用）

```text
If you enjoyed customizing this heart, please consider giving it a Boost! Your support helps me improve this model, add new parametric designs, and keep sharing customizable models with the MakerWorld community. Thank you!
```

#### 日本語版（内容確認用・入力しない）

```text
このハートのカスタマイズを楽しんでいただけたら、ぜひBoostで応援してください。いただいた応援は、このモデルの改善、新しいパラメトリックデザインの追加、MakerWorldコミュニティへのカスタマイズ可能なモデルの公開を続ける励みになります。ありがとうございます！
```

### コミュニティ投稿

- トグルはオフのまま
- 投稿する場合は、バレンタイン用途と4デザインの比較写真を使う

### ドキュメント

- 追加なし
- 単一パーツで組み立て手順は不要。カスタマイズ方法は詳細欄に記載済み

### MW 限定モデルプログラム

- `[要確認: MakerWorld の表示に従う]`

### 部品表 (BOM)

- トグルはオフ
- 購入部品なし

## 3. 造形プロファイルの詳細 (Print Profile Details)

### 共通の印刷設定

3MF 内の設定から確認済み。

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

### プロファイル名 (0/60)

| 3MF | プロファイル名 | 文字数 |
| --- | --- | ---: |
| Design A | `Design A - Flat Top & Sharp Tip - 24 Sizes` | 42 |
| Design B | `Design B - Flat Top & Rounded Tip - 24 Sizes` | 44 |
| Design C | `Design C - Domed Top & Rounded Tip - 24 Sizes` | 45 |
| Design D | `Design D - Flat Center, Rounded Edge, Sharp Tip - 24 Sizes` | 58 |

### プロファイル画像

- 使用候補: `parametric_heart.png`
- 状態: 実物写真を使った比較画像
- `[要確認]` Design A〜Dの対応が初見で分かるラベル入り画像を各プロファイルに設定する
- `スクリーンショット 2026-08-11 190847.png` は Bambu Studio の画面確認用で、公開画像には実物写真を優先する

### プロファイル説明

実際に MakerWorld へ入力するのは各プロファイルの英語版のみ。日本語版は内容確認用で入力しない。

#### Design A — Flat Top & Sharp Tip

英語版（MakerWorld入力用）:

```text
Design A has a flat top and a sharp pointed tip. This sample 3MF contains 24 plates covering overall widths from 3 mm to 200 mm. Each plate contains one heart at a different size; simply select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. The project is configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic.

PLA is recommended. Very small hearts may print more reliably at a slower speed and can be used as decorative flakes in resin craft projects. Check first-layer adhesion carefully.
```

日本語版（内容確認用・入力しない）:

```text
Design Aは、平らな上面とシャープな先端を持つデザインです。このサンプル3MFには、全体幅3〜200 mmの24プレートが入っています。各プレートには異なるサイズのハートが1個ずつ入っているため、印刷したいプレートを選択してください。

積層ピッチ0.2 mm、壁2周、グリッドインフィル15%、サポートなし。Bambu Lab H2C、0.4 mmノズル、Bambu PLA Basic用に設定しています。

材料にはPLAを推奨します。極小サイズは印刷速度を落とすと安定しやすく、レジン工作用の装飾フレークとしても利用できます。ファーストレイヤーの定着を十分に確認してください。
```

#### Design B — Flat Top & Rounded Tip

英語版（MakerWorld入力用）:

```text
Design B has a flat top and a smoothly rounded tip. This sample 3MF contains 24 plates covering overall widths from 3 mm to 200 mm. Each plate contains one heart at a different size; simply select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. The project is configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic.

PLA is recommended. Very small hearts may print more reliably at a slower speed and can be used as decorative flakes in resin craft projects. Check first-layer adhesion carefully.
```

日本語版（内容確認用・入力しない）:

```text
Design Bは、平らな上面と滑らかに丸めた先端を持つデザインです。このサンプル3MFには、全体幅3〜200 mmの24プレートが入っています。各プレートには異なるサイズのハートが1個ずつ入っているため、印刷したいプレートを選択してください。

積層ピッチ0.2 mm、壁2周、グリッドインフィル15%、サポートなし。Bambu Lab H2C、0.4 mmノズル、Bambu PLA Basic用に設定しています。

材料にはPLAを推奨します。極小サイズは印刷速度を落とすと安定しやすく、レジン工作用の装飾フレークとしても利用できます。ファーストレイヤーの定着を十分に確認してください。
```

#### Design C — Domed Top & Rounded Tip

英語版（MakerWorld入力用）:

```text
Design C has a fully domed top and a rounded tip. This sample 3MF contains 24 plates covering overall widths from 3 mm to 200 mm. Each plate contains one heart at a different size; simply select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. The project is configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic.

PLA is recommended. Very small hearts may print more reliably at a slower speed and can be used as decorative flakes in resin craft projects. Check first-layer adhesion carefully.
```

日本語版（内容確認用・入力しない）:

```text
Design Cは、全面がドーム状の上面と丸みのある先端を持つデザインです。このサンプル3MFには、全体幅3〜200 mmの24プレートが入っています。各プレートには異なるサイズのハートが1個ずつ入っているため、印刷したいプレートを選択してください。

積層ピッチ0.2 mm、壁2周、グリッドインフィル15%、サポートなし。Bambu Lab H2C、0.4 mmノズル、Bambu PLA Basic用に設定しています。

材料にはPLAを推奨します。極小サイズは印刷速度を落とすと安定しやすく、レジン工作用の装飾フレークとしても利用できます。ファーストレイヤーの定着を十分に確認してください。
```

#### Design D — Flat Center, Rounded Edge & Sharp Tip

英語版（MakerWorld入力用）:

```text
Design D keeps the center flat, rounds only the upper perimeter, and retains a sharp pointed tip. This sample 3MF contains 24 plates covering overall widths from 3 mm to 200 mm. Each plate contains one heart at a different size; simply select the plate you want to print.

0.2 mm layer height, 2 perimeter walls, 15% grid infill, and no supports. The project is configured for a Bambu Lab H2C with a 0.4 mm nozzle and Bambu PLA Basic.

PLA is recommended. Very small hearts may print more reliably at a slower speed and can be used as decorative flakes in resin craft projects. Check first-layer adhesion carefully.
```

日本語版（内容確認用・入力しない）:

```text
Design Dは、中央を平らに保ちながら上面外周のみを丸め、先端をシャープに仕上げたデザインです。このサンプル3MFには、全体幅3〜200 mmの24プレートが入っています。各プレートには異なるサイズのハートが1個ずつ入っているため、印刷したいプレートを選択してください。

積層ピッチ0.2 mm、壁2周、グリッドインフィル15%、サポートなし。Bambu Lab H2C、0.4 mmノズル、Bambu PLA Basic用に設定しています。

材料にはPLAを推奨します。極小サイズは印刷速度を落とすと安定しやすく、レジン工作用の装飾フレークとしても利用できます。ファーストレイヤーの定着を十分に確認してください。
```

### プリンター互換性チェック

- 3MF の設定対象: `Bambu Lab H2C / 0.4 mm nozzle`
- `[要確認]` 他機種にも公開する場合は、ビルドプレート寸法とプリンタープリセットを機種ごとに確認する

### プレート

各3MFは24プレート。プレート名は生モデルのプリセット名と一致している。

| No. | 幅 | Design A | Design B | Design C | Design D |
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

- [ ] `[要確認]` 項目をすべて決定した
- [x] モデル名が50文字以内、プロファイル名が60文字以内
- [ ] タグが ASCII 文字のみで、文字数上限内
- [ ] `parametric_heart.scad` と `parametric_heart.json` をアップロード用フォルダへ用意した
- [ ] SCADファイルの MakerWorld Customizer 動作を確認した
- [x] 4つの3MFが有効な3MF構造で、各24プレートを収録している
- [ ] 4つの3MFを Bambu Studio で開き、スライスできることを最終確認した
- [x] プレート順・プレート名・プリセットの対応を確認した
- [ ] 3 mmなど極小サイズの実機印刷結果を確認した
- [ ] 150 mm・200 mmサイズの実機印刷結果とベッド収まりを確認した
- [ ] Design A〜Dの違いが分かる公開画像を用意した
- [ ] 説明文の寸法、数量、表面スタイルが実ファイルと一致することを最終確認した
- [x] SCADのオープンソース設定をオフ（非公開）にした
- [ ] モデルのライセンスを決定した
- [ ] カテゴリ、公開設定、MW限定モデル、BOMを確認した
- [ ] 公開後の MakerWorld URL と更新日を「管理情報」に記録した
