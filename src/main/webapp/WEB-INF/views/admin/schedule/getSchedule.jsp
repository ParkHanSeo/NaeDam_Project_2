<!-- addSchedule.jsp 시작 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script>	
	
</script>

<div class="modal fade" id="modalContent7" tabindex="-2" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" style="width:600px;">
        <div class="modal-content">
            <form name="getSchedule" method="post" action="?tpf=admin/schedule/process" enctype="multipart/form-data">
            <input type="hidden" name="mode" id="mode" value="insert">
            <input type="hidden" name="type" value="nomal">
            <input type="hidden" name="getSchedulNo" value="">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabelPortfolio">일정 관리</h4>
            </div>
            <div class="modal-body">

            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 일정 <span id="board_sub_title">등록</span></p></h4>
            <table class="table table-bordered">
            <tbody><tr>
                <td class="menu">날짜</td>
                <td align="left">
                <span style="float:left">
                <input type="text" name="getScheduleStartDate" id="datepicker3" class="form-control input-sm" style="width:80px; float:left" readonly="" placeholder="시작일">
                <select name="getScheduleStartTime" class="form-control input-sm" style="width:80px; margin-left:3px; float:left;">
      					<option value="00:00">00:00</option>      
      					<option value="00:30">00:30</option>      
      					<option value="01:00">01:00</option>      
      					<option value="01:30">01:30</option>      
      					<option value="02:00">02:00</option>      
      					<option value="02:30">02:30</option>      
      					<option value="03:00">03:00</option>      
      					<option value="03:30">03:30</option>      
      					<option value="04:00">04:00</option>      
      					<option value="04:30">04:30</option>      
      					<option value="05:00">05:00</option>      
      					<option value="05:30">05:30</option>      
      					<option value="06:00">06:00</option>      
      					<option value="06:30">06:30</option>      
      					<option value="07:00">07:00</option>      
      					<option value="07:30">07:30</option>      
      					<option value="08:00">08:00</option>      
      					<option value="08:30">08:30</option>      
      					<option value="09:00">09:00</option>      
      					<option value="09:30">09:30</option>      
      					<option value="10:00">10:00</option>      
      					<option value="10:30">10:30</option>      
      					<option value="11:00">11:00</option>      
      					<option value="11:30">11:30</option>      
      					<option value="12:00">12:00</option>      
      					<option value="12:30">12:30</option>      
      					<option value="13:00">13:00</option>      
      					<option value="13:30">13:30</option>      
      					<option value="14:00">14:00</option>      
      					<option value="14:30">14:30</option>      
      					<option value="15:00">15:00</option>      
      					<option value="15:30">15:30</option>      
      					<option value="16:00">16:00</option>      
      					<option value="16:30">16:30</option>      
      					<option value="17:00">17:00</option>      
      					<option value="17:30">17:30</option>      
      					<option value="18:00">18:00</option>      
      					<option value="18:30">18:30</option>      
      					<option value="19:00">19:00</option>      
      					<option value="19:30">19:30</option>      
      					<option value="20:00">20:00</option>      
      					<option value="20:30">20:30</option>      
      					<option value="21:00">21:00</option>      
      					<option value="21:30">21:30</option>      
      					<option value="22:00">22:00</option>      
      					<option value="22:30">22:30</option>      
      					<option value="23:00">23:00</option>      
      					<option value="23:30">23:30</option>				
      			</select>
                </span>
                
                <span style="float:left">&nbsp;&nbsp;~&nbsp;&nbsp;</span>
                <span style="float:left">
                <input type="text" name="getScheduleEndDate" id="datepicker4" class="form-control input-sm" style="width:80px; float:left" readonly="" placeholder="종료일">
                <select name="getScheduleEndTime" class="form-control input-sm" style="width:80px; margin-left:3px; float:left;">
      					<option value="00:00">00:00</option>      
      					<option value="00:30">00:30</option>      
      					<option value="01:00">01:00</option>      
      					<option value="01:30">01:30</option>      
      					<option value="02:00">02:00</option>      
      					<option value="02:30">02:30</option>      
      					<option value="03:00">03:00</option>      
      					<option value="03:30">03:30</option>      
      					<option value="04:00">04:00</option>      
      					<option value="04:30">04:30</option>      
      					<option value="05:00">05:00</option>      
      					<option value="05:30">05:30</option>      
      					<option value="06:00">06:00</option>      
      					<option value="06:30">06:30</option>      
      					<option value="07:00">07:00</option>      
      					<option value="07:30">07:30</option>      
      					<option value="08:00">08:00</option>      
      					<option value="08:30">08:30</option>      
      					<option value="09:00">09:00</option>      
      					<option value="09:30">09:30</option>      
      					<option value="10:00">10:00</option>      
      					<option value="10:30">10:30</option>      
      					<option value="11:00">11:00</option>      
      					<option value="11:30">11:30</option>      
      					<option value="12:00">12:00</option>      
      					<option value="12:30">12:30</option>      
      					<option value="13:00">13:00</option>      
      					<option value="13:30">13:30</option>      
      					<option value="14:00">14:00</option>      
      					<option value="14:30">14:30</option>      
      					<option value="15:00">15:00</option>      
      					<option value="15:30">15:30</option>      
      					<option value="16:00">16:00</option>      
      					<option value="16:30">16:30</option>      
      					<option value="17:00">17:00</option>      
      					<option value="17:30">17:30</option>      
      					<option value="18:00">18:00</option>      
      					<option value="18:30">18:30</option>      
      					<option value="19:00">19:00</option>      
      					<option value="19:30">19:30</option>      
      					<option value="20:00">20:00</option>      
      					<option value="20:30">20:30</option>      
      					<option value="21:00">21:00</option>      
      					<option value="21:30">21:30</option>      
      					<option value="22:00">22:00</option>      
      					<option value="22:30">22:30</option>      
      					<option value="23:00">23:00</option>      
      					<option value="23:30">23:30</option>
      			</select>
                </span>
                </td>
            </tr>
            <tr>
                <td class="menu">제목</td>
                <td align="left">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tbody>
                
                <tr>
                    <td style="width:8%; text-align:left;">
	                    <select name="getScheduleColor" id="colorselector2" style="display: none;">
	          				<option value="#A0522D" data-color="#A0522D"></option>          
	          				<option value="#CD5C5C" data-color="#CD5C5C"></option>          
	          				<option value="#FF4500" data-color="#FF4500"></option>          
	          				<option value="#008B8B" data-color="#008B8B"></option>          
	          				<option value="#B8860B" data-color="#B8860B"></option>          
	          				<option value="#32CD32" data-color="#32CD32"></option>          
	          				<option value="#FFD700" data-color="#FFD700"></option>          
	          				<option value="#00C0EF" data-color="#00C0EF"></option>          
	          				<option value="#87CEEB" data-color="#87CEEB"></option>          
	          				<option value="#FF69B4" data-color="#FF69B4"></option>          
	          				<option value="#87CEFA" data-color="#87CEFA"></option>          
	          				<option value="#6495ED" data-color="#6495ED"></option>          
	          				<option value="#DD4B39" data-color="#DD4B39"></option>          
	          				<option value="#FF8C00" data-color="#FF8C00"></option>          
	          				<option value="#C71585" data-color="#C71585"></option>          
	          				<option value="#00A65A" data-color="#00A65A"></option>          
	          				<option value="#F39C12" data-color="#F39C12"></option>          
	          				<option value="#3C8DBC" data-color="#3C8DBC"></option>          
	          				<option value="#000000" data-color="#000000"></option>                    
	          			</select>
                    </td>
                    
                    <td>
                    	<input type="text" name="getScheduleTitle" id="title" class="form-control input-sm" style="width:100%;">
                    </td>
                </tr>
                </tbody>
               </table>
                </td>
            </tr>
            <tr>
                <td class="menu">내용</td>
                <td align="left"><textarea name="getScheduleContents" id="contents" rows="5" style="width:100%"></textarea></td>
            </tr>
            </tbody></table>

            </div>
            <div class="modal-footer">
            <button type="button" name="updateSchedule" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
            <button type="button" name="deleteSchedule" class="btn btn-danger">삭제</button>
            </div>
            </form>
        </div>
    </div>
</div>