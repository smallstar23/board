
$(function(){
	$('#loginBtn').on('click', function(){
		if($('#userid').val() == ''){
			alert('아이디를 입력하세요.')
			$('userid').focus();
			return false;
		}
		
		const xhr= new XMLHttpRequest();
		const userid= $('#userid').val();
		const userpw= $('#userpw').val();
		xhr.open('GET','login_ok.jsp?userid='+userid+"&userpw="+userpw, true);
		xhr.send();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				const result = xhr.responseText;
				if(result.trim()=="yes"){
					
					$('#login_input').css("display","none");
					$('#login_join').css("display","none");
					$('#welcome').html("<b style='color:blue'>환영합니다!</b>");
					$('#logout').html("<input type='button' value='로그아웃'>");
					
				
				}else{
					$('#welcome').html("<b style='color:red'>아이디 및 패스워드를 확인하세요.</b>");
				}
			}
		}
	})
	

})

