var now = 0;

      //현재첫번째 이미지의 나머지를 숨김
      $(".imgs").eq(now).siblings(".imgs").hide();
      start();
      $(".remote").eq(now).css("background-color", "#ccc");

      function start() {
         time = setInterval(function() {
            $(".imgs").eq(now).fadeOut(1000);
            $(".imgs").eq(now = now == 3 ? 0 : now + 1).fadeIn(1000);
            $(".remote").eq(now).css("background-color", "#ccc");
            $(".remote").eq(now).siblings(".remote").css(
                  "background-color", "#fff");
         }, 8000);
      }

      function end() {
         clearInterval(time)
      }

      //버튼
      function btn(type) {
         if ($(".imgs").is(":animated")) {
            return
         } else {
            end();
            switch (type) {
            case "right":
               $(".imgs").eq(now).fadeOut(1000);
               $(".imgs").eq(now = now == 3 ? 0 : now + 1).fadeIn(1000);
               $(".remote").eq(now).css("background-color", "#ccc");
               $(".remote").eq(now).siblings(".remote").css(
                     "background-color", "#fff");
               break;
            case "left":
               $(".imgs").eq(now).fadeOut(1000);
               $(".imgs").eq(now = now == 0 ? 3 : now - 1).fadeIn(1000);
               $(".remote").eq(now).css("background-color", "#ccc");
               $(".remote").eq(now).siblings(".remote").css(
                     "background-color", "#fff");
               break;
            }
            start();
         }
      }
      //밑에 상태버튼
      function pro(divno) {
         if ($(".imgs").is(":animated") || now == divno) {
            return
         } else {
            end();
            $(".imgs").eq(now).fadeOut(1000);
            $(".imgs").eq(now = divno).fadeIn(1000);
            $(".remote").eq(now).css("background-color", "#ccc");
            $(".remote").eq(now).siblings(".remote").css(
                  "background-color", "#fff");
            start();
         }
      }
      function notready(){
         alert("준비중 입니다.");
      }
   
   $(function(){
	   $(".cover:even").addClass("even");
	   $(".cover:odd").addClass("odd");
   });