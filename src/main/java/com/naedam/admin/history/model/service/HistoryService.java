package com.naedam.admin.history.model.service;

import java.util.Map;

import com.naedam.admin.history.model.vo.History;

public interface HistoryService {

	Map<String, Object> historyProcess(Map<String, Object> map) throws Exception;
	
	History selectOneHistoryByHisNo(int historyNo);

	int insertHistory(History history);

	int updateHistory(History history);

	int deleteHistory(int historyNo);

}
