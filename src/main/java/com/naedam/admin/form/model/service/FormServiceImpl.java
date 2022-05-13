package com.naedam.admin.form.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.form.model.dao.FormDao;

@Service
public class FormServiceImpl implements FormService {
	@Autowired
	private FormDao formDao;
}
