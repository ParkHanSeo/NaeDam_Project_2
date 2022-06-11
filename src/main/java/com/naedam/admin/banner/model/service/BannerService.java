package com.naedam.admin.banner.model.service;

import java.util.Map;

import com.naedam.admin.banner.model.vo.Banner;

public interface BannerService {

	Map<String, Object> bannerProcess(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectOneBannerByBannerNo(int bannerNo);

	int updateBanner(Banner banner);

	int insertBanner(Banner banner);

	int deleteBanner(int bannerNo);

}
