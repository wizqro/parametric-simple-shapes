# Parametric SCAD Models

複数のOpenSCADモデルを、共通スクリプトでSTLおよびBambu Lab互換3MFへ変換するプロジェクトです。

## ディレクトリ構成

```text
scad/                       OpenSCADモデル
  parametric_cylinder.scad
  parametric_heart.scad
  parametric_star.scad
presets/                    モデルごとのOpenSCADプリセット
  parametric_cylinder.json
  parametric_heart.json
  parametric_star.json
templates/                  Bambu Studioプロジェクト設定テンプレート
  bambu_h2c_0.2mm_project_template.3mf
output/                     生成物（Git管理対象外）
  stl/<モデル名>/
  3mf/<モデル名>/
  previews/<モデル名>/
```

`scad/<モデル名>.scad` と `presets/<モデル名>.json` は同じモデル名で対応させます。
生成する3MFは、同梱テンプレートによりBambu Lab H2C（0.4mmノズル、0.2mm積層、330×320mmプレート）用のプロジェクト設定と座標系を使用します。

## 必要なソフトウェア

- Python 3.14（Pythonコードは標準ライブラリのみ使用）
- OpenSCAD（`openscad`コマンドがPATHに含まれていること）
- Windows PowerShell

## Python環境のセットアップ

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

## 生成方法

`parametric_heart`は既定モデルなので、引数なしで生成できます。

```powershell
powershell -ExecutionPolicy Bypass -File .\render_all_presets.ps1
powershell -ExecutionPolicy Bypass -File .\build_all_bambulab_3mf.ps1
```

### Heartの上面スタイル

MakerWorld Customizerの`Top Surface Style`で次の方式を選択できます。

- `Domed Surface`: 従来方式。`Surface Thickness`で面全体の盛り上がりを設定します。
- `Top Edge Fillet`: 上面中央を平らに保ち、上面外周だけを`Top Edge Fillet Radius`で丸めます。

プリセットには比較用の`Demo_Domed_50mm`と`Demo_Top_Edge_Fillet_50mm`も含まれています。
`Design_D_*`は`Design_A_*`と同じ寸法設定で、上面だけをハートサイズの4%半径の`Top Edge Fillet`にしたシリーズです。

### Starのデザイン

StarもHeartと同じ24サイズ×4デザインを収録しています。

- `Design_A_*`: シャープな輪郭のフラットトップ
- `Design_B_*`: 外側の5つの先端を丸めたフラットトップ
- `Design_C_*`: 参照デザイン。中心の頂点へ10枚の平面ファセットが集まる立体上面
- `Design_D_*`: Inner Radius 50%、フラットな中央、Star Sizeの8%半径のTop Edge Fillet、8%の先端角丸

プリセットJSONを再生成する場合は次を実行します。

```powershell
.\.venv\Scripts\python.exe .\generate_star_presets.py
```

StarのSTL・3MF生成ではモデル名を指定します。

```powershell
powershell -ExecutionPolicy Bypass -File .\render_all_presets.ps1 -ModelName parametric_star
powershell -ExecutionPolicy Bypass -File .\build_all_bambulab_3mf.ps1 -ModelName parametric_star
```

MakerWorldへのアップロード用ファイルと掲載文面は`.makerworld/parametric-star/`にまとめています。

### Cylinderのデザイン

Cylinderは中身の詰まった円柱が基本です。直径・高さを独立指定でき、必要な場合だけ`Hollow`を有効にして中央を貫通させられます。上面は`Top Surface Style`で「ドーム状」か「上端エッジのみ丸める」かを選べ、下端は独立して丸められます。`Hollow`が有効な場合、`Top Surface Style`の指定に関わらず常に上端エッジ丸め扱いになります（ドーム状にすると空洞の上に未サポートの橋渡しができてしまい、内部に閉じ込められて除去できないサポートが必要になるため、印刷不可）。

- `Design_A_*`: フラットな基本円柱
- `Design_B_*`: 上下の外周エッジを丸めた円柱（エッジ半径は直径の10%とはっきり分かるサイズ）
- `Design_C_*`: フラットな中空円柱
- `Design_D_*`: 上下の外周エッジを丸めた中空円柱（肉厚を増やして丸みをはっきり見せる）
- `Design_E_*`: 上面をドーム状にしたソリッド円柱（ハートのドーム表現に準拠。中空版は印刷不可のため用意していない）

24サイズ×5デザインに加えて、50 mmの確認用プリセットを5種類収録しています。プリセットJSONの再生成とSTL・3MF生成は次のとおりです。

```powershell
.\.venv\Scripts\python.exe .\generate_cylinder_presets.py
powershell -ExecutionPolicy Bypass -File .\render_all_presets.ps1 -ModelName parametric_cylinder
powershell -ExecutionPolicy Bypass -File .\build_all_bambulab_3mf.ps1 -ModelName parametric_cylinder -GroupMode prefix
```

MakerWorldへのアップロード用ファイルと掲載文面は`.makerworld/parametric-cylinder/`にまとめています。

さらに別のモデル（例：`moon`）を追加するには、次の2ファイルを用意してください。

1. `scad/moon.scad`
2. `presets/moon.json`

プリセットJSONの`parameterSets`内のキーは、対応するSCADファイルの変数名と一致させます。
