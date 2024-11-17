# MySQLの学習メモ

Markdown記述にてメモし、MkDocsにてビルドしてドキュメントを制作し、今後インターネット上から参照できるようにS3へアップロードしてきます。

以下、手順で作成

- []()

## 記事作成



https://www.mikuro.works/shuji/study_notes/MySQL/

## ドキュメント参照方法

このフォルダ内の`site`フォルダ内の`index.html`をブラウザで読み込んでください。



## AWSへデプロイ方法

公式サイトにGitHub Pages, GitLab Pages, Firebase Hosting, VPS, Netlify, AWS Amplifyへのデプロイ方法は記載があります。

https://docsify.js.org/#/deploy

僕はAWSのS3にデプロイしたかったので、以下がその方法です。
（CloudFront + S3 の静的サイトホスティング環境がある前提）
といっても大したことはしておらず、同期するだけです。

# 1. docsをS3に同期
aws s3 sync --delete $PWD/docs s3://my-service-docs

# 2. CloudFrontのキャッシュをinvalidate
aws cloudfront create-invalidation --distribution-id $DOCS_DISTRIBUTION_ID --paths "/*"




## 記述環境構築

以下、修正などで記述環境を構築する際に必要なPythonパッケージです。

- [MkDocs](https://www.mkdocs.org/)
- [Ivory theme for MkDocs](https://github.com/daizutabi/mkdocs-ivory)
- [Pygments](https://pygments.org/)

### MkDocsのインストール

```zsh
% pip install mkdocs

```

### テーマのインストール

```zsh
% pip install mkdocs-ivory
```

### シンタックスハイライト

```zsh
% pip install pygments
```
