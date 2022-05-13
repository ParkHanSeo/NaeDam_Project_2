package com.naedam.admin.history.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.history.model.dao.HistoryDao;
import com.naedam.admin.history.model.vo.History;

@Service
public class HistoryServiceImpl implements HistoryService {
	@Autowired
	private HistoryDao historyDao;

	@Override
	public History selectOneHistoryByHisNo(int historyNo) {
		// TODO Auto-generated method stub
		return historyDao.selectOneHistoryByHisNo(historyNo);
	}

	@Override
	public int insertHistory(History history) {
		// TODO Auto-generated method stub
		return historyDao.insertHistory(history);
	}

	@Override
	public int updateHistory(History history) {
		// TODO Auto-generated method stub
		return historyDao.updateHistory(history);
	}

	@Override
	public int deleteHistory(int historyNo) {
		// TODO Auto-generated method stub
		return historyDao.deleteHistory(historyNo);
	}
	
	
}
