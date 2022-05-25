package com.naedam.admin.revision.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RevisionDaoImpl implements RevisionDao {
	@Autowired
	private SqlSession session;
}
