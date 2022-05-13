package com.naedam.admin.revision.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.revision.model.dao.RevisionDao;

@Service
public class RevisionServiceImpl implements RevisionService {
	@Autowired
	private RevisionDao revisionDao;
}
