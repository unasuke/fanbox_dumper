# fanbox dumper

このリポジトリでは、pixivFANBOXからRe:VIEWによる書籍を作成するまでに使用した様々なscriptを管理しています。

## find_fanbox_article_url.rb
このscriptは、<https://www.pixiv.net/fanbox/manage/post/published>の内容から、pixivFANBOXに投稿した記事のリストをJSONで抽出します。

## dumper.js
このscriptは、URLの配列から数秒の間隔をあけてページを開き、内容を保存して閉じます。Webブラウザのconsoleにペーストして実行します。

## extract.rb
このscriptは、ダウンロードしたpixivFANBOXのHTMLから、記事本文を抽出し、MarkdownとRe:VIEW形式に変換したものをそれぞれ保存します。

## adjust_appearance_text.rb
このscriptは、テキスト形式の投稿をRe:VIEW形式に変換した結果を正規表現を用いて整形します。

## adjust_appearance_blog.rb
このscriptは、ブログ形式の投稿をRe:VIEW形式に変換した結果を正規表現を用いて整形します。
