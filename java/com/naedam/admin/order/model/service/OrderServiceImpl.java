package com.naedam.admin.order.model.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.option.model.vo.OrderOption;
import com.naedam.admin.order.model.dao.OrderDao;
import com.naedam.admin.order.model.vo.Order;
import com.naedam.admin.order.model.vo.OrderDetail;
import com.naedam.admin.order.model.vo.OrderExcelForm;
import com.naedam.admin.order.model.vo.OrderStatus;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDao orderDao;

	@Override
	public List<Order> selectOrderList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return orderDao.selectOrderList(param);
	}

	@Override
	public int selectOrderCnt(Map<String, String> param) {
		// TODO Auto-generated method stub
		return orderDao.selectOrderCnt(param);
	}

	@Override
	public List<OrderStatus> selectOrderStatusList() {
		// TODO Auto-generated method stub
		return orderDao.selectOrderStatusList();
	}


	@Override
	public int updateOrderStaus(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return orderDao.updateOrderStaus(param);
	}

	@Override
	public int updateAdminMemo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return orderDao.updateAdminMemo(param);
	}

	@Override
	public OrderDetail selectOneOrderDetailByOrderNo(long orderNo) {
		// TODO Auto-generated method stub
		return orderDao.selectOneOrderDetailByOrderNo(orderNo);
	}

	@Override
	public List<OrderOption> selectOrderOptionListByOrderNo(long orderNo) {
		// TODO Auto-generated method stub
		return orderDao.selectOrderOptionListByOrderNo(orderNo);
	}

	@Override
	public int getZipcodeByOrderNo(long orderNo) {
		// TODO Auto-generated method stub
		return orderDao.getZipcodeByOrderNo(orderNo);
	}

	@Override
	public int updateOrderStausAuto(Map<String, String> param) {
		// TODO Auto-generated method stub
		return orderDao.updateOrderStausAuto(param);
	}

	@Override
	public String selectOrderStatusNameByOrderNo(String orderNo) {
		// TODO Auto-generated method stub
		return orderDao.selectOrderStatusNameByOrderNo(orderNo);
	}

	@Override
	public List<OrderExcelForm> selectOrderExcelForm() {
		// TODO Auto-generated method stub
		return orderDao.selectOrderExcelForm();
	}

	@Override
	public int deleteOrderByOrderNo(String orderNo) {
		// TODO Auto-generated method stub
		return orderDao.deleteOrderByOrderNo(orderNo);
	}

	@Override
	public int selectTodayOrderCnt() {
		// TODO Auto-generated method stub
		return orderDao.selectTodayOrderCnt();
	}

	@Override
	public int selectMonthOrderCnt() {
		// TODO Auto-generated method stub
		return orderDao.selectMonthOrderCnt();
	}

	@Override
	public List<OrderDetail> selectOrderDetailList() {
		// TODO Auto-generated method stub
		return orderDao.selectOrderDetailList();
	}

	@Override
	public OrderStatus selectDashBoardOrderList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.selectDashBoardOrderList(map);
	}


	
	

}
