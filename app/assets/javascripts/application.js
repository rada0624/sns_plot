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
  $("#calender_inner").on("click",".modalOpen", function(){

    var navClass = $(this).attr("class"),
        href = $(this).attr("href");

        $(href).fadeIn();
    $(this).addClass("open");
    return false;
  });
  // モーダルウィンドウが閉じるときの処理
  $("#calender_inner").on("click", ".modalClose", function(){
    $(this).parents(".modal").fadeOut();
    $(".modalOpen").removeClass("open");
    return false;
  });
});

// ajax通信時にインジケーター（now loading）を表示
$(function() {
  $(document)
  .on("ajax:beforeSend",".ajax_on, .edit_studies_history", function() {
    $('#loading').show();
  })
  .on("ajax:complete",".ajax_on, .edit_studies_history", function() {
    $('#loading').hide();
  });
});

// カテゴリ選択時
$(function() {
  $('.stylish_category_radio').children('input[type="radio"]')
  .change( function() {
    var checked_val = $(this).val().toLowerCase();
    var test = 'input:hidden[name="h_' + checked_val + '"]' ;
    var after_color = "#" + $(test).val();
    $('.stylish_category_radio label')
    .css('background-color', '#bdc3c7');

    $('label.' + checked_val)
    .css('background-color', after_color);
  })
});

// 初期表示時
$(function() {



  $(document).ready( function() {
    var checked_val = $('input[name="studies_history[category2]"]:checked').val().toLowerCase();
    var test = 'input:hidden[name="h_' + checked_val + '"]' ;
    var after_color = "#" + $(test).val();
    $('.stylish_category_radio label')
    .css('background-color', '#bdc3c7');

    $('label.' + checked_val)
    .css('background-color', after_color);
  })
});
