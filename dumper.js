// see also https://blog.mudatobunka.org/entry/2015/12/23/211425

(function(window, document, location) {
  'use strict';

  // 取得したいURLの配列
  const urls = [""]

  urls.forEach(function(item, index, array) {
    setTimeout(function(window,item){
      let page = window.open(item);
      setTimeout(function(page,window, item){
        let snapshot = new XMLSerializer().serializeToString(page.document);
        let a = document.createElement('a');
        a.href = window.URL.createObjectURL(new Blob([snapshot]))
        a.download = decodeURI(item).replace(/\//g,'__').replace(/#/g,'--') + '.html';
        a.click();
        page.close();
      }, 10000, page, window,item); // ページを開いて10秒後に内容を保存
      page.blur();
      window.focus();
    }, index * 3000, window,item); // 3秒おきにページを開く
  })
})(window, document, location);
