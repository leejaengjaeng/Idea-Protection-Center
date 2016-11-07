$(document).ready(function()
{
	/*
    if("${isFirst}" == "true")
       hideBeforeCmt();
    */
    
    //상태에 따른 응답 보여주기
	if("${currentAnswer.getIscomplete()}" == 1)	enableInput();
	else
	{
		disableInput();
		if ("${currentAnswer.getIscomplete()}" == 2) 	alert("가출원상태에서는 수정을 할 수 없습니다.");
		else if ("${currentAnswer.getIscomplete()}"==3) alert("발명가 회원님이 최종 확인중입니다.");
		else if ("${currentAnswer.getIscomplete()}"==4) alert("발명가 회원님이 서류 업로드 중입니다.");
		else if ("${currentAnswer.getIscomplete()}"==5) location.href="/downLoadPage";
		else if ("${currentAnswer.getIscomplete()}"==6) alert("출원이 완료된 사항입니다.");
		else alert('고객이 작성을 완료하기를 기다려주세요');         
	}
	
    //폼 버튼 이벤트 
    $('#tmpSave').on("click",function()
    {
    	tmpSave("${user}");
    });
    
	$('#agree').on("click",function()
    {
    	ideaSave("${user}");
	});
    

	///
	///
	///
    $('#gogogo').on("click",function()
	{
    
		//var q=confirm("출원을 선택하면 수정할 수 없습니다. 출원을 선택하시겠습니까?")
            // if(q==true){
            //    alert("확인을 누르시면 가출원 양식 서류가 다운받아집니다.");
            //    tempApply("${user}");
            // }
            // else{
            //    return false;
            // }
         //
        
            
    	var q=confirm("출원을 선택하면 수정할 수 없습니다. 출원을 선택하시겠습니까?");      
        
        if(q==true){                                            
        	    alert("확인을 누르시면 출원단계가 진행되어집니다.");               
        	    lastconfirm("${user}");                                
        	 }                                                       
        	 else{                                                   
        	    return false;                                        
        	 }                                                       
   });
         //클릭에 따라 내용 바꿔주기
         $('#IdeaModifyList').on("click","tr",function()
         {
            //IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소의 clickedIdea를 제거 
            $(this).parent().find('.clickedIdea').removeClass('clickedIdea');
            var rid = $(this).children('input').attr('value');
            
            if(rid == ${lastRid} && ("${currentAnswer.getIscomplete()}" == 1))
            {
               enableInput();
            }
            else
            {
               disableInput();
            }
            //현재 선택된 요소(tr)에 clickedIdea를 붙임
            $(this).addClass('clickedIdea');
            
            showClickedList(rid);   
         })
         //작성 예시 버튼 이벤트
          $(".txt_box > button").click(function(){
              $(this).nextAll(".hiding_box").fadeIn();
          });
          $(".close_btn").click(function(){
             
              $(this).parents(".hiding_box").fadeOut();
          });
          var optcnt = document.getElementById("selectBox").options.length;
          for(i=0;i<optcnt;i++){
      		if(document.getElementById("selectBox").options[i].value=="${currentAnswer.getTypeOfInvent()}"){
      			document.getElementById("selectBox").options[i].selected=true;
      		}
      	}
      });