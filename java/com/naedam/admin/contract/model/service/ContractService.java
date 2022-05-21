package com.naedam.admin.contract.model.service;

import com.naedam.admin.contract.model.vo.Contract;

public interface ContractService {

	Contract selectOneContractByLocale(String locale);

	int updateContract(Contract contract);

}
