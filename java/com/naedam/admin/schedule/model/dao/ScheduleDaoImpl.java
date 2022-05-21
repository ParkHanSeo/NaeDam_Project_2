package com.naedam.admin.schedule.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.naedam.admin.schedule.model.vo.Schedule;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//일정 등록
	@Override
	public int addSchedule(Schedule schedule) throws Exception {
		return sqlSession.insert("schedule.addSchedule", schedule);
	}
	
	//일정 리스트
	@Override
	public List<Schedule> getScheduleList() throws Exception {
		return sqlSession.selectList("schedule.getScheduleList");
	}
	
	//일정 데이터
	@Override
	public int getSchedule(int scheduleNo) throws Exception {
		return sqlSession.selectOne("schedule.getSchedule", scheduleNo);
	}
	
	//일정 수정
	@Override
	public int updateSchedule(Schedule schedule) throws Exception {
		return sqlSession.update("schedule.updateSchedule", schedule);
	}
	
	//일정 수정
	@Override
	public void deleteSchedule(int scheduleNo) throws Exception {
		sqlSession.delete("schedule.deleteSchedule", scheduleNo);
	}

	

	
	
}
