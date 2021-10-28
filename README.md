## 画面設計。機能設計。データ設計 はgoogle driveに保存。

# インセプションデッキ

## プロジェクトの名前

[instantLearn]

### 名前をつけた理由

- [学び始めるまでの心理的な壁を低くしたいからinstaってつけた]
- [中等教育、高等教育における学びはインプットを指すものが多く、インプットに費やす時間を効率化したいと思ったから]
- [中高生にわかりやすいかなって思ったから、あとダサくない名前じゃないと友達に勧めづらいかなと思ったから]

<div style="page-break-before:always">
</div>

## 1\. 我われはなぜここにいるのか？

1. [インプットに費やす時間を効率化し、]
1. [一人一人の興味関心のある物事に取り組んでほしいから（アウトプット）]
2. [暗記力で成績をつけ周囲と競わせることを強制するのではなく、]
2. [実社会で行われているそれぞれが得意なことを持ち寄る協力体制を矯正する]
3. [行動を促すために]

### プロジェクトの根幹に関わる理由

**[何で自分の興味のないことを学ばなきゃいけないんだよ！！fuck you、　学力だけで選べる進路が制限されるとかちょっとイカれてる]**

<div style="page-break-before:always">
</div>

## 2\. エレベーターピッチ

- [潜在的なニーズを満たしたり、抱えている課題を解決したり]したい
- [中高生]向けの、
- [instantLearn]というプロダクトは、
- [学習効率化ツール]です。
- これは[協力学習、反復学習、視覚化]ができ、
- [AnkiDroid]とは違って、
- [story学習機能、直感的なUI、画像へのテキスト挿入機能、共同学習サポート機能]が備わっています。



<div style="page-break-before:always">
</div>

## 3\. パッケージデザイン

[instaLearn]

![素敵な写真]()

### 最高のキャッチコピー

[1秒だって無駄にできない君に届け]

### ユーザーへのアピール

1. [「全然勉強してないよ？」って言って高得点とるあいつも使ってる]
2. [直感的で馴染み深いUI]
3. [友達と協力して授業の内容やワークをstoryに追加しよう]
4. 協力して宿題を終わらせよう
5. 先生に提出する前にわざと違う所を少し間違えましょう！

<div style="page-break-before:always">
</div>

## 4\. やらないことリスト

カテゴリ   | 項目       | やる / やらない / あとで決める | 理由
------ | -------- | ------------------ | --------------
[機能] | [やること]   | story反復学習機能                | [競争優位性があるから]
[機能] | [やらないこと] | markdown機能               | [コンテンツを作るのがだるいから]
[機能] | [あとで決める] | 協力学習機能             | [データの権限やデータ設計を現段階で決め切ることができないから]
[機能] | [あとで決める] | 通知機能             | [通知するためのコンテンツがないから]

<div style="page-break-before:always">
</div>

## 5\. プロジェクトコミュニティは...

![プロジェクトコミュニティの画像]()

**このプロジェクトに参加したい人！**
**👇のtwitterからDMちょうだい！**
https://twitter.com/neco3coffee


<div style="page-break-before:always">
</div>

## ❓常に自分自身に問いかけよう
❓我々が解決しようと思っている問題に消費者は気づいているか？ 
=>YES ,勉強だるいって言ってるよ
❓解決策があれば消費者はそれを買うか？
=>YES ,現に塾に行ってる人は多いよ
❓我々から買ってくれるか？
=>No ,そもそも認知されてないよ
❓その問題の解決策を我々は用意できるか？
=>YES ,必要なパーツは既に先人達によって形作られているよ

## 6\. 技術的な解決策の概要

![概要レベルのアーキテクチャ設計図の画像]()

### 採用する技術

- [プログラミング言語]
- Dart,flutter
- [ライブラリ]
- flutter
- get
- firebase_core
- firebase_auth
- cloud_firestore
- firebase_storage
- story_view
- image_editor_pro(image_picker,screenshot,zoom_widget,
- dev-----
- flutter_launcher_icons
- [ツール]
- 
- [その他の要素技術]
- 

<div style="page-break-before:always">
</div>

## 7\. 夜も眠れなくなるような問題は何だろう？

- [もし起きたらこわーいこと、その1]
- センシティブな写真がアップロードされる
- [もし起きたらこわーいこと、その2]
- マーケティングで負けること
- [もし起きたらこわーいこと、その3]
- コスト　＞　利益
- [もし起きたらこわーいこと、その4]
- 既存にあるからと諦めて、途中で投げ出すこと
- [もし起きたらこわーいこと、その５]
- 精神的に落ちて、開発を継続できないこと
<div style="page-break-before:always">
</div>

## 8\. 期間を見極める

![ざっくりしたタイムラインの画像]()
### 2021/10/31/15:00までにリリース申請を行う。

**あくまで推測であって、確約するものではありません。**

<div style="page-break-before:always">
</div>

## 9\. トレードオフ・スライダー

### 典型的なフォース

|  max  |  >>>  |  >>>  |  >>>  |  min  | 項目                       |
| :---: | :---: | :---: | :---: | :---: | :------------------------ |
|   o   |       |       |       |       |  期日10/31リリースを死守する（時間）|
|       |   o   |       |       |       |  MVPをロケットスタートで形作る⌛️2割10/28、8割10/31  |
|       |       |   o   |       |       |  コスト、N1+だけ対応     |
|       |       |       |   o   |       |  高い品質、少ない欠陥（品質）  |

### 上記以外で重要なこと

|  max  |  >>>  |  >>>  |  >>>  |  min  | 項目                       |
| :---: | :---: | :---: | :---: | :---: | :------------------------ |
|   o   |       |       |       |       |  シンプルで直感的なUI                   |
|       |   o   |       |       |       |  ユーザー導線         |
|       |       |   o   |       |       |  価値観の教育、不満に訴える or 潜在的な不満を認知させる              |
|       |       |       |   o   |       |                   |

<div style="page-break-before:always">
</div>

## 10\. 何がどれだけ必要なのか

要素 | 値
--- | -----
人数 | １名
期間 | 3日
予算 | 2687¥(starbucks cardの残額)

### 俺たちのチーム(1人３役)

人数  | 役割     | 強みや期待すること
---- | ------- | ---------------------------------------------------------
1    | アナリスト | 作った後にいらなくなるようなものを作らないように情報を満遍なく収集し、現実を正しく捉えて、仮説の裏付けまたは否定を行ってほしい
1    | 開発者    | 要件を満たす必要最低限のpackageを素早く選定し、3時間以内に機能を作り上げてほしい。
1  | マネージャ | タスクの難易度の見積もりをし3日をどのように使うのかの判断を3秒以内に決断し続けてほしい。
