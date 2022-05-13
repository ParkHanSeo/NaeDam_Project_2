package com.naedam.admin.map.model.service;

import java.util.List;

import com.naedam.admin.map.model.vo.MapApi;
import com.naedam.admin.map.model.vo.Maps;

public interface MapService {

	Maps selectOneMapByMapNo(int mapNo);

	List<MapApi> selectAllMapApiList();

	int updateMapByMap(Maps map);

	int insertMap(Maps map);

	int deleteMap(int mapNo);

}
