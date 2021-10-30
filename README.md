# ミニノート公開用リポジトリ
2021年9月から自身の数学に関する事柄を1つのノート（以下soujiノートとよぶ）に集約することにしました。
これは博士課程終了時に公開しようと思っています。
特徴として、
soujiノートは勉強メモや勉強会用ノート、研究ノートや雑多な記事などが集まってかなり大きなファイルになっています。
また公開前に部分的に公開したいものもあるため、
それについてはsoujiノートの公開したい部分だけを分割して公開しようと考えました。
よってこのリポジトリには、
公開したい部分的なノートをフォルダに分けて、
その中にPDFとして配置しています。

## フォルダ構成
このリポジトリ直下には、そのノートの名前になっているフォルダと「tool」フォルダ、そして複数のbatファイルがあります。

### tool
ここにはミニノートのためのツールがあり、すべてPerlにて書かれています。

#### common_subroutines.pm
下記のツールの共通関数ライブラリ。
今のところ、設定ファイルで指定したフォルダの直下のtool以外のフォルダのリストを作る関数のみ。

#### make_all_note_bat.pl
設定ファイルで指定したフォルダ直下のtool以外のフォルダ、
つまりノート名が記されたフォルダの全てにnote.texをコンパイルするバッチファイル（note.bat）を作成する。
そのバッチファイルはLaTeXの一定の処理のあと、できあがったnote.pdfをそのフォルダ名にリネームする。

#### make_all_run_bat.pl
設定ファイルで指定したフォルダ直下に「全てのbatを実行する.bat」を作成する。
これはそのフォルダ直下の全てのノートフォルダにあるnote.batを並列実行する。
このさい立ち上がった複数のコマンドプロンプト画面に対してちょっとした遊び心を入れてある。

### 一括実行.bat
以下の順序でプログラムやバッチファイルを実行してくれる。

1. tool/make_all_note_bat.pl
1. tool/make_all_run_bat.pl
1. 全てのbatを実行する.bat

これを実行すれば、すべてのミニノートが出来上がる。

### 上記以外のフォルダ
上記以外のフォルダが実際のミニノートが配置されているフォルダになっていて、
その中にその名前でPDFファイルが入っています。
それと、ここにはないsoujiノートのソースファイルを呼ぶ出すだけのnote.texと、
それをコンパイルするnote.batが配置されています。
