package com.naedam.admin.contract.model.dao;

import com.naedam.admin.contract.model.vo.Contract;

public interface ContractDao {

	Contract selectOneContractByLocale(String locale);

	int updateContract(Contract contract);

}
