package com.kh.green.product.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.green.board.model.vo.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.product.model.vo.Cart;
import com.kh.green.product.model.vo.Order;
import com.kh.green.product.model.vo.OrderDetail;
import com.kh.green.product.model.vo.Product;
import com.kh.green.product.model.vo.Review;
import com.kh.green.product.model.vo.Wish;

public interface ProductService {

	int getListCount();

	ArrayList selectList(int i, PageInfo pi);

	int getListSearchCount(Product p);

	ArrayList<Product> selectSearchPList(Product p, PageInfo pi);
	
	ArrayList<Files> selectSearchFList(Product p, PageInfo pi);
	
	int getListOptionCount(String option);

	ArrayList<Product> selectOptionPList(String option, PageInfo pi);

	ArrayList<Files> selectOptionFList(String option, PageInfo pi);

	Product selectProduct(int bNo);
	
	ArrayList<Files> selectFiles(int bNo);
	
	int insertProduct(Product p);

	int insertFiles(Files f);
	
	int updateBoard(Product p);
	
	int updateProduct(Product p);
	
	int updateFiles(Files f);
	
	int deleteProduct(int bNo);

	int deleteFiles(int bNo);
	
	int getCountCartTotal(String mId);
	
	int getCountCart(Cart c);
	
	ArrayList<Order> selectOrder(String mId, PageInfo pi);
	
	int insertCart(Cart c);

	ArrayList<Cart> selectCart(String mId);

	ArrayList<Product> selectPCount();
	
	ArrayList<Cart> selectDeleteProduct(String mId);
	
	int updateCart(Cart c);

	int deleteCart(Cart c);

	int getCountWishTotal(String mId);

	int getCountWish(Wish wish);

	int insertWish(Wish w);

	int updateWish(Wish w);

	ArrayList<Wish> selectWish(String mId);

	int deleteWish(Wish w);

	Order selectOrder(Order order);
	
	int getCountReview(int oId);

	int insertReview(Review r);

	ArrayList<Review> selectReview(String pName);
	
	ArrayList<Files> selectFReview(String pName);
	
	float selectReviewStar(String pName);
	
	int deleteRBoard(int bNo);

	int deleteReview(int bNo);
	
	int deleteRFiles(int bNo);
	
	ArrayList<Order> selectOrder(PageInfo pi);

	int updateOrderStatus(Order o);

	int updateDeliveryStatus(Order o);

	int insertOrder(Order order);

	int insertOrderDetail(OrderDetail orderDetail);

	Cart selectProducts(Cart cart);
	
	int deleteOrder(String oNo);

	int oNo2bNo(String oNo);

	int updateOrderSuccess(String oNo);

	int updateProductCount(Order o);

	int selectProductCount(int i);

	int updateProductCountBack(Order o);

	String oNo2userID(String oNo);

	ArrayList<Cart> selectCartOrder(Cart orderCart);

	ArrayList<Product> selectProductTopList();

	 ArrayList<Files> selectFileTopList(); 

	ArrayList<Order> selectOrderAD(PageInfo pi);

	int oId2bNo(int oId);

	String oId2userID(int oId);













}
