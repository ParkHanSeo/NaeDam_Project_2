package com.naedam.admin.contract.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.contract.model.vo.Contract;

@Repository
public class ContractDaoImpl implements ContractDao {
	@Autowired
	private SqlSession session;

	@Override
	public Contract selectOneContractByLocale(String locale) {
		// TODO Auto-generated method stub
		return session.selectOne("contract.selectOneContractByLocale", locale);
	}

	@Override
	public int updateContract(Contract contract) {
		// TODO Auto-generated method stub
		return session.update("contract.updateContract", contract);
	}
	
	
}
