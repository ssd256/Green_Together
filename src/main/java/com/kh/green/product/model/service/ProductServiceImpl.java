package com.kh.green.product.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.board.model.vo.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.product.model.dao.ProductDAO;
import com.kh.green.product.model.vo.Cart;
import com.kh.green.product.model.vo.Order;
import com.kh.green.product.model.vo.OrderDetail;
import com.kh.green.product.model.vo.Product;
import com.kh.green.product.model.vo.Review;
import com.kh.green.product.model.vo.Wish;

@Service("pService")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ProductDAO pDAO;
	
	@Override
	public int getListCount() {
		return pDAO.getListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Product> selectList(int i, PageInfo pi) {
		ArrayList list = null;
		
		if(i == 1) {
			list = pDAO.selectPList(sqlSession, pi);
		} else {
			list = pDAO.selectFList(sqlSession, pi);
		}
		return list;
	}
	
	@Override
	public int getListSearchCount(Product p) {
		return pDAO.getListSearchCount(sqlSession, p);
	}
	
	@Override
	public ArrayList<Product> selectSearchPList(Product p, PageInfo pi) {
		return pDAO.selectSearchPList(sqlSession, p, pi);
	}

	@Override
	public ArrayList<Files> selectSearchFList(Product p, PageInfo pi) {
		return pDAO.selectSearchFList(sqlSession, p, pi);
	}
	
	@Override
	public int getListOptionCount(String option) {
		return pDAO.getListOptionCount(sqlSession, option);
	}
	
	@Override
	public ArrayList<Product> selectOptionPList(String option, PageInfo pi) {
		return pDAO.selectOptionPList(sqlSession, option, pi);
	}
	
	@Override
	public ArrayList<Files> selectOptionFList(String option, PageInfo pi) {
		return pDAO.selectOptionFList(sqlSession, option, pi);
	}
	
	@Override
	public Product selectProduct(int bNo) {
		return pDAO.selectProduct(sqlSession, bNo);
	}
	
	@Override
	public ArrayList<Files> selectFiles(int bNo) {
		return pDAO.selectFiles(sqlSession, bNo);
	}
	
	@Override
	public int insertProduct(Product p) {
		return pDAO.insertProduct(sqlSession, p);
	}
	
	@Override
	public int insertFiles(Files f) {
		return pDAO.insertFiles(sqlSession, f);
	}
	
	@Override
	public int updateBoard(Product p) {
		return pDAO.updateBoard(sqlSession, p);
	}
	
	@Override
	public int updateProduct(Product p) {
		return pDAO.updateProduct(sqlSession, p);
	}
	
	@Override
	public int updateFiles(Files f) {
		return pDAO.updateFiles(sqlSession, f);
	}	
	
	@Override
	public int deleteProduct(int bNo) {
		return pDAO.deleteProduct(sqlSession, bNo);
	}
	
	@Override
	public int deleteFiles(int bNo) {
		return pDAO.deleteFiles(sqlSession, bNo);
	}
	
	@Override
	public int getCountCartTotal(String mId) {
		return pDAO.getCountCartTotal(sqlSession, mId);
	}
	
	@Override
	public int getCountCart(Cart cart) {
		return pDAO.getCountCart(sqlSession, cart);
	}
	
	@Override
	public ArrayList<Order> selectOrder(String mId, PageInfo pi) {
		return pDAO.selectOrder(sqlSession, mId, pi);
	}
	
	@Override
	public int insertCart(Cart c) {
		return pDAO.insertCart(sqlSession, c);
	}
	
	@Override
	public int updateCart(Cart c) {
		return pDAO.updateCart(sqlSession, c);
	}
	
	@Override
	public ArrayList<Cart> selectCart(String mId) {
		return pDAO.selectCart(sqlSession, mId);
	}
	
	@Override
	public ArrayList<Product> selectPCount() {
		return pDAO.selectPCount(sqlSession);
	}
	
	@Override
	public ArrayList<Cart> selectDeleteProduct(String mId) {
		return pDAO.selectDeleteProduct(sqlSession, mId);
	}
	
	@Override
	public int deleteCart(Cart c) {
		return pDAO.deleteCart(sqlSession, c);
	}
	
	@Override
	public int getCountWishTotal(String mId) {
		return pDAO.getCountWishTotal(sqlSession, mId);
	}
	
	@Override
	public int getCountWish(Wish wish) {
		return pDAO.getCountWish(sqlSession, wish);
	}
	
	@Override
	public int insertWish(Wish w) {
		return pDAO.insertWish(sqlSession, w);
	}
	
	@Override
	public int updateWish(Wish w) {
		return pDAO.updateWish(sqlSession, w);
	}
	
	@Override
	public ArrayList<Wish> selectWish(String mId) {
		return pDAO.selectWish(sqlSession, mId);
	}
	
	@Override
	public int deleteWish(Wish w) {
		return pDAO.deleteWish(sqlSession, w);
	}
	
	@Override
	public Order selectOrder(Order order) {	// 후기 작성할 상품 있는지 검색
		return pDAO.selectOrder(sqlSession, order);
	}	
	
	@Override
	public int getCountReview(int oId) {
		return pDAO.getCountReview(sqlSession, oId);
	}
	
	@Override
	public int insertReview(Review r) {
		return pDAO.insertReview(sqlSession, r);
	}
	
	@Override
	public ArrayList<Review> selectReview(String pName) {
		return pDAO.selectReview(sqlSession, pName);
	}
	
	@Override
	public ArrayList<Files> selectFReview(String pName) {
		return pDAO.selectFReview(sqlSession, pName);
	}
	

	@Override
	public float selectReviewStar(String pName) {
		return pDAO.selectReviewStar(sqlSession, pName);
	}
	
	@Override
	public int deleteRBoard(int bNo) {
		return pDAO.deleteRBoard(sqlSession, bNo);
	}
	
	@Override
	public int deleteReview(int bNo) {
		return pDAO.deleteReview(sqlSession, bNo);
	}
	
	@Override
	public int deleteRFiles(int bNo) {
		return pDAO.deleteRFiles(sqlSession, bNo);
	}
	
	@Override
	public ArrayList<Order> selectOrder(PageInfo pi) {
		return pDAO.selectOrder(sqlSession, pi);
	}
	
	@Override
	public int updateOrderStatus(Order o) {
		return pDAO.updateOrderStatus(sqlSession, o);
	}
	
	@Override
	public int updateDeliveryStatus(Order o) {
		return pDAO.updateDeliveryStatus(sqlSession, o);
	}

	@Override
	public int insertOrder(Order order) {
		return pDAO.insertOrder(sqlSession, order);
	}

	@Override
	public int insertOrderDetail(OrderDetail orderDetail) {
		return pDAO.insertOrderDetail(sqlSession, orderDetail);
	}
	
	@Override
	public Cart selectProducts(Cart cart) {
		return pDAO.selectProducts(sqlSession, cart);
	}
	
	@Override
	public int deleteOrder(String oNo) {
		return pDAO.deleteOrder(sqlSession, oNo);
	}

	@Override
	public int oNo2bNo(String oNo) {
		return pDAO.oNo2bNo(sqlSession, oNo);
	}
	
	@Override
	public int updateOrderSuccess(String oNo) {
		return pDAO.updateOrderSuccess(sqlSession, oNo);
	}
	
	@Override
	public int updateProductCount(Order o) {
		return pDAO.updateProductCount(sqlSession, o);
	}
	
	@Override
	public int selectProductCount(int pNo) {
		return pDAO.selectProductCount(sqlSession, pNo);
	}
	
	@Override
	public int updateProductCountBack(Order o) {
		return pDAO.updateProductCountBack(sqlSession, o);
	}
	
	@Override
	public String oNo2userID(String oNo) {
		return pDAO.oNo2userID(sqlSession, oNo);
	}
	
	@Override
	public ArrayList<Cart> selectCartOrder(Cart orderCart) {
		return pDAO.selectCartOrder(sqlSession, orderCart);
	}
		
	@Override
	public ArrayList<Product> selectProductTopList() {
		return pDAO.selectProductTopList(sqlSession); 
	}

	@Override 
	public ArrayList<Files> selectFileTopList() { 
		return pDAO.selectFileTopList(sqlSession); 
	}

	@Override
	public ArrayList<Order> selectOrderAD(PageInfo pi) {
		return pDAO.selectOrderAD(sqlSession, pi);
	}

	@Override
	public int oId2bNo(int oId) {
		return pDAO.oId2bNo(sqlSession, oId);
	}

	@Override
	public String oId2userID(int oId) {
		return pDAO.oId2userID(sqlSession, oId);
	}
	
	
}
	
