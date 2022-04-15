package com.naedam.mir9.banner.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.mir9.banner.model.dao.BannerDao;
import com.naedam.mir9.banner.model.vo.Banner;

@Service
public class BannerServiceImpl implements BannerService {
	@Autowired
	private BannerDao bannerDao;

	@Override
	public Banner selectOneBannerByBannerNo(int bannerNo) {
		// TODO Auto-generated method stub
		return bannerDao.selectOneBannerByBannerNo(bannerNo);
	}
	
	
}
