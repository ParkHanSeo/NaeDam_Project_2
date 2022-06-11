package com.naedam.admin.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.schedule.model.service.ScheduleService;
import com.naedam.admin.schedule.model.vo.Schedule;

@RestController
@RequestMapping("/admin/schedule/*")
public class ScheduleRestController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping(value="json/scheduleProcess", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Boolean scheduleProcess(@RequestBody Schedule schedule) throws Exception {
		Boolean result = false;
		Map<String, Object> scheduleMap = new HashMap<>();
		scheduleMap.put("schedule", schedule);
		scheduleService.scheduleProcess(scheduleMap);
		result = true;
		return result;
	}
	
	@GetMapping(value="json/getScheduleList")
	public List getScheduleList() throws Exception{
		System.out.println("/json/getScheduleList 시작");
		List<Schedule> list = scheduleService.getScheduleList();
		return list;
	}
	
}






