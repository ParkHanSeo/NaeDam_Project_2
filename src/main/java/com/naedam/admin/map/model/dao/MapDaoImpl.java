package com.naedam.admin.map.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.map.model.vo.MapApi;
import com.naedam.admin.map.model.vo.Maps;

@Repository
public class MapDaoImpl implements MapDao {
	@Autowired
	private SqlSession session;

	@Override
	public Maps selectOneMapByMapNo(int mapNo) {
		// TODO Auto-generated method stub
		return session.selectOne("map.selectOneMapByMapNo", mapNo);
	}

	@Override
	public List<MapApi> selectAllMapApiList() {
		// TODO Auto-generated method stub
		return session.selectList("map.selectAllMapApiList");
	}

	@Override
	public int updateMapMyMap(Maps map) {
		// TODO Auto-generated method stub
		return session.update("map.updateMapMyMap", map);
	}

	@Override
	public int insertMap(Maps map) {
		// TODO Auto-generated method stub
		return session.insert("map.insertMap", map);
	}

	@Override
	public int deleteMap(int mapNo) {
		// TODO Auto-generated method stub
		return session.delete("map.deleteMap", mapNo);
	}
	
	
	
	
	
}
