
function sendit(){
    // 
    const userpw=document.getElementById('userpw');
    const userpw_re=document.getElementById('userpw_re');
    const name=document.getElementById('name');
    const hp=document.getElementById('hp');
    const email=document.getElementById('email');
    const hobby=document.getElementsByName('hobby'); // 배열로 받음
    const ssn1=document.getElementById('ssn1')
    const ssn2=document.getElementById('ssn2')
    
    // 정규식     
    // +: 여러글자여도 상관없다 $: 끝낸다  ^:이걸로 시작하세요  \d: 십진수
    // {num}: num 만큼 넣을수있다
    const expHpText= /^\d{3}-\d{3,4}-\d{4}$/
    const expEmailText=/^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/; 


    // 비밀번호 값 확인
    if(userpw.value==''){
        alert('비밀번호를 입력하세요');
        userpw.focus();
        return false;
    }

    if(userpw.value.length < 4 || userpw.value.length>20){
        alert('아이디는 4자 이상 20자 이하로 입력하세요')
        userpw.focus();
        return false;
    }

    //비밀번호 확인 값이 다를경우

    if(userpw.value != userpw_re.value){
        alert('비밀번호와 비밀번호 확인의 값이 다릅니다.')
        userpw.focus();
        return false;
    }

    // 정규표현식으로 이름값 확인
    if(!expNameText.test(name.value)){
        alert('이름의 형식을 확인하세요. \n한글만 입력이 가능합니다.')
        name.focus();
        return false;
    }

    // 전화번호 확인
    if(!expHpText.test(hp.value)){
        alert('휴대폰 번호 형식을 확인하세요. \n하이픈(-)을 포함해야합니다. ')
        hp.focus();
        return false;
    }

    // 이메일 확인
    if(!expEmailText.test(email.value)){
        alert('이메일의 형식을 확인하세요.')
        email.focus();
        return false;
    }

    // 취미는 적어도 1개이상 선택하게 만듬
    let count=0;
    for(let i in hobby){
        if(hobby[i].checked){
            count++
        }
    }
    if(count==0){
        alert('취미는 1개 이상 선택하세요');
        return false;
    }


    return true;
}


