package com.naedam.admin.order.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.option.model.vo.OrderOption;
import com.naedam.admin.order.model.vo.Order;
import com.naedam.admin.order.model.vo.OrderDetail;
import com.naedam.admin.order.model.vo.OrderExcelForm;
import com.naedam.admin.order.model.vo.OrderStatus;

@Repository
public class OrderDaoImpl implements OrderDao {
	@Autowired
	private SqlSession session;

	@Override
	public List<Order> selectOrderList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderList", param);
	}

	@Override
	public int selectOrderCnt(Map<String, String> param) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderCnt",param);
	}

	@Override
	public List<OrderStatus> selectOrderStatusList() {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderStatusList");
	}

	@Override
	public int updateOrderStaus(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.update("order.updateOrderStaus", param);
	}

	@Override
	public int updateAdminMemo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.update("order.updateAdminMemo", param);
	}

	@Override
	public OrderDetail selectOneOrderDetailByOrderNo(long orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOneOrderDetailByOrderNo", orderNo);
	}

	@Override
	public List<OrderOption> selectOrderOptionListByOrderNo(long orderNo) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderOptionListByOrderNo",orderNo);
	}

	@Override
	public int getZipcodeByOrderNo(long orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.getZipcodeByOrderNo", orderNo);
	}

	@Override
	public int updateOrderStausAuto(Map<String, String> param) {
		// TODO Auto-generated method stub
		return session.update("order.updateOrderStausAuto", param);
	}

	@Override
	public String selectOrderStatusNameByOrderNo(String orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderStatusNameByOrderNo", orderNo);
	}

	@Override
	public List<OrderExcelForm> selectOrderExcelForm() {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderExcelForm");
	}

	@Override
	public int deleteOrderByOrderNo(String orderNo) {
		// TODO Auto-generated method stub
		return session.delete("order.deleteOrderByOrderNo", orderNo);
	}

	@Override
	public int selectTodayOrderCnt() {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectTodayOrderCnt");
	}

	@Override
	public int selectMonthOrderCnt() {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectMonthOrderCnt");
	}

	@Override
	public List<OrderDetail> selectOrderDetailList() {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderDetailList");
	}

	@Override
	public OrderStatus selectDashBoardOrderList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectDashBoardOrderList", map);
	}


	

	
}
