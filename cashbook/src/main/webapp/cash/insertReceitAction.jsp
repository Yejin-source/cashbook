<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<!-- Controller -->
<%
	// 필요한 값 가져오기
	int cashNo = Integer.valueOf(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	
	Part part = request.getPart("receit"); // 파일을 받는 API | <input type="file"> name 속성과 일치해야 함
	String originalName = part.getSubmittedFileName();

	// 받은 값 확인
	System.out.println("insertReceitAction.jsp cashNo: " + cashNo);
	System.out.println("insertReceitAction.jsp cashDate: " + cashDate);
	System.out.println("insertReceitAction.jsp originalName: " + originalName);
	
	
	// 1) 중복되지 않는 새로운 파일 이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", "");
	System.out.println("insertReceitAction.jsp uuid filename: " + filename);
	
	
	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 점의 인덱스값 반환
	System.out.println("insertReceitAction.jsp dotLastPos: " + dotLastPos);
	
	String ext = originalName.substring(dotLastPos);
	
	// Request 입력값 유효성 검정
	if(!ext.equals(".png")) {
		response.sendRedirect("cashbook/cash/insertReceitForm.jsp?msg=ErrorNotPng");
		return; // 코드 진행 종료
	}
	
	// originalName은 중복될 수 있기 때문에 새로운 filename 지정
	filename = filename + ext;
	System.out.println("insertReceitAction.jsp filename: " + filename);
	
	Receit receit = new Receit();
	receit.setCashNo(cashNo);
	receit.setFilename(filename);
	
	
	// 3) 파일 저장
	// 빈 파일 생성
	String path = request.getServletContext().getRealPath("upload");
	// 톰켓 안에 cashbook 프로젝트 안 receit 폴더의 실제 물리적 주소를 반환
	System.out.println("insertReceitAction.jsp path: " + path);
	File emptyFile = new File(path, filename);

	// 파일을 보낼 inputstream 설정
	InputStream is = part.getInputStream(); // 파트 안의 스트림(이미지 파일의 바이너리 파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream binary -> 반복(1byte씩) -> outputstream
	
	
	// 4) db에 저장
	ReceitDao rd = new ReceitDao();
	rd.insertReceit(receit);
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo="+cashNo+"&cashDate="+cashDate);
%>