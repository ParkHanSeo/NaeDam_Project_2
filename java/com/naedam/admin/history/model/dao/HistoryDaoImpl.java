package com.naedam.admin.history.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.history.model.vo.History;

@Repository
public class HistoryDaoImpl implements HistoryDao {
	@Autowired
	private SqlSession session;

	@Override
	public History selectOneHistoryByHisNo(int historyNo) {
		// TODO Auto-generated method stub
		return session.selectOne("history.selectOneHistoryByHisNo", historyNo);
	}

	@Override
	public int insertHistory(History history) {
		// TODO Auto-generated method stub
		return session.insert("history.insertHistroy", history);
	}

	@Override
	public int updateHistory(History history) {
		// TODO Auto-generated method stub
		return session.update("history.updateHistory", history);
	}

	@Override
	public int deleteHistory(int historyNo) {
		// TODO Auto-generated method stub
		return session.delete("history.deleteHistory", historyNo);
	}
	
	
}
