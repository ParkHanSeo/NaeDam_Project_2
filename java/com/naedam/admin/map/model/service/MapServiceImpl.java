package com.naedam.admin.map.model.service;

import java.util.List;

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
