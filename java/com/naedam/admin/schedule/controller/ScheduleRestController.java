package com.naedam.admin.schedule.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.schedule.model.service.ScheduleService;
import com.naedam.admin.schedule.model.vo.Schedule;

@RestController
@RequestMapping("/admin/schedule/*")
public class ScheduleRestController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@PostMapping(value="json/addSchedule")
	@ResponseBody
	public Boolean addSchedule(@RequestBody Schedule schedule) throws Exception{;
		System.out.println("/json/addSchedule 시작");
		System.out.println("확인 ::: === "+schedule);
		
		Boolean result = false;
		
		if(schedule != null) {
			scheduleService.addSchedule(schedule);
			result = true;
		}
		
		
		return result; 
	}
	
	@GetMapping(value="json/getScheduleList")
	public List getScheduleList() throws Exception{
		System.out.println("/json/getScheduleList 시작");
		
		List<Schedule> list = scheduleService.getScheduleList();
		
		return list;
	}
	
	@PostMapping(value="json/updateSchedule")
	public Boolean updateSchedule(@RequestBody Schedule schedule) throws Exception{
		System.out.println("/json/updateSchedule 시작");
		
		Boolean result = false;
		
		if(schedule != null) {
			scheduleService.updateSchedule(schedule);
			result = true;
		}
		
		return result;
	}
	
	@GetMapping(value="json/deleteSchedule/{scheduleNo}")
	public Boolean deleteSchedule(@PathVariable("scheduleNo") int scheduleNo) throws Exception{
		System.out.println("/json/deleteSchedule 시작");
		
		Boolean result = false;
		if(scheduleNo != 0) {
			scheduleService.deleteSchedule(scheduleNo);
			result = true;
			
		}
		
		return result;
		
	}
	
}






