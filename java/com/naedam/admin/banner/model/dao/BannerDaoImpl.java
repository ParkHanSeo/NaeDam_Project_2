package com.naedam.admin.banner.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.banner.model.vo.Banner;

@Repository
public class BannerDaoImpl implements BannerDao {
	@Autowired
	private SqlSession session;

	@Override
	public Banner selectOneBannerByBannerNo(int bannerNo) {
		// TODO Auto-generated method stub
		return session.selectOne("banner.selectOneBannerByBannerNo", bannerNo);
	}

	@Override
	public int updateBanner(Banner banner) {
		// TODO Auto-generated method stub
		return session.update("banner.updateBanner", banner);
	}

	@Override
	public int insertBanner(Banner banner) {
		// TODO Auto-generated method stub
		return session.insert("banner.insertBanner", banner);
	}

	@Override
	public int deleteBanner(int bannerNo) {
		// TODO Auto-generated method stub
		return session.delete("banner.deleteBanner", bannerNo);
	}
	
	
}
