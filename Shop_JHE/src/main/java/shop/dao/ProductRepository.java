package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		List<Product> productList = new ArrayList<Product>();
		
		String sql = " SELECT * FROM product";
		
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				Product pro = new Product();
				pro.setProductId(rs.getString("product_id"));
				pro.setName(rs.getString("name"));
				pro.setUnitPrice(rs.getInt("unit_price"));
				pro.setDescription(rs.getString("description"));
				pro.setManufacturer(rs.getString("manufacturer"));
				pro.setCategory(rs.getString("category"));
				pro.setUnitsInStock(rs.getInt("units_in_stock"));
				pro.setCondition(rs.getString("condition"));
				pro.setFile(rs.getString("file"));
				pro.setQuantity(rs.getInt("quantity"));
				productList.add(pro);
				
			}
		} catch (SQLException e) {
			System.err.println("productList 조회 시 예외 발생");
			e.printStackTrace();
		}
		
		return productList;
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		List<Product> productList = new ArrayList<Product>();
		
		String sql = " SELECT * FROM product "
				   + " WHERE name LIKE ? OR description LIKE ? OR category LIKE ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			String skeyword = "%" + keyword + "%";
			psmt.setString(1, skeyword);
			psmt.setString(2, skeyword);
			psmt.setString(3, skeyword);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Product pro = new Product();
				pro.setProductId(rs.getString("product_id"));
				pro.setName(rs.getString("name"));
				pro.setUnitPrice(rs.getInt("unit_price"));
				pro.setDescription(rs.getString("description"));
				pro.setManufacturer(rs.getString("manufacturer"));
				pro.setCategory(rs.getString("category"));
				pro.setUnitsInStock(rs.getInt("units_in_stock"));
				pro.setCondition(rs.getString("condition"));
				pro.setFile(rs.getString("file"));
				pro.setQuantity(rs.getInt("quantity"));
				productList.add(pro);
			}
		} catch (SQLException e) {
			System.err.println("keyword로 상품 목록 검색 시 예외 발생");
			e.printStackTrace();
		}
		return productList;
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		Product pro = new Product();
		String sql = " SELECT * FROM product WHERE product_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			rs = psmt.executeQuery();
			if (rs.next()) {
				pro.setProductId(rs.getString("product_id"));
				pro.setName(rs.getString("name"));
				pro.setUnitPrice(rs.getInt("unit_price"));
				pro.setDescription(rs.getString("description"));
				pro.setManufacturer(rs.getString("manufacturer"));
				pro.setCategory(rs.getString("category"));
				pro.setUnitsInStock(rs.getInt("units_in_stock"));
				pro.setCondition(rs.getString("condition"));
				pro.setFile(rs.getString("file"));
				pro.setQuantity(rs.getInt("quantity"));
			}
			
		} catch (SQLException e) {
			System.err.println("product productId로 조회 시 예외 발생");
			e.printStackTrace();
		}
		
		return pro;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		
		String sql = " INSER INTO product VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			psmt.setInt(10, product.getQuantity());
			
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("상품 등록 시 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		String sql = " UPDATE product "
			+ " SET name = ? , unit_price = ?, description = ?,"
			+ " manufacturer = ?, category = ?, units_in_stock = ?,"
			+ " 'condition' = ?, file = ?, quantity = ?"
			+ " WHERE product_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product.getName());
			psmt.setInt(2, product.getUnitPrice());
			psmt.setString(3, product.getDescription());
			psmt.setString(4, product.getManufacturer());
			psmt.setString(5, product.getCategory());
			psmt.setLong(6, product.getUnitsInStock());
			psmt.setString(7, product.getCondition());
			psmt.setString(8, product.getFile());
			psmt.setInt(9, product.getQuantity());
			psmt.setString(10, product.getProductId());
			
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("상품 update 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
		String sql = " DELETE FROM product WHERE product_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("상품 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}





























