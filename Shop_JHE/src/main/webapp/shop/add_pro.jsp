
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
    String uploadPath = getServletContext().getRealPath("/static/img/");
    int maxSize = 10 * 1024 * 1024; // 10MB

    // 파일 업로드를 위한 MultipartRequest 객체 생성
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", policy);

    // ProductRepository 인스턴스 생성
    ProductRepository productDAO = new ProductRepository();
    Product product = new Product();

    // 폼에서 전송된 데이터 가져오기
    product.setProductId(multi.getParameter("id"));
    product.setName(multi.getParameter("name"));
    product.setUnitPrice(Integer.parseInt(multi.getParameter("price")));
    product.setDescription(multi.getParameter("description"));
    product.setManufacturer(multi.getParameter("manufacturer"));
    product.setCategory(multi.getParameter("category"));
    product.setQuantity(Integer.parseInt(multi.getParameter("quantity")));
    product.setCondition(multi.getParameter("condition"));

    // 파일 처리
    String fileName = multi.getFilesystemName("imgfile"); // 업로드된 파일명
    if (fileName != null) {
        product.setFile(uploadPath + fileName); // 파일 경로 설정
    }

    // 데이터베이스에 상품 등록
    int result = productDAO.insert(product);

    // 결과에 따른 페이지 이동
    if (result == 1) {
        response.sendRedirect(root + "/shop/products.jsp"); // 성공 시 제품 목록 페이지로 이동
    } else {
%>
        <script>
            alert("상품 등록에 실패하였습니다.");
            history.back(); // 실패 시 이전 페이지로 돌아가기
        </script>
<%
    }
%>