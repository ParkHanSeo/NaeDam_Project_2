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

	//일정관리 프로세서
	public String scheduleProcess(Map<String, Object> map) throws Exception{
		Schedule schedule = (Schedule) map.get("schedule");
		if("insert".equals(schedule.getScheduleMode())) {
			scheduleDao.addSchedule(schedule);
		}else if("update".equals(schedule.getScheduleMode())) {
			scheduleDao.updateSchedule(schedule);
		}else if("delete".equals(schedule.getScheduleMode())) {
			scheduleDao.deleteSchedule(schedule.getScheduleNo());
		}
		
		
		return "";
	}
	
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

