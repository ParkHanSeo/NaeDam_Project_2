package com.naedam.admin.map.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MapApi implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int mapApiNo;
	private String mapApiName;

}
