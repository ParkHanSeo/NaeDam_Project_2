package com.naedam.admin.map.model.dao;

import java.util.List;

import com.naedam.admin.map.model.vo.MapApi;
import com.naedam.admin.map.model.vo.Maps;

public interface MapDao {

	Maps selectOneMapByMapNo(int mapNo);

	List<MapApi> selectAllMapApiList();

	int updateMapMyMap(Maps map);

	int insertMap(Maps map);

	int deleteMap(int mapNo);

}
