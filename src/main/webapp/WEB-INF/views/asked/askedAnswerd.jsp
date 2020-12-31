<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/asked/askedDetail.css" type="text/css">
</head>
<body>
<script>
var bNo = '${ question.bNo }'; 
var userId = '${ userId }'; 
var recnt = '${question.recnt}';


$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시
	if($('[name=content]').val()==""){
		swal('답변등록','답변 내용을 입력하세요.','info'); 
		} else if($('[name=content]').val()!="" && recnt == 0){
			var insertData = $('[name=commentInsertForm]').serialize();
			swal({
				text: '답변이 등록되었습니다.', 
				icon: 'success',
				dangerMode: true,
				closeOnClickOutside: false,
			}).then((ok) => {
				 if(ok){commentInsert(insertData);}
				})
			 } else {sweetAlert('문의사항','이미 등록된 답변이 있습니다.','info'); }
});
 
 
 
//댓글 목록 
function commentList(){
    $.ajax({
        url : 'replyList.ao',
        type : 'get',
        data : {'bNo':bNo},
        success : function(data){
            var a =''; 
            $.each(data, function(key, value){ 
                a += '<div class="backCommentDiv">'; 
                a += '<div class="commentInfo">';                
                a += '<div class="commentContent'+value.cNo+'"> <p> 답변 '+ value.cDate +'</p>';
                a += '<div class="commentDiv">' + value.cContent
                a += '</div></div>';
                a += '<c:if test="${ loginUser.userId eq 'admin' }">';
                a += '<button id="answerUpdateBtn" onclick="commentUpdate('+value.cNo+',\''+value.cContent+'\');"> 수정 </button>';
                a += '<button id="answerDeleteBtn" onclick="commentDelete('+value.cNo+');"> 삭제 </button> </div>';
                a += '</c:if>'
                a += '</div>';
            });
            
            $(".commentList").html(a);
        }
    });
}
 
//댓글 등록
function commentInsert(insertData){
	console.log(userId);
	
    	 $.ajax({
        url : 'addReply.ao',
        type : 'post',
        data : insertData,
        async : false,
        success : function(data){
        	if(data == 'success') {
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
                //웹소켓6 웹소켓에 메시지전송
                if(socket){
    				let socketMsg = "reply," + userId +","+ bNo;
    				console.log("msgmsg : " + socketMsg);
    				socket.send(socketMsg);
    			}
                location.reload();
               }
        }

	});
   }
//댓글 수정(폼 변경)
function commentUpdate(cNo, cContent){
	 
	sweetAlert('문의사항','변경 후 확인을 누르시면 수정이 완료됩니다.','info');
   
	 var a ='';
    
    a += '<div class="input-group">';
    a += '<textarea class="editForm" name="cContent'+cNo+'" maxlength="300">'+cContent+'</textarea>';
    a += '<span class="input-group-btn"><button class="editOkbtn" type="button" onclick="commentUpdateProc('+cNo+');">확인</button> </span>';
    a += '</div>';
    
    $('.commentContent'+cNo).html(a);
    
}
 
//댓글 수정
function commentUpdateProc(cNo){
   
	sweetAlert('문의사항','답변 수정이 완료되었습니다.','success');
	
	var updateContent = $('[name=cContent'+cNo+']').val();
    
    $.ajax({
        url : 'rupdate.ao',
        type : 'post',
        data : {'cContent' : updateContent, 'cNo' : cNo},
        success : function(data){
            if(data == 1) commentList(bNo); //댓글 수정후 목록 출력 
        }
    });
}
 
//댓글 삭제 
function commentDelete(cNo){
	swal({
		text:'답변을 삭제하시겠습니까?',
		icon:'info',
		buttons: ["아니오","예"],
		dangerMode: true,
		closeOnClickOutside: false,
	}).then((ok) => {
		console.log(cNo);
		if(ok){
		 	$.ajax({
			     url : 'rdelete.ao',
			     type : 'post',
			     data : {'cNo' : cNo },
			     success : function(data){
			    	 	swal({
			    	 		text: '답변 삭제가 완료되었습니다.',
			    	 		closeOnClickOutside: false,
			    	 	}).then((ok) => {
			    			if(data == 1) commentList(bNo); //댓글 삭제후 목록 출력 
			     		 	$('[name=content]').val('');
			      			location.reload();
			        		})
			     			},
			     error: function(data){
			    	 swal('', '답변 삭제에 실패하였습니다.', '');
			     	}   		 	
				});
		  		}
			})
		}
			
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});
 
 
</script>
</body>
</html>