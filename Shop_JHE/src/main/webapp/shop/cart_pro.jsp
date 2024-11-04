<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%
String root = request.getContextPath();
String productId = request.getParameter("id");

List<Product> cartList = (List<Product>) session.getAttribute("cartList");
if (cartList == null) {
    cartList = new ArrayList<Product>();
}

ProductRepository productDAO = new ProductRepository();

boolean productSw = false;
if(cartList==null){	
	Product product = productDAO.getProductById(productId);
	product.setAmount(1);
	cartList.add(product);
} else {
	for(Product product1:cartList){
		if(product1.getProductId().equals(productId)){
			product1.setAmount(product1.getAmount()+1);
			productSw = true;
			break;
		}
	}
	if(!productSw){
		Product product = productDAO.getProductById(productId);
		product.setAmount(1);
		cartList.add(product);
	}
}
session.setAttribute("cartList", cartList);
response.sendRedirect(root + "/shop/products.jsp");
%>