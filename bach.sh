#!/bin/zsh

# ビルド生成したものだけ、git管轄のフォルダへ移動
rm -rf /Users/bonji/workspace/www.mikuro.works/shuji/study_notes/MySQL/*
rsync -av site/ /Users/bonji/workspace/www.mikuro.works/shuji/study_notes/MySQL/

# amazon S3 バケットの同期
aws s3 sync  /Users/bonji/workspace/www.mikuro.works/shuji/study_notes/MySQL/ s3://www.mikuro.works/shuji/study_notes/MySQL/

# amazon CloudFront キャッシュをinvalidate
aws cloudfront create-invalidation --distribution-id E1KST3JF0JFTX2 --paths "/shuji/study_notes/MySQL/*"
