package com.naedam.admin.schedule.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.schedule.model.dao.ScheduleDao;
import com.naedam.admin.schedule.model.vo.Schedule;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDao scheduleDao;

	@Override
	public int addSchedule(Schedule schedule) throws Exception {
		return scheduleDao.addSchedule(schedule);
	}

	@Override
	public List<Schedule> getScheduleList() throws Exception {
		return scheduleDao.getScheduleList();
	}

	@Override
	public int getSchedule(int scheduleNo) throws Exception {
		return scheduleDao.getSchedule(scheduleNo);
	}

	@Override
	public int updateSchedule(Schedule schedule) throws Exception {
		return scheduleDao.updateSchedule(schedule);
	}

	@Override
	public void deleteSchedule(int scheduleNo) throws Exception {
		scheduleDao.deleteSchedule(scheduleNo);
	}



	
}















