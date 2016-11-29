function getApplyDoc(start_rid) {

	location.href = "/getDoc/" + start_rid;
}

function changeIsread(mid, divid) {
	var csrfToken = $("meta[name='_csrf']").attr("content");
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content"); 
	
	var data = {};
	var data2 = {};
	var headers = {};

	data[csrfParameter] = csrfToken;
	headers[csrfHeader] = csrfToken;

	data['mid'] = mid;
	$.ajax({
		url : "/changeIsread",
		type : "POST",
		headers : headers,
		data : data,
		success : function(retVal) {
			$('#' + divid).empty();
			$('#' + divid).append("<img src='/resources/image/msg_read.png'>");
		},
		error : function(request, status, error) {
			alert('실패하였습니다.');
		}
	});
}