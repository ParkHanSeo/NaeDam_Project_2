package com.naedam.admin.map.model.service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.map.model.dao.MapDao;
import com.naedam.admin.map.model.vo.MapApi;
import com.naedam.admin.map.model.vo.Maps;

@Service
public class MapServiceImpl implements MapService {
	
	@Autowired
	private MapDao mapDao;

	@Override
	public Map<String, Object> mapProcess(Map<String, Object> param) {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();
		Maps map = (Maps) param.get("map");
		HttpServletRequest request = (HttpServletRequest) param.get("request");
		if("insert".equals(param.get("mode"))) {
			mapDao.insertMap(map);
			resultMap.put("msg", "약도가 생성되었습니다.");
		}else if("update".equals(param.get("mode"))) {
			mapDao.updateMapMyMap(map);
			resultMap.put("msg", "약도 정보가 수정되었습니다.");
		}else if("delete".equals(param.get("mode"))) {
			List<String> mapNoList = Arrays.asList(request.getParameterValues("list[]"));
			for(String mapNo : mapNoList) {
				mapDao.deleteMap(Integer.parseInt(mapNo));
			}
			resultMap.put("msg", "약도가 삭제되었습니다.");
		}
		return resultMap;
	}
	
	@Override
	public Maps selectOneMapByMapNo(int mapNo) {
		// TODO Auto-generated method stub
		return mapDao.selectOneMapByMapNo(mapNo);
	}

	@Override
	public List<MapApi> selectAllMapApiList() {
		// TODO Auto-generated method stub
		return mapDao.selectAllMapApiList();
	}

	@Override
	public int updateMapByMap(Maps map) {
		// TODO Auto-generated method stub
		return mapDao.updateMapMyMap(map);
	}

	@Override
	public int insertMap(Maps map) {
		// TODO Auto-generated method stub
		return mapDao.insertMap(map);
	}

	@Override
	public int deleteMap(int mapNo) {
		// TODO Auto-generated method stub
		return mapDao.deleteMap(mapNo);
	}


	
	
	
}
