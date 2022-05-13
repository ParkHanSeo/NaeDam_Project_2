package com.naedam.admin.management.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.management.model.dao.ManagementDao;

@Service
public class ManagementServiceImpl implements ManagementService {
	@Autowired
	private ManagementDao ManagementDao;
}
