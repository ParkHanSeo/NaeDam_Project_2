package com.naedam.admin.contract.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.contract.model.dao.ContractDao;
import com.naedam.admin.contract.model.vo.Contract;

@Service
public class ContractServiceImpl implements ContractService {
	@Autowired
	private ContractDao contractDao;

	@Override
	public Contract selectOneContractByLocale(String locale) {
		// TODO Auto-generated method stub
		return contractDao.selectOneContractByLocale(locale);
	}

	@Override
	public int updateContract(Contract contract) {
		// TODO Auto-generated method stub
		return contractDao.updateContract(contract);
	}
	
	
}
