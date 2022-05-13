package com.naedam.admin.order.model.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.naedam.admin.option.model.vo.OrderOption;
import com.naedam.admin.order.model.vo.Order;
import com.naedam.admin.order.model.vo.OrderDetail;
import com.naedam.admin.order.model.vo.OrderExcelForm;
import com.naedam.admin.order.model.vo.OrderStatus;

public interface OrderService {

	List<Order> selectOrderList(Map<String, String> param);

	int selectOrderCnt(Map<String, String> param);

	List<OrderStatus> selectOrderStatusList();

	int updateOrderStaus(Map<String, Object> param);

	int updateAdminMemo(Map<String, Object> param);

	OrderDetail selectOneOrderDetailByOrderNo(long orderNo);

	List<OrderOption> selectOrderOptionListByOrderNo(long orderNo);

	int getZipcodeByOrderNo(long orderNo);

	int updateOrderStausAuto(Map<String, String> param);

	String selectOrderStatusNameByOrderNo(String orderNo);

	List<OrderExcelForm> selectOrderExcelForm();

	int deleteOrderByOrderNo(String orderNo);

	int selectTodayOrderCnt();

	int selectMonthOrderCnt();

	List<OrderDetail> selectOrderDetailList();

	OrderStatus selectDashBoardOrderList(Map<String, Object> map);

	

}
