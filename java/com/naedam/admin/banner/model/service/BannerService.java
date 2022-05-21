package com.naedam.admin.banner.model.service;

import com.naedam.admin.banner.model.vo.Banner;

public interface BannerService {

	Banner selectOneBannerByBannerNo(int bannerNo);

	int updateBanner(Banner banner);

	int insertBanner(Banner banner);

	int deleteBanner(int bannerNo);

}
