package com.kh.green.product.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.board.model.vo.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.member.model.vo.Member;
import com.kh.green.product.model.vo.Cart;
import com.kh.green.product.model.vo.Order;
import com.kh.green.product.model.vo.OrderDetail;
import com.kh.green.product.model.vo.Product;
import com.kh.green.product.model.vo.Review;
import com.kh.green.product.model.vo.Wish;

@Repository("pDAO")
public class ProductDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("productMapper.getListCount");
	}

	public ArrayList<Product> selectPList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectPList", null, rowBounds);
	}
	
	public ArrayList<Product> selectFList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectFList", null, rowBounds);
	}

	public int getListSearchCount(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.selectOne("productMapper.getListSearchCount", p);
	}

	public ArrayList<Product> selectSearchPList(SqlSessionTemplate sqlSession, Product p, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectSearchPList", p, rowBounds);
	}

	public ArrayList<Files> selectSearchFList(SqlSessionTemplate sqlSession, Product p, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectSearchFList", p, rowBounds);
	}
	
	public int getListOptionCount(SqlSessionTemplate sqlSession, String option) {
		return sqlSession.selectOne("productMapper.getListOptionCount", option);
	}

	public ArrayList<Product> selectOptionPList(SqlSessionTemplate sqlSession, String option, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectOptionPList", option, rowBounds);
	}

	public ArrayList<Files> selectOptionFList(SqlSessionTemplate sqlSession, String option, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectOptionFList", option, rowBounds);
	}
	
	public Product selectProduct(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("productMapper.selectProduct", bNo);
	}
	
	public ArrayList<Files> selectFiles(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("productMapper.selectFiles", bNo);
	}
	
	public int insertProduct(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.insert("productMapper.insertProdcut", p);
	}

	public int insertFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.insert("productMapper.insertFiles", f);
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.update("productMapper.updateBoard", p);
	}
	
	public int updateProduct(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.update("productMapper.updateProduct", p);
	}

	public int updateFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("productMapper.updateFiles", f);
	}
	
	public int deleteProduct(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("productMapper.deleteProduct", bNo);
	}
	
	public int deleteFiles(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("productMapper.deleteFiles", bNo);
	}

	public int getCountCartTotal(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("productMapper.getCountCartTotal", mId);
	}
	
	public int getCountCart(SqlSessionTemplate sqlSession, Cart cart) {
		return sqlSession.selectOne("productMapper.getCountCart", cart);
	}
	
	public ArrayList<Order> selectOrder(SqlSessionTemplate sqlSession, String mId, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectOrders", mId, rowBounds);
	}
	
	public int insertCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.insert("productMapper.insertCart", c);
	}

	public int updateCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.update("productMapper.updateCart", c);
	}
	
	public ArrayList<Cart> selectCart(SqlSessionTemplate sqlSession, String mId) {
		return (ArrayList)sqlSession.selectList("productMapper.selectCart", mId);
	}
	
	public ArrayList<Product> selectPCount(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("productMapper.selectPCount");
	}
	
	public ArrayList<Cart> selectDeleteProduct(SqlSessionTemplate sqlSession, String mId) {
		return (ArrayList)sqlSession.selectList("productMapper.selectDeleteProduct", mId);
	}

	public int deleteCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.update("productMapper.deleteCart", c);
	}

	public int getCountWishTotal(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("productMapper.getCountWishTotal", mId);
	}

	public int getCountWish(SqlSessionTemplate sqlSession, Wish wish) {
		return sqlSession.selectOne("productMapper.getCountWish", wish);
	}

	public int insertWish(SqlSessionTemplate sqlSession, Wish w) {
		return sqlSession.insert("productMapper.insertWish", w);
	}

	public int updateWish(SqlSessionTemplate sqlSession, Wish w) {
		return sqlSession.update("productMapper.updateWish", w);
	}

	public ArrayList<Wish> selectWish(SqlSessionTemplate sqlSession, String mId) {
		return (ArrayList)sqlSession.selectList("productMapper.selectWish", mId);
	}

	public int deleteWish(SqlSessionTemplate sqlSession, Wish w) {
		return sqlSession.update("productMapper.deleteWish", w);
	}

	public Order selectOrder(SqlSessionTemplate sqlSession, Order order) { 
		return sqlSession.selectOne("productMapper.selectOrder", order);
	}
	
	public int getCountReview(SqlSessionTemplate sqlSession, int oId) {
		return sqlSession.selectOne("productMapper.getCountReview", oId);
	}

	public int insertReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.insert("productMapper.insertReview", r);
	}

	public ArrayList<Review> selectReview(SqlSessionTemplate sqlSession, String pName) {
		return (ArrayList)sqlSession.selectList("productMapper.selectReview", pName);
	}
	
	public ArrayList<Files> selectFReview(SqlSessionTemplate sqlSession, String pName) {
		return (ArrayList)sqlSession.selectList("productMapper.selectFReview", pName);
	}
	
	public float selectReviewStar(SqlSessionTemplate sqlSession, String pName) {
		return sqlSession.selectOne("productMapper.selectReviewStar", pName);
	}

	public int deleteRBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("productMapper.deleteRBoard", bNo);
	}
	
	public int deleteReview(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("productMapper.deleteReview", bNo);
	}
	
	public int deleteRFiles(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("productMapper.deleteRFiles", bNo);
	}
	
	public ArrayList<Order> selectOrder(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectOrderAd", null, rowBounds);
	}

	public int updateOrderStatus(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("productMapper.updateOrderStatus", o);
	}

	public int updateDeliveryStatus(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("productMapper.updateDeliveryStatus", o);
	}

	public int insertOrder(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.insert("productMapper.insertOrder", order);
	}

	public int insertOrderDetail(SqlSessionTemplate sqlSession, OrderDetail orderDetail) {
		return sqlSession.insert("productMapper.insertOrderDetail", orderDetail);
	}

	public Cart selectProducts(SqlSessionTemplate sqlSession, Cart cart) {
		return sqlSession.selectOne("productMapper.selectProducts", cart);
	}
	
	public int deleteOrder(SqlSessionTemplate sqlSession, String oNo) {
		return sqlSession.update("productMapper.deleteOrder", oNo);
	}

	public int oNo2bNo(SqlSessionTemplate sqlSession, String oNo) {
		return sqlSession.selectOne("productMapper.oNo2bNo", oNo);
	}

	public int updateOrderSuccess(SqlSessionTemplate sqlSession, String oNo) {
		return sqlSession.update("productMapper.updateOrderSuccess", oNo);
	}

	public int updateProductCount(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("productMapper.updateProductCount", o);
	}

	public int selectProductCount(SqlSessionTemplate sqlSession, int pNo) {
		return sqlSession.selectOne("productMapper.selectProductCount", pNo);
	}

	public int updateProductCountBack(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("productMapper.updateProductCountBack", o);
	}

	public String oNo2userID(SqlSessionTemplate sqlSession, String oNo) {
		return sqlSession.selectOne("productMapper.oNo2userID", oNo);
	}

	public ArrayList<Cart> selectCartOrder(SqlSessionTemplate sqlSession, Cart orderCart) {
		return (ArrayList)sqlSession.selectList("productMapper.selectCartOrder", orderCart);
	}

	//화면에 출력부분
	public ArrayList<Product> selectProductTopList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("productMapper.selectProductTopList");
	}

	public ArrayList<Files> selectFileTopList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("productMapper.selectFileTopList");
	}

	
	public ArrayList<Order> selectOrderAD(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("productMapper.selectOrderAD", null, rowBounds);
	}

	public int oId2bNo(SqlSessionTemplate sqlSession, int oId) {
		return sqlSession.selectOne("productMapper.oId2bNo", oId);
	}

	public String oId2userID(SqlSessionTemplate sqlSession, int oId) {
		return sqlSession.selectOne("productMapper.oId2userID", oId);
	}





}
