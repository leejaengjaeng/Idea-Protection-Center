/**
 * 
 */

function fileCheck(obj){
	pathpoint=obj.value.lastIndexOf('.');
	filepoint = obj.value.substring(pathpoint+1,obj.length);
	filetype=filepoint.toLowerCase();
	if(filetype=='jpg'||filetype=='gif'||filetype=='png'||filetype=='jpeg'||filetype=='bmp'){
		
	}else{
		alert("이미지 파일만 선택할 수 있습니다.");
		parentObj=obj.parentNode;
		node=parentObj.replaceChild(obj.cloneNode(true),obj);
		return false;
	}
	if(filetype=='bmp'){
		upload=confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지 포맷이 아닙니다.\n 그래도 계속 하시겠습니까?');
		if(!upload) return false;
	}
}