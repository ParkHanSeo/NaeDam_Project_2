package com.naedam.admin.banner.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.banner.model.dao.BannerDao;
import com.naedam.admin.banner.model.vo.Banner;

@Service
public class BannerServiceImpl implements BannerService {
	@Autowired
	private BannerDao bannerDao;

	@Override
	public Banner selectOneBannerByBannerNo(int bannerNo) {
		// TODO Auto-generated method stub
		return bannerDao.selectOneBannerByBannerNo(bannerNo);
	}

	@Override
	public int updateBanner(Banner banner) {
		// TODO Auto-generated method stub
		return bannerDao.updateBanner(banner);
	}

	@Override
	public int insertBanner(Banner banner) {
		// TODO Auto-generated method stub
		return bannerDao.insertBanner(banner);
	}

	@Override
	public int deleteBanner(int bannerNo) {
		// TODO Auto-generated method stub
		return bannerDao.deleteBanner(bannerNo);
	}
	
	
}
