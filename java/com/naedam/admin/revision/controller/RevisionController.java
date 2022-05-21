package com.naedam.admin.revision.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.revision.model.service.RevisionService;

@Controller
@RequestMapping("/admin/revision")
public class RevisionController {
	@Autowired
	private RevisionService revisionService;
}
