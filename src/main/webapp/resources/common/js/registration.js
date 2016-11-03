var i=1;
function delfile(){
   $('#upimg'+i+'').detach();
   i--;
}
function checkTemp(isTemp){  
    if(isTemp=="1")
    {
      document.getElementById("bw").style.visibility="visible";
      document.getElementById("pp").style.visibility="visible";
     }
     else{
                      
     }
}
function loadTempIdea(rid){
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["rid"]=rid;
   headers[csrfHeader] = csrfToken;
      $.ajax({
       url : "/registration/loadTempIdea",
       dataType : "json",
       type : "POST",
       headers: headers,
       data : data,
       success: function(data) {
          document.getElementById("idea_kind").value=data.typeOfInvent;
            document.getElementById("idea_title").value=data.title;
            document.getElementById("small_cont").value=data.summary;
            document.getElementById("why_cont").value=data.whyInvent;
            document.getElementById("col_cont").value=data.problem;
            document.getElementById("wel_cont").value=data.solution;
            document.getElementById("bal_cont").value=data.effect;
            document.getElementById("imp_cont").value=data.core_element;
            document.getElementById("hope_content").value=data.hope_content;
            document.getElementById("picture_explain").value=data.picture_explain;
            document.getElementById("bw").style.visibility="hidden";
           	document.getElementById("pp").style.visibility="hidden";
       },
       error:function(request,status,error){
           alert("code:"+request.status+"\n"+"error:"+error);
       }
   }); 
   
}
 
function removeTempIdea(rid){
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["rid"]=rid;
    headers[csrfHeader] = csrfToken;
    $.ajax({
        url : "/registration/removeTempIdea",
        dataType : "json",
        type : "POST",
        headers: headers,
        data : data,
        success: function(data) {
           document.getElementById("bw").style.visibility="hidden";
          document.getElementById("pp").style.visibility="hidden";
          location.href="/registration/addidea";
        },
       error:function(request,status,error){
           alert("code:"+request.status+"\n"+"error:"+error);
       }
   });
}
function tempsave(){
   var typeOfInvent=document.getElementById("idea_kind").value;
   var title=document.getElementById("idea_title").value;
   var summary=document.getElementById("small_cont").value;
   var whyInvent=document.getElementById("why_cont").value;
   var problem=document.getElementById("col_cont").value;
   var solution=document.getElementById("wel_cont").value;
   var effect=document.getElementById("bal_cont").value;
   var core_element=document.getElementById("imp_cont").value;
   var uid=document.getElementById("uid").value;
   var hope_content=document.getElementById("hope_content").value;
   var picture_explain=document.getElementById("picture_explain").value
   
   var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
   var csrfToken = $("meta[name='_csrf']").attr("content"); 
   var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // THIS WAS ADDED
   var data = {};
   var headers = {};
   
   data[csrfParameter] = csrfToken;
   data["typeOfInvent"] = typeOfInvent;
   data["title"] = title;
   data["summary"] = summary;
   data["whyInvent"] = whyInvent;
   data["problem"] = problem;
   data["solution"] = solution;
   data["effect"] = effect;
   data["core_element"] = core_element;
   data["uid"]=uid;
   data["hope_content"]=hope_content;
   data["picture_explain"]=picture_explain;
   headers[csrfHeader] = csrfToken;
   $.ajax({
      url : "/registration/tempsave",
      dataType : "json",
      type : "POST",
      headers: headers,
      data : data,
      success: function(data) {
         alert("임시저장이 완료되었습니다");
      },
      error:function(request,status,error){
          alert("code:"+request.status+"\n"+"error:"+error);
      }
   
   }); 
}
 
 
 
function closeload(){
   document.getElementById("bw").style.visibility="hidden";
   document.getElementById("pp").style.visibility="hidden";  
   
}
function formSubmit(file){
   //alert($("input[name=imgs]").length);
    var maxSize  = 5 * 1024 * 1024    
    var fileSize = 0;
 
   // 브라우저 확인
   var browser=navigator.appName;
 
   // 익스플로러일 경우
   if (browser=="Microsoft Internet Explorer")
   {
      alert("ie");
      var oas = new ActiveXObject("Scripting.FileSystemObject");
      fileSize = oas.getFile( file.value ).size;
   }
      // 익스플로러가 아닐경우
   else
   {
      fileSize+= file.files[i].size;
      alert(fileSize);
   }
   
   
   alert("파일사이즈 : "+ fileSize +", 최대파일사이즈 : 5MB");
   
   if(fileSize > maxSize)
   {
       alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.    ");
       return false;
   }
   
   if(document.getElementById("typeOfInvent").value=="-"){
      alert("발명분야를 선택해주세요");
      return false;
   }
}
function changeType(value){
   document.getElementById("idea_kind").value=value;
}