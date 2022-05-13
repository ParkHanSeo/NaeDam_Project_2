package com.naedam;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naedam.admin.board.model.service.BoardService;
import com.naedam.admin.board.model.vo.Board;
import com.naedam.admin.member.model.service.MemberService;
import com.naedam.admin.order.model.service.OrderService;
import com.naedam.admin.order.model.vo.OrderDetail;
import com.naedam.admin.order.model.vo.OrderStatus;
import com.naedam.admin.payment.model.service.PaymentService;
import com.naedam.admin.product.model.service.ProductService;
import com.naedam.admin.product.model.vo.ProductDetail;
import com.naedam.admin.statistics.model.service.StatisticsService;
import com.naedam.admin.statistics.model.vo.BeforeYearStatisticVo;
import com.naedam.admin.statistics.model.vo.PeriodStatisticVo;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ProductService productService;
	@Autowired
	private StatisticsService statisticsService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String goIndex(Locale locale, Model model) {
		log.debug("HomeController ---- forward ----> index.jsp");
		// welcompage
		System.out.println("===================Index끝===============");
		return "/admin/index";
	}
	
	@RequestMapping(value = "/admin/dashBoard", method = RequestMethod.GET)
	public String goDashBoard(Locale locale, Model model) throws Exception {
		log.debug("HomeController ---- forward ----> dashBoard");
		Map<String, Integer> counts = new HashMap<String, Integer>();
		counts.put("todayOrderCnt", orderService.selectTodayOrderCnt());
		counts.put("todayPaidCnt", paymentService.selectTodayPaidCnt());
		counts.put("todayPayReadyCnt", paymentService.selectTodayPayReadyCnt());
		counts.put("todayRegMemberCnt", memberService.selectTodayRegMemberCnt());
		counts.put("totalSaleAmountMonth", paymentService.selectTotalSaleAmountMonth());
		counts.put("monthOrderCnt", orderService.selectMonthOrderCnt());
		counts.put("totalCancelAmountMonth", paymentService.selectTotalCancelAmountMonth());
		counts.put("monthCancelCnt", paymentService.selectMonthCancelCnt());
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> periodMonthList = new ArrayList<PeriodStatisticVo>();
		List<BeforeYearStatisticVo> byList = new ArrayList<BeforeYearStatisticVo>();
		BeforeYearStatisticVo by = new  BeforeYearStatisticVo();
		by.setYear(LocalDate.now().toString());
		by.setYearsAgo(LocalDate.now().minusYears(1).toString());
		by.setTwoYearsAgo(LocalDate.now().minusYears(2).toString());
		Calendar cal = Calendar.getInstance();
		int year = LocalDate.now().getYear();
		String month = LocalDate.now().toString().substring(5,7);
		cal.set(year,Integer.parseInt(month),1);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startDate", year+"-"+month+"-0"+cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		map.put("endDate", year+"-"+month+"-"+cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		map.put("by", by);
		List<OrderStatus> orderStatusList = new ArrayList<OrderStatus>();
		for(int i = 1; i <= 7; i++) {
			map.put("code", i);
			OrderStatus orderStatus = orderService.selectDashBoardOrderList(map);
			orderStatusList.add(orderStatus);
		}
		String endDateStr = LocalDate.now().toString().substring(0, 4)+"-12-31";
		String endDateStr2 = LocalDate.now().minusYears(1).toString().substring(0, 4)+"-12-31";
		String endDateStr3 = LocalDate.now().minusYears(2).toString().substring(0, 4)+"-12-31";
		String type = "month";
		GregorianCalendar endDate = strToIntDate(endDateStr, "1");
		GregorianCalendar endDate2 = strToIntDate(endDateStr2, "2");
		GregorianCalendar endDate3 = strToIntDate(endDateStr3, "3");
		param.put("type", "M");
		param.put("by", by);
		for(int i = 0; i < 12; i++) {
			endDate.add(GregorianCalendar.MONTH, -1);
			endDate2.add(GregorianCalendar.MONTH, -1);
			endDate3.add(GregorianCalendar.MONTH, -1);
			param.put("date", endDate.getTime());
			map.put("date",endDate.getTime());
			map.put("date2",endDate2.getTime());
			map.put("date3",endDate3.getTime());
			PeriodStatisticVo statistic = new PeriodStatisticVo();
			BeforeYearStatisticVo statistic2 = new BeforeYearStatisticVo();
			statistic2 = statisticsService.selectBeforeStatisticsList(map);			
			try {
				statistic = statisticsService.selectPeriodStatistics(param);
			} catch (Exception e) {}
			if(statistic == null) {
				statistic = new PeriodStatisticVo();
				statistic.setPaidAt(cal.getTime());
			}
			if(statistic2 == null) {
				statistic2 = new BeforeYearStatisticVo();
				statistic2.setYear("0");
				statistic2.setYearsAgo("0");
				statistic2.setTwoYearsAgo("0");
			}
			periodMonthList.add(statistic);
			byList.add(statistic2);
		}
		Collections.reverse(periodMonthList);
		List<Board> boardList = boardService.getBoardTitle();		
		List<OrderDetail> orderList = orderService.selectOrderDetailList();
		List<ProductDetail> productList = productService.selectAllProductList();
		model.addAttribute("counts", counts);
		model.addAttribute("boardList", boardList);
		model.addAttribute("orderList",orderList);
		model.addAttribute("productList",productList);
		model.addAttribute("periodMonthList", periodMonthList);
		model.addAttribute("orderStatusList", orderStatusList);
		model.addAttribute("byList", byList);
		System.out.println("===================dash끝===============");
		
		return "admin/dashBoard";
	}
	
	private GregorianCalendar strToIntDate(String dateStr, String type){
		int year=0; int month=0; int day = 0;
		if(type.equals("1")) {
			year = Integer.parseInt((dateStr.substring(0, 4)));
			month = Integer.parseInt((dateStr.substring(5, 7))) - 1;
			return new GregorianCalendar(year, month +2, 0);
		}else if(type.equals("2")) {
			year = Integer.parseInt((dateStr.substring(0, 4)));
			month = Integer.parseInt((dateStr.substring(5, 7))) - 1;
			return new GregorianCalendar(year, month +2, 0);
		}else if(type.equals("3")) {
			year = Integer.parseInt((dateStr.substring(0, 4)));
			month = Integer.parseInt((dateStr.substring(5, 7))) - 1;
			return new GregorianCalendar(year, month +2, 0);			
		}
		
		return null;
		
	}
}
