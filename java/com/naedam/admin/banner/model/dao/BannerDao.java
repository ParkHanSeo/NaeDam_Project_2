package com.naedam.admin.banner.model.dao;

import com.naedam.admin.banner.model.vo.Banner;

public interface BannerDao {

	Banner selectOneBannerByBannerNo(int bannerNo);

	int updateBanner(Banner banner);

	int insertBanner(Banner banner);

	int deleteBanner(int bannerNo);

}
