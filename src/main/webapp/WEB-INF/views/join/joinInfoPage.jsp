<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GURUME365-사업장 관리 페이지</title>

<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
   href="<c:url value="/resources/css/joinInfoPage2.css"/>">
<script type="text/javascript"
   src="<c:url value='/resources/js/jquery-3.2.1.js'/>"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
<link rel="stylesheet"
   href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script
   src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>


<style type="text/css">
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
   /* display: none; <- Crashes Chrome on hover */
   -webkit-appearance: none;
   margin: 0;
   /* <-- Apparently some margin are still there even though it's hidden */
}



</style>
<script type="text/javascript">

   var currentJusoNo = -1;
   
   function addressCallback(roadFullAddr,roadAddrPart1,addrDetail,
         roadAddrPart2,engAddr,jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,
         bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,
         lnbrMnnm,lnbrSlno,emdNo){
      
      document.form.roadAddrPart1.value=roadAddrPart1;
      document.form.addrDetail.value=addrDetail;
      
      var address1 = $('#address1');
      var address2 = $('#address2');
      
      address1.attr("value",roadAddrPart1);
      address2.attr("value",addrDetail);   
      self.close;
   }
   function pwcheck(){
      
      var password=document.getElementById('password');
      var password2=document.getElementById('password2');
      if(password.value!=password2.value){
         alert('비밀번호가 일치하지 않습니다.');
         return false;
      }
      return true;
   }
    function update(){
      
      var pw=$('#password').val();
      var phone=$('#phone').val();
      
      
      $.ajax({
         url: 'updateUsers'
         ,type: 'post'   
         ,data: {
            pw: pw
            ,phone: phone
         }
         ,success: function(){
            alert('정보가 수정되었습니다.');
            location.href='../';
         }
         ,error: function(){
            alert('수정에 실패했습니다.');
         }      
      });      
   } 

   function maxLengthCheck(object){
       if (object.value.length > object.maxLength){
           object.value = object.value.slice(0, object.maxLength);
       }    
   }

   $(function() {
      
      $(document).on($.modal.OPEN, {
          escapeClose: false,
              clickClose: false,
              showClose: false
      });

      ///////////////////////////////////////////////
      //  사업장 편집 기능 불러오기
      ///////////////////////////////////////////////
      $.ajax({
         url: '/gurume365/store/loadMyStore',
         type: 'get',
         dataType: 'json',
         success: function(dat) {
            
            var html = '';
            var html2 = ''
            
            $('#businessInfoArea').append('<div id="tabs" class="businessInfoTab"><ul id="tabsUl"></ul></div>');
            
            for(var d of dat) {
               
               
               
               $('#tabsUl').append('<li><a href="#tab' + d.shopNo + '">' + d.companyName + '</a></li>');
               html = '<div id="tab' + d.shopNo + '" class="editBusinessDiv">' +
                        
                        '<div>사업자번호: ' + d.companyNo + '</div>' +
                        '<div>상호명: <input type="text" name="companyName" id="company_name' + d.shopNo + '" value="' + d.companyName + '">' + '&nbsp;&nbsp;&nbsp;등급: '+ d.grade + '</div>' +
                        '<div>전화번호: <input type="number" name="phone" id="phone_num' + d.shopNo + '" placeholder="숫자만 입력" value="' + d.phone.replace(/-/g, '') + '"></div>' +
                        '<div>업종: <select class="selectCategories" name="category" id="selCatId' + d.shopNo + '"></select></div>' +
                        '<div class="businessHoliday">휴무일: <input type="text" class="holidayString" name="holiday" id="holidayString' + d.shopNo + '" value="' + d.holiday + '"></div>' +
                        '<div>영업 시간<br>' +
                        '<div class="timeClass' + d.shopNo + '">Open: <input type="text" id="timeOpenId' + d.shopNo + '" class="timeSelectClass" readonly="readonly" >' +
                        ' ~ <input type="text" id="timeCloseId' + d.shopNo + '" class="timeSelectClass" readonly="readonly" ></div>' +
                        '<div class="timeClass' + d.shopNo + ' timeBreakClass' + d.shopNo + '"> break: <input type="text" id="breakStartId' + d.shopNo + '" class="timeSelectClass" readonly="readonly" > ~ ' +
                        '<input type="text" id="breakEndId' + d.shopNo + '" class="timeSelectClass" readonly="readonly" ></div>' +
                        '<div style="margin-top:0px; margin-bottom:0px;"><input type="checkbox" id="timeCheck24Hour' + d.shopNo + '" class="timeCheck24Class" >24시간</div>' +
                        '<div class="timeClass' + d.shopNo +'" style="margin-top:0px;""><input type="checkbox" id="timeCheckBreakHour' + d.shopNo + '" class="timeCheckBreakClass" >준비시간 없음<br></div>' +
                        '</div>' +
                        
                        '<div class="address1">주소:<input type="text" name="address1" id="address1' + d.shopNo + '" readonly="readonly" value="' + d.address1 + '"></div>' +
                        '<div class="address2">상세주소:<input type="text" name="address2" id="address2' + d.shopNo + '" readonly="readonly" value="' + d.address2 + '">' +
                        '<input type="button" value="주소검색" id="jusoBtn' + d.shopNo + '" class="addressPopup"></div>' +
                        
                        '<div>테이블별 예약금:<input type="number" name="budjet" id="budjet' + d.shopNo + '" value="' + d.budjet + '" min="1">원</div>' +
                        
                        '<div>가게 정보<br><textarea name="shopInfo" id="shop_info_input' + d.shopNo + '" rows="10" cols="40">' + d.shopInfo + '</textarea></div>' +
                        
                        '<div>한줄 정보:<br><textarea name="comment" id="shop_comment_input' + d.shopNo + '" rows="2" cols="40">' + d.comment + '</textarea></div>' +
                        '<div>사진 등록: <input type="file" id="storeImgInput' + d.shopNo + '" class="storeImgInput"><br>' +
                        '<img id="img' + d.shopNo + '" src="<c:url value="/resources/img/' + ((d.savedfile==null||d.savedfile==0)? 'camera2.png' : d.savedfile) + '"/>" height="100px" width="100px">' +
                        
                        '<br><a href="../floor/floor_edit?shopNo=' + d.shopNo + '" rel="modal:open"><button class="smallBtn">플로어 수정</button></a>' +
                        '<a href="joinInfoRes?shopNo='+d.shopNo+'"><button class="smallBtn">예약 정보</button></a>'+
                        '<div><button class="editBusinessBtn" id="editBusiness' + d.shopNo + '" style="margin: 2px;">수정</button></div>' +   
                  '</div>';
                  
               $('#tabs').append(html);
                  
               var time_of_Open;
               var businessTime = ['11:00','11:00'];
               var breakTime = ['11:00','11:00'];
               console.log(d.timeOfOpen);
               if(d.timeOfOpen == '24hour') {
                  $('#timeCheck24Hour' + d.shopNo).attr('checked', 'checked');
                  $('.timeClass' + d.shopNo).attr('hidden', 'hidden');
                  console.log('1:' + d.timeOfOpen);
               }
               else {
                  time_of_Open = (d.timeOfOpen).split('/');
                  businessTime = (time_of_Open[0].replace('time:', '')).split('~');
                  
                  if(time_of_Open[1]=='none') {
                     $('#timeCheckBreakHour' + d.shopNo).attr('checked', 'checked');
                     $('.timeBreakClass' + d.shopNo).attr('hidden', 'hidden');
                     console.log('2:' + businessTime[0] + ',' + businessTime[1]);
                     
                  }
                  else {
                     breakTime = (time_of_Open[1].replace('break:', '')).split('~');
                     console.log('#breakStartId' + d.shopNo);
                     console.log('3:' + breakTime[0] + ',' + breakTime[1]);
                     
                  }
               }
               $('#timeOpenId' + d.shopNo).val(businessTime[0]);
               $('#timeCloseId' + d.shopNo).val(businessTime[1]);
               $('#breakStartId' + d.shopNo).val(breakTime[0]);
               $('#breakEndId' + d.shopNo).val(breakTime[1]);
            }
            $( "#tabs" ).tabs();
            
            
            ///////////////////////////////////////////////
            //  사진 등록 기능
            ///////////////////////////////////////////////
            
            $('.storeImgInput').change(function(){ 
               readURL(this);
            });
            
            function readURL(input) {
               if (input.files&& input.files[0]) {
                  var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                  reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                     $('#img' + (input.id).replace('storeImgInput', '')).attr('src', e.target.result); //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 //(아래 코드에서 읽어들인 dataURL형식) }
                  }
                  reader.readAsDataURL(input.files[0]); //File내용을 읽어 dataURL형식의 문자열로 저장
               }
            }//readURL()--
      
                     
            
            
            ///////////////////////////////////////////////
            //  식당 업종 리스트 불러오기 (사업자) 메뉴
            ///////////////////////////////////////////////
            $.ajax({
               url: '/gurume365/store/getCategories',
               type: 'get',
               dataType: 'json',
               success: function(dat2) {
                  var html = '';
                  
                  for(var d2 of dat2) {
                     html += '<option class="sel' + d2 + '">' +
                           d2 +
                           '</option>'
                  }
                  $('.selectCategories').append(html);
                  
                  for(var d of dat) {
                     $('#selCatId' + d.shopNo + ' .sel' + d.category).attr('selected', 'selected');
                  }
                  
               },
               error: function(er) {
                  console.log(er);
               }
            });
            
            
            setEditOnClick();
            
            $('.addressPopup').on('click', function() {
               currentJusoNo = this.id.replace('jusoBtn', '');
               // alert(currentJusoNo);
               var url="jusoPopup";
               window.open(url,"","width=400,height=400,left=600");
            });
            
            
            ///////////////////////////////////////////////
            //  영업시간 선택
            ///////////////////////////////////////////////
            $('.timeSelectClass').timepicker({
                timeFormat: 'hh:mm',
                interval: 60,
                minTime: '0',
                maxTime: '23:00',
                // defaultTime: '11',
                startTime: '0',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });
            
            
            
            // 24시간 영업 체크박스
            $('.timeCheck24Class').on('change', function() {
               var tmpNo = this.id;
               tmpNo = tmpNo.replace('timeCheck24Hour', '');
               // alert('[' + tmpNo + ']');
               if($(this).prop('checked')) {
                  $('.timeClass' + tmpNo).attr('hidden', 'hidden');
               }
               else {
                  $('.timeClass' + tmpNo).removeProp('hidden');
               }
            });
            
            // 준비시간 영업 체크박스
            $('.timeCheckBreakClass').on('change', function() {
               var tmpNo = this.id;
               tmpNo = tmpNo.replace('timeCheckBreakHour', '');
               // alert('[' + tmpNo + ']');
               if($(this).prop('checked')) {
                  $('.timeBreakClass' + tmpNo).attr('hidden', 'hidden');
               }
               else {
                  $('.timeBreakClass' + tmpNo).removeProp('hidden');
               }
            });
            
         },
         error: function(err) {
            console.log(err);
         }
      });
      
   });
   
   function setEditOnClick() {
      ///////////////////////////////////////////////
      //  사업장 수정 버튼 클릭 이벤트
      ///////////////////////////////////////////////
      $('.editBusinessBtn').on('click', function(){
      
         var currentNo = this.id.replace('editBusiness', '');
         var e_company_no;
         var e_company_no_all;
         if(currentNo==-1) {
            currentNo = '';
            e_company_no = [document.getElementById('company_no1'),
               document.getElementById('company_no2'), 
               document.getElementById('company_no3')
               ]
            var cnt = 0;
            e_company_no_all = '';
            for(var i=0; i<e_company_no.length; i++) {
               cnt += e_company_no[i].value.length;
               e_company_no_all += e_company_no[i].value;
               if(i<e_company_no.length-1) {
                  e_company_no_all += '-';
               }
            }
            
            if(cnt<10) {
               alert("사업자등록번호를 다시 한번 확인하여 주시기 바랍니다.");
               return;
            }            
         }
         else {
            
         }
         
         
         var e_company_name = document.getElementById("company_name" + currentNo);
         var e_address1 = document.getElementById("address1" + currentNo);
         var e_address2 = document.getElementById("address2" + currentNo);
         var e_phone_num = document.getElementById("phone_num" + currentNo);
         
         
         var e_timeOpen = document.getElementById("timeOpenId" + currentNo);
         var e_timeClose = document.getElementById("timeCloseId" + currentNo);
         var e_breakStart = document.getElementById("breakStartId" + currentNo);
         var e_breakEnd = document.getElementById("breakEndId" + currentNo);
         
         var e_time_of_open;
         if($('#timeCheck24Hour' + currentNo).prop('checked')) {
            e_time_of_open = '24hour';
         }
         else {
            e_time_of_open = 'time:' + e_timeOpen.value + '~' + e_timeClose.value + '/';
            if($('#timeCheckBreakHour' + currentNo).prop('checked')) {
               e_time_of_open += 'none';
            }
            else {
               e_time_of_open += 'break:' + e_breakStart.value + '~' + e_breakEnd.value;
            }
            e_time_of_open += '/';
         }
         
         var e_shop_info_input = document.getElementById("shop_info_input" + currentNo);
         var e_comment_input = document.getElementById('shop_comment_input' + currentNo );
         
         var e_category = document.getElementById('selCatId' + currentNo);
         var e_budjet = document.getElementById('budjet' + currentNo);
         
         var e_holiday = document.getElementById('holidayString' + currentNo);
         
         if(e_company_name.value.length<=0) {
            alert("상호명을 입력하여 주시기 바랍니다.");
            return;
         }
         else if(e_address1.value.length<=0||e_address2.value.length<=0) {
            alert("주소를 입력하여 주시기 바랍니다.");
            return;
         }
         /* else if() {
            alert("영업시간을 입력하여 주시기 바랍니다.");
            return;
         } */
         else if(e_phone_num.value.length<8) {
            alert("전화번호를 다시 입력하여 주시기 바랍니다.");
            return;
         }
         else if(e_shop_info_input.value.length<10) {
            alert("가게 정보를 10자 이상 입력하여 주시기 바랍니다.");
            return;
         }
         // alert(e_holiday.value);
         if(currentNo=='') {
            $.ajax({
               url: '/gurume365/store/addStore',
               type: 'post',
               data: {
                  companyName: e_company_name.value,
                  companyNo: e_company_no_all,
                  address1: e_address1.value,
                  address2: e_address2.value,
                  phone: e_phone_num.value,
                  category: e_category.value,
                  timeOfOpen: e_time_of_open,
                  shopInfo: e_shop_info_input.value,
                  holiday : e_holiday.value
                  
               },
               dataType: 'json',
               success: function(dat) {
                  location.reload();
                  alert('저장 성공');
               },
               error: function(err) {
                  console.log(err);
               }
            });
            
         }
         else {
            var formData = new FormData();
            formData.append('shopNo', currentNo);
            formData.append('companyName', e_company_name.value);
            formData.append('address1', e_address1.value);
            formData.append('address2', e_address2.value);
            formData.append('phone', e_phone_num.value);
            formData.append('category', e_category.value);
            formData.append('timeOfOpen', e_time_of_open);
            formData.append('shopInfo', e_shop_info_input.value);
            formData.append('comment', e_comment_input.value);
            formData.append('budjet', e_budjet.value);
            formData.append('holiday', e_holiday.value);
            formData.append("file", $('#storeImgInput' + currentNo)[0].files[0]);
            
            $.ajax({
               url: '/gurume365/store/editStore',
               type: 'post',
               data: formData,
               processData : false,
                 contentType : false,
               /* {
                  shopNo: currentNo,
                  companyName: e_company_name.value,
                  companyNo: e_company_no_all,
                  address1: e_address1.value,
                  address2: e_address2.value,
                  phone: e_phone_num.value,
                  category: e_category.value,
                  timeOfOpen: e_time_of_open,
                  shopInfo: e_shop_info_input.value,
                  comment: e_comment_input.value,
                  budjet: e_budjet.value,
                  holiday : e_holiday.value
                  
                  
               }, */
               dataType: 'json',
               success: function(dat) {
                  location.reload();
                  alert('수정 성공');
               },
               error: function(err) {
                  console.log(err);
               }
            });
            
         }
      
      });
   }
   
   function removeLeft() {
      $(".leftCover").detach();
   }
   function removeRight() {
      $(".rightCover").detach();
   }
   
   
</script>

</head>
<body>


   <div>
      <div class="userInfoArea">
         <div class="addBusinessDiv">
            <!-- <div class="leftCover" onclick="removeLeft();">
               <p>가게 정보 추가를 하시려면 클릭하세요!</p>
            </div> -->
            <div class="plusTitle">가게를 추가 합니다</div>

            <div class="businessNum">
               사업자번호: 
               <input type="number" class="businessNumInner" id="company_no1" maxlength="3" oninput="maxLengthCheck(this)" style="width: 30px"> - 
               <input type="number" class="businessNumInner" id="company_no2" maxlength="2" oninput="maxLengthCheck(this)" style="width: 20px"> - 
               <input type="number" class="businessNumInner" id="company_no3" maxlength="5" oninput="maxLengthCheck(this)" style="width: 50px">
            </div>
            <div class="businessName">
               상호명: 
               <input type="text" class="businessNameInner" id="company_name"
                  name="">
            </div>
            <div class="businessPhone">
               전화번호: 
               <input type="number" class="businessPhoneInner" id="phone_num"
                  placeholder="숫자만 입력" maxlength="12" oninput="maxLengthCheck(this)">
            </div>
            <div class="businessClass">
               업종: 
               <select class="selectCategories" id="selCatId">

               </select>
            </div>
            <!-- 휴무일 선택 -->
            <div class="businessHoliday">
               휴무일 :
               <input type="text" class="holidayString" id="holidayString">
            </div>

            <div class="businessTime">
               영업시간<br>
               <!-- 타임 피커 -->
               <div class="timeClass">
                  Open: <input type="text" id="timeOpenId" class="timeSelectClass"
                     readonly="readonly" value="11:00">
                   ~ <input type="text" id="timeCloseId" class="timeSelectClass"
                     readonly="readonly" value="11:00">
               </div>
               <div class="timeClass timeBreakClass">
                  break:<input type="text" id="breakStartId" class="timeSelectClass"
                     readonly="readonly" value="11:00"> ~ <input type="text"
                     id="breakEndId" class="timeSelectClass" readonly="readonly"
                     value="11:00">
               </div>
               <div style="margin-top: 0px; margin-bottom: 0px">
               <input type="checkbox" id="timeCheck24Hour"
                  class="timeCheck24Class">24시간<br>
               </div>
               <div class="timeClass" style="margin-top: 0px">
                  <input type="checkbox" id="timeCheckBreakHour"
                     class="timeClass timeCheckBreakClass">준비시간 없음
               </div>
            </div>

            <div class="address1">
               주소: 
               <input type="text" id="address1" readonly="readonly">
            </div>
            <div class="address2">
               상세주소: 
               <input type="text" id="address2" readonly="readonly">
               <button id="jusoBtn-1" class="addressPopup">주소검색</button>
            </div>

            <div class="storeInfo">
               가게 정보<br>
               <textarea id="shop_info_input" rows="10" cols="40"
                  placeholder="가게 설명을 입력해 주세요!"></textarea>
            </div>

            <div>
               <button id="editBusiness-1" class="editBusinessBtn">가게 등록</button>
            </div>
         </div>
         <div class="businessInfoArea">
            <!-- <div class="rightCover" onclick="removeRight();">
               <p>가게 정보 확인을 하시려면 클릭하세요!</p>
            </div> -->
            <div class="plusTitle">가게를 수정 합니다</div>
            <div id="businessInfoArea"></div>
         </div>
      </div>
   </div>

</body>
</html>