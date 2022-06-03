package com.naedam.admin.contract.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.contract.model.service.ContractService;
import com.naedam.admin.contract.model.vo.Contract;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/contract")
@Slf4j
public class ContractController {
	
	@Autowired
	private ContractService contractService;
	
	@PostMapping("/getContract")
	@ResponseBody
	public Contract getContract(String locale) {
		Contract contract = contractService.selectOneContractByLocale(locale);
		return contract;
	}
	
	@PostMapping("/updateContract")
	public String updateContract(Contract contract, RedirectAttributes redirectAttr) {
		contractService.updateContract(contract);
		redirectAttr.addFlashAttribute("msg", "약관이 수정되었습니다.");
		
		return "redirect: /admin/setting/contract";
	}
}
