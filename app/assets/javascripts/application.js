// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .

// 大カテゴリと小カテゴリを連動する処理
$(function($) {
    // 小カテゴリの要素を変数に入れる
    $children = $('#children');
    // 後のイベントで、不要なoption要素を削除するため、オリジナルを取得しておく
    original = $children.html();

    $children.attr('disabled', 'disabled');

  $('#parent').change(function() {
    //選択された大カテゴリのvalueを取得し変数に入れる
    var val1 = $(this).val();

    //削除された要素をもとに戻すため.html(original)を入れておく
    $children.html(original).find('option').each(
      function() {
      var val2 = $(this).data('val'); //data-valの値を取得

      //valueと異なるdata-valを持つ要素を削除
      if (val1 != val2) {
         $(this).not(':first-child').remove();
      }
    });
    //地方側のselect要素が未選択の場合、都道府県をdisabledにする
    if ($(this).val() == "") {
      $children.attr('disabled', 'disabled');
    } else {
      $children.removeAttr('disabled');
    }
  });
});

// モーダルウィンドウ
$(function(){
  // モーダルウィンドウが開くときの処理
  $(".modalOpen").click(function(){

    var navClass = $(this).attr("class"),
        href = $(this).attr("href");

        $(href).fadeIn();
    $(this).addClass("open");
    return false;
  });
  // モーダルウィンドウが閉じるときの処理
  $(".modalClose").click(function(){
    $(this).parents(".modal").fadeOut();
    $(".modalOpen").removeClass("open");
    return false;
  });
});
