 var i=1;
function addfile(){
    i++;
    $('#upimgdiv').append("<input type='file' id='upimg"+i+"' name='imgs' accept='image/gif, image/jpeg, image/png' style='padding-top:10px;' onchange='fileCheck(this)'>");
    //var targetdiv=document.getElementById("uploaddiv");
    //targetdiv.innerHTML+="<input type='file' name='imgs' oncellchange='addfile()' accept='image/gif, image/jpeg, image/png'>";
 
}
function addfile2(){
    i++;
    $('#upimgdiv2').append("<input type='file' id='upimg"+i+"' name='imgs' accept='image/gif, image/jpeg, image/png' style='padding-top:5px; margin-left:5px; margin-top:5px; float:left;' onchange='fileCheck(this)'>");
}
$(function(){
   $("textarea,input,button").attr({"tabindex":"-1"});   
   $(".tab_title:odd").css("background","#464646");
});
$(".popup_close, #load_data").click(function(){
   $("body").css("overflow","auto");   
});

$('#idea_title').keyup(function(){
    if ($(this).val().length > 45) {
        alert('제한길이 초과');
        $(this).val($(this).val().substr(0, 45));
    }
});
	$(".tab_title").click(function(){
		if($(this).parent(".hiding_tab").hasClass("tab")){                                       
        	$(this).removeClass("down"); 
    	    $(this).parent(".hiding_tab").stop().animate({"max-height":"47px"}).removeClass("tab");           
            $(this).children(".arrow-up").stop().css({'transform' : 'rotate(180deg)','border-bottom-color':'#fff'}).removeClass("tab");
        }else{            
        	$(this).addClass("down"); 
     	    $(this).parent(".hiding_tab").stop().animate({"max-height":"2000px"}).addClass("tab");           
            $(this).children(".arrow-up").stop().css({'transform' : 'rotate(0deg)','border-bottom-color':'#0fa4d4'}).addClass("tab");
        }
	});
    
   $(".nav>button").click(function(){
	  $(this).next(".modal").css("display","block");
   });
   $(".modal").click(function(){
	  $(this).css("display","none"); 
   });
   
   $(".tab_box div").click(function(){       
       $(this).addClass("sel").siblings().removeClass("sel");
       $(this).eq(0).css({backgroundColor:"#004a80",color:"#fff"}).siblings(0).css({backgroundColor:"#fff",color:"#464646"});                        
   });    
   $(".b0").click(function(){
       $(".a0").css("display","block");
       $(".a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
   });
   $(".b1").click(function(){
       $(".a1").css("display","block");
       $(".a0,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
   });
   $(".b2").click(function(){
       $(".a2").css("display","block");
       $(".a0,.a1,.a3,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
   });
   $(".b3").click(function(){
       $(".a3").css("display","block");
       $(".a0,.a2,.a1,.a4,.a5,.a6,.a7,.a8,.a9").css("display","none");
   });
   $(".b4").click(function(){
       $(".a4").css("display","block");
       $(".a0,.a2,.a3,.a1,.a5,.a6,.a7,.a8,.a9").css("display","none");
   });
   $(".b5").click(function(){
       $(".a5").css("display","block");
       $(".a0,.a2,.a3,.a4,.a1,.a6,.a7,.a8,.a9").css("display","none");
   });
   $(".b6").click(function(){
       $(".a6").css("display","block");
       $(".a0,.a2,.a3,.a4,.a5,.a1,.a7,.a8,.a9").css("display","none");
   });
   $(".b7").click(function(){
       $(".a7").css("display","block");
       $(".a0,.a2,.a3,.a4,.a5,.a6,.a1,.a8,.a9").css("display","none");
   });
   $(".b8").click(function(){
       $(".a8").css("display","block");
       $(".a0,.a2,.a3,.a4,.a5,.a6,.a7,.a1,.a9").css("display","none");
   });
   $(".b9").click(function(){
       $(".a9").css("display","block");
       $(".a0,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a1").css("display","none");
   });
 
   $("#nt").click(function(){
	   $(".nt").css("display","block");
	   $(".ot").css("display","none");
   });
   $("#ot").click(function(){
	   $(".nt").css("display","none");
	   $(".ot").css("display","block");
   });
   