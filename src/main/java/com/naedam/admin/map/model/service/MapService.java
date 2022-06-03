package com.naedam.admin.map.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.map.model.vo.MapApi;
import com.naedam.admin.map.model.vo.Maps;

public interface MapService {
	
	Map<String, Object> mapProcess(Map<String, Object> map);
	
	Maps selectOneMapByMapNo(int mapNo);

	List<MapApi> selectAllMapApiList();

	int updateMapByMap(Maps map);

	int insertMap(Maps map);

	int deleteMap(int mapNo);

}
