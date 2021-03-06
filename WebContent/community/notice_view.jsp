<%@page import="java.util.logging.Logger"%>
<%@page import="kr.co.grcons.vo.Board"%>
<%@page import="kr.co.grcons.control.BoardController"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int boardId = Integer.parseInt(request.getParameter("id"));
Board input = new Board(boardId);
BoardController controller = new BoardController();
Board board = controller.getBoard(input);
Logger logger = Logger.getLogger("notice_view.jsp");
%>
<c:set var="board" value="<%=board%>"></c:set>
<!DOCTYPE html>
<html>
<head>
    <c:import url="/inc/head.jsp"></c:import>
    <link rel="stylesheet" type="text/css" href="/css/contents.css" media="all" />
    <link rel="stylesheet" type="text/css" href="/ckeditor/contents.css" media="all" />
	<script src="<c:url value="/js/sweetalert2.all.min.js"/>"></script>
	<script type="text/javascript">
	function deleteBoard(id){
		var param = "id="+id;
		swal({
			text : "정말 삭제하시겠습니까?",
			showCancelButton: true,
			focusConfirm: true,
			confirmButtonText: '네',
			cancelButtonText:'취소',
			animation: false
		}).then(function(result){
			if(result.value){
				$.ajax({
					type:"POST",
					url :$("input[name='deleteUrl']").val(),
					data: param,
					success : function(deleteResult){
						console.log(deleteResult);
						
						var json = JSON.parse(deleteResult);
						console.log(json);
						if(json.result > 0){
							swal({
								text : "삭제되었습니다."
							}).then(function(result){
								window.location.href="/community/notice.jsp";
							});
						}
					}
				});
			}
		});
	}
	</script>
</head>
<body>
<div id="wrap">
    <c:import url="/inc/header.jsp"></c:import>
    <div id="container_wrap">
        <div id="container">
            <div id="contents_top" class="contents_top4">
                <div>
                    <h2>커뮤니티</h2>
                    <span>Community</span>
                </div>
            </div>
            <div id="tit1">
                <h3>공지사항</h3>
            </div>
            <div class="board_view_wrap">
                <div class="board_view">
                    <table class="tbl1">
                        <colgroup>
                            <col width="15%">
                            <col width="35%">
                            <col width="15%">
                            <col width="35%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>제목</th>
                                <td colspan="3">${board.title }</td>
                            </tr>
                            <tr>
                                <th>글쓴이</th>
                                <td>${board.username }</td>
                                <th>날짜</th>
                                <td>${board.wdate }</td>
                            </tr>
                            <tr class="cke_contents_ltr">
                                <td colspan="4" class="cont">${board.content }</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="board_view_bottom">
                    <input type="hidden" name="deleteUrl" value="<c:url value="/board/delete/action"/>">
                    <a href="<c:url value="/community/notice_modify.jsp"><c:param name="id" value="${board.id }"/></c:url>" class="bt1 board_bt_list">수정</a>
                    <a href="javascript:deleteBoard('${board.id }')" class="bt1 board_bt_list">삭제</a>
                    <a href="<c:url value="/community/notice.jsp"/>" class="bt1 board_bt_list">목록</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:import url="/inc/footer.jsp"></c:import>
</div>
</body>
</html>