package com.naedam.admin.statistics.model.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AddressStatisticVo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private LocalDate paidAt;
	private int addressCategory;
	private int paymentSum;
	private int returnSum;
	private int amount;
	private String buyerAddr;
	private String productName;
	private int orderStatusNo;
	private int seoul;
	private int seoulReturn;
	private int busan;
	private int busanReturn;
	private int incheon;
	private int incheonReturn;
	private int daegu;
	private int daeguReturn;
	private int gwangju;
	private int gwangjuReturn;
	private int daejeon;
	private int daejeonReturn;
	private int ulsan;
	private int ulsanReturn;
	private int sejong;
	private int sejongReturn;
	private int gyeonggi;
	private int gyeonggiReturn;
	private int gangwon;
	private int gangwonReturn;
	private int chungbuk;
	private int chungbukReturn;
	private int chungnam;
	private int chungnamReturn;
	private int jeonbuk;
	private int jeonbukReturn;
	private int jeonnam;
	private int jeonnamReturn;
	private int gyeongbuk;
	private int gyeongbukReturn;
	private int gyeongnam;
	private int gyeongnamReturn;
	private int jeju;
	private int jejuReturn;
	
}

