package com.naedam.admin.banner.model.service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.banner.model.dao.BannerDao;
import com.naedam.admin.banner.model.vo.Banner;

@Service
public class BannerServiceImpl implements BannerService {
	@Autowired
	private BannerDao bannerDao;

	@Override
	public Map<String, Object> bannerProcess(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();
		Banner banner = (Banner) map.get("banner");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		if("insert".equals(map.get("mode"))) {
			bannerDao.insertBanner(banner);
			resultMap.put("msg", "배너 정보가 등록되었습니다.");
		}else if("update".equals(map.get("mode"))) {
			bannerDao.updateBanner(banner);
			resultMap.put("msg", "팝업 정보가 수정되었습니다.");
		}else if("delete".equals(map.get("mode"))) {
			List<String> bannerNoList = Arrays.asList(request.getParameterValues("list[]"));
			for(String no : bannerNoList) {
				bannerDao.deleteBanner(Integer.parseInt(no));
				resultMap.put("msg", "배너가 삭제 되었습니다.");
			}
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectOneBannerByBannerNo(int bannerNo) {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();
		if(bannerNo == 0) {
			resultMap.put("url", "http://fs.joycity.com/web/images/common/fs1_er.png");
		}else {
			resultMap.put("url", bannerDao.selectOneBannerByBannerNo(bannerNo).getImgUrl());
		}
		resultMap.put("banner", bannerDao.selectOneBannerByBannerNo(bannerNo));
		return resultMap;
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
