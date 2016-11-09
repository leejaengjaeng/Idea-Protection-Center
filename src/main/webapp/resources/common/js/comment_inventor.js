var i=0;
function addfile()
{
	i++;
	$('#inputFileDiv').append("<div id='div"+i+"' style='float:left;text-align:center;margin:40px 5px 20px 5px; width:230px;'><img style='width:200px; height:200px; border:1px solid #ccc;' src='/resources/image/plus2.png' alt='img' id='"+i+"'><br><input type='file' style='padding-top:5px; font-size:12px; width:200px !important;' id='imgInp"+i+"' name='imgs' onchange='readURL(this,"+i+");fileCheck(this)' name='profileImg' ></div>");
	
}
function delfile(){
	$('#div'+i).remove();
	i--;
}
function readURL(input,imgId) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#'+imgId).attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}
function delImg(aa){
	alert(aa);
	var csrfToken = $("meta[name='_csrf']").attr("content"); 
	   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
	   var data = {};
	  
	   var headers = {};

	   data[csrfParameter] = csrfToken;
	    headers[csrfHeader] = csrfToken;

	    data['id'] = aa;
	    $.ajax({
	      url : "/deleteFile",
	      type:"POST",
	      headers: headers,
	        data : data,
	        success:function(retVal)
	        {
	        	$("#id"+aa).remove();
	             alert("삭제하였습니다.");
	        },
	        error: function(request,status,error)
	      {
	          alert('실패하였습니다.')
	          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	   });   
	    //location.href ="/mainPage";
}

$(".popup_close, #load_data").click(function(){
	$("body").css("overflow","auto");	
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
 
 