package com.naedam.admin.management.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ManagementDaoImpl implements ManagementDao {
	@Autowired
	private SqlSession session;
}
