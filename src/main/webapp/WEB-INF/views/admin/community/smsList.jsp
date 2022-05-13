<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="SMS발송 내역" name="title"/>
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	    <h1>
	        SMS 발송 내역
	        <small>SMS 발송 내역 list</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>커뮤니티 관리</li>
	        <li class="active">SMS 발송 내역</li>
	    </ol>
	</section>
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <label style="margin-top:5px;">총 ${ total }건</label>
	                    <div class="box-tools pull-right" style="margin-bottom:5px;">
	                        <form name="form_search" method="post" action="${pageContext.request.contextPath }/admin/comm/sms_list?${_csrf.parameterName}=${_csrf.token}">
	                        <div class="has-feedback">
	                            <span>
	                                <input type="text" name="keyword" id="keyword" value="" class="form-control input-sm" placeholder="검색"/>
	                                <span class="glyphicon glyphicon-search form-control-feedback"></span>
	                            </span>
	                        </div>
	                    </div>
	
	                    <div class="box-tools pull-right" style="margin-bottom:5px;">
	                        <div class="has-feedback">
	                            <select name="field" class="form-control input-sm" style="float:left; width:130px;">
	      							<option value="total">전체</option>      
	      							<option value="receive_title">제목</option>      
	      							<option value="receive_content">내용</option>      
	      							<option value="receive_phone">수신번호</option>                            
	      						</select>
	                        </div>
	                        </form>
	                    </div>
	
	                    <table class="table table-bordered table-hover">
							<colgroup>
								<col width="50px" />
								<col width="80px" />
								<col width="150px" />
								<col width="300px" />
								<col width="*" />
								<col width="100px" />
								<col width="150px" />
							</colgroup>
							<thead>
	                            <tr>
	                                <td>NO</td>
	                                <td>구분</td>
									<td>수신번호</td>
	                                <td>제목</td>
	                                <td>내용</td>
									<td>사용 포인트</td>
	                                <td>등록일시</td>
	                            </tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${ empty smsList }">
										<tr>
											<td colspan="7">발송한 sms가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="s" items="${ smsList }">
											<tr>
				                                <td>${ s.smsCode }</td>
				                                <td>${ s.receiveCode }</td>
												<td>${ s.receivePhone }</td>
				                                <td align="left">${ s.receiveTitle }</td>
				                                <td align="left">${ s.receiveContent }</td>
												<td>${ s.smsPoint }</td>
												<td>${ s.reDate }</td>
				                            </tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>         					
	                    	</tbody>
	                    </table>
	                    <br>
	
						<!-- 페이징 -->
	                    <div style="text-align:right;">
	                        <ul class="pagination" style="margin:0;">
								<li class="active"><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=1">1</a></li>
								<li><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=2">2</a></li>
								<li><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=3">3</a></li>
								<li><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=4">4</a></li>
								<li><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=5">5</a></li>
								<li class="next"><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=6">Next → </a></li>
								<li><a href="${pageContext.request.contextPath }/admin/comm/sms_list?type=sms&arrSearch=&page=6">Last → </a></li>
							</ul>                    
						</div>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section>
</div><!-- /.content-wrapper -->

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>