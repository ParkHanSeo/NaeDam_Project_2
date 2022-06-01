package com.naedam.admin.form.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Item implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int itemNo;
	private Form form;
	private String label;
	private String input_type;
	private String placeholder;
	private String html_id;
	private String html_class;
	private String input_example;
	private String check_type;
	private String is_show;
	private int itemAsc;
}
