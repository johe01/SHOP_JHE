package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		String sql = " INSERT INTO 'order' ( order_no, ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone )"
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, order.getOrderNo());
			psmt.setString(2, order.getShipName());
			psmt.setString(3, order.getZipCode());
			psmt.setString(4, order.getCountry());
			psmt.setString(5, order.getAddress());
			psmt.setString(6, order.getDate());
			psmt.setString(7, order.getOrderPw());
			psmt.setString(8, order.getUserId());
			psmt.setInt(9, order.getTotalPrice());
			psmt.setString(10, order.getPhone());
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("주문 등록 시, 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int result = 0;
		
		String sql = " SELECT MAX(order_no) AS max_order_no FROM 'order'";
		
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("max_order_no");
			}
		} catch (SQLException e) {
			System.err.println("최근 등록한 orderNo 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> productList = new ArrayList<Product>();
		
		String sql = "SELECT o.order_no, p.name, p.unit_price, io.amount "
				+ " FROM `order` o JOIN product_io io ON o.order_no = io.order_no"
				+ " JOIN product p ON io.product_id = p.product_id "
				+ " WHERE o.user_id = ?";
		try {
			psmt= con.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product();
				product.setOrderNo(rs.getInt("o.order_no"));
				product.setName(rs.getString("p.name"));
				product.setUnitPrice(rs.getInt("p.unit_price"));
				product.setAmount(rs.getInt("io.amount"));				
				productList.add(product);
			}
		} catch (SQLException e) {
			System.err.println("주문 내역 조회 - 회원 중 예외 발생");
			e.printStackTrace();
		}
			
		return productList;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> productList = new ArrayList<Product>();
		
		String sql = "SELECT o.order_no, p.name, p.unit_price, io.amount"
		           + " FROM `order` o JOIN product_io io ON o.order_no = io.order_no"
		           + " JOIN product p ON io.product_id = p.product_id "
		           + " WHERE o.phone = ? AND o.order_pw = ?";
		try {
			psmt= con.prepareStatement(sql);
			psmt.setString(1, phone);
			psmt.setString(2, orderPw);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product();
				product.setOrderNo(rs.getInt("o.order_no"));
				product.setName(rs.getString("p.name"));
				product.setUnitPrice(rs.getInt("p.unit_price"));
				product.setAmount(rs.getInt("io.amount"));	
				System.out.println(product);
				productList.add(product);
			}
		} catch (SQLException e) {
			System.err.println("주문 내역 조회 - 비회원 중 예외 발생");
			e.printStackTrace();
		}
		
		return productList;
	}
	
}






























