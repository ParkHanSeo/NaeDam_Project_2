package com.naedam.admin.menu.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.menu.model.dao.MenuDao;
import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Head;
import com.naedam.admin.menu.model.vo.Menu;
import com.naedam.admin.menu.model.vo.Meta;

@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	private MenuDao menuDao;
	//메뉴관리 프로세서
	public String menuProcess(Map<String, Object> map) throws Exception{
		if("menu".equals(map.get("part"))) {
			Menu menu = (Menu) map.get("menu");
			if("insert".equals(map.get("mode"))) {
				menuDao.addMenu(menu);
			}else if("update".equals(map.get("mode"))) {
				Menu revisionMenu = new Menu();
				revisionMenu = menuDao.getRevision(menu);
				revisionMenu.setOriginNo(menu.getCode());
				menuDao.addRevision(revisionMenu);
				menuDao.updateMenu(menu);
			}else if("delete".equals(map.get("mode"))) {
				List<Integer> menuArr = (List<Integer>) map.get("menuArr");
				menuDao.updateChoiceMenu(menuArr);
			}
			return "redirect:/admin/menu/menu";
		}else if("head".equals(map.get("part"))) {
			Head head = (Head) map.get("head");
			if("insert".equals(map.get("mode"))) {
				menuDao.addHead(head);
			}else if("update".equals(map.get("mode"))) {
				menuDao.updateHead(head);
			}else if("delete".equals(map.get("mode"))) {
				List<Integer> headArr = (List<Integer>) map.get("menuArr");
				menuDao.deleteChoiceHead(headArr);
			}
			return "redirect:/admin/menu/headList";
		}else if("bottom".equals(map.get("part"))) {
			Bottom bottom = (Bottom) map.get("bottom");
			if("update".equals(map.get("mode"))) {
				menuDao.updateBottom(bottom);
			}
			return "redirect:/admin/menu/bottomList";
		}else if("meta".equals(map.get("part"))) {
			Meta meta = (Meta) map.get("meta");
			if("update".equals(map.get("mode"))) {
				menuDao.updateMeta(meta);
			}
		}else if("revision".equals(map.get("part"))) {
			List<String> menuArr = (List<String>) map.get("menuArr");
			if("delete".equals(map.get("mode"))) {
				for(String i : menuArr) {
					menuDao.deleteMenu(Integer.parseInt(i));
				}				
			}else if("update".equals(map.get("mode"))) {
				for(String i : menuArr) {
					menuDao.updateRevision(Integer.parseInt(i));
				}
			}
		}
		return null;
	}
	//헤더관리 등록
	@Override
	public int addRevision(Menu menu) throws Exception {
		return menuDao.addRevision(menu);
	}
	
	//메뉴 리스트 출력
	@Override
	public Map<String, Object> getMenuList(Map<String,Object> map) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuList(map));
		resultMap.put("list2", menuDao.getHeadList(map));
		return resultMap;
	}
	
	//조건식 메뉴 리스트 출력
	@Override
	public Map<String, Object> getMenuList2(Map<String,Object> map) throws Exception{
		Menu menu = (Menu) map.get("menu");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(menu.getOrd() == 2) {
			resultMap.put("list", menuDao.getMenuList2(map));
			resultMap.put("list2", menuDao.getHeadList(map));
		}else if(menu.getOrd() == 3) {
			resultMap.put("list", menuDao.getMenuList3(map));
			resultMap.put("list2", menuDao.getHeadList(map));
		}
		return resultMap;
	}	
	
	//조건식 메뉴 리스트 출력2
	@Override
	public Map<String, Object> getMenuList3(Map<String,Object> map) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuList3(map));
		
		return resultMap;
	}	
	
	//리비젼 리스트
	@Override
	public Map<String, Object> getRevisionList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getRevisionList(map));
		
		return resultMap;
	}

	//삭제된 리비젼 리스트
	@Override
	public Map<String, Object> deleteRevisionList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.deleteRevisionList(map));
		
		return resultMap;
	}
	
	//헤더관리 리스트
	@Override
	public Map<String, Object> getHeadList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getHeadList(map));
		
		return resultMap;
	}
	
	//메뉴카테고리 리스트
	@Override
	public Map<String, Object> getMenuCategoryList(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuCategoryList(map));
		resultMap.put("list2", menuDao.getMenuCategoryList2(map));
		return resultMap;
	}
	
	//메뉴카테고리 리스트2
	@Override
	public Map<String, Object> getMenuCategoryList2(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", menuDao.getMenuCategoryList2(map));
		
		return resultMap;
	}	
	
	//메뉴 정보
	@Override
	public Menu getMenu(int code) throws Exception {
		return menuDao.getMenu(code);
	}
	
	//헤더 정보
	@Override
	public Head getHead(int headNo) throws Exception {
		return menuDao.getHead(headNo);
	}
	
	//하단 정보
	@Override
	public Bottom getBottom() throws Exception {
		return menuDao.getBottom();
	}
	
	//메타 정보
	@Override
	public Meta getMeta() throws Exception {
		return menuDao.getMeta();
	}
	
	//리비젼 가져오기
	@Override
	public Menu getRevision(Menu menu) throws Exception {
		return menuDao.getRevision(menu);
	}
	
	//삭제 리비전 복구
	@Override
	public void updateRevision(int code) throws Exception {
		menuDao.updateRevision(code);
	}

	//리비젼의 메뉴 삭제
	@Override
	public void deleteMenu(int code) throws Exception {
		menuDao.deleteMenu(code);
	}

	//메뉴 down순서변경
	@Override
	public void updateDownAsc(Map<String, Object> map) throws Exception {
		menuDao.updateDownAsc(map);
	}

	//메뉴 up순서변경
	@Override
	public void updateUpAsc(Map<String, Object> map) throws Exception {
		menuDao.updateUpAsc(map);
	}
	
	//헤드 down순서변경
	@Override
	public void updateHeadDownAsc(Map<String, Object> map) throws Exception {
		menuDao.updateHeadDownAsc(map);
	}

	//헤드 up순서변경
	@Override
	public void updateHeadUpAsc(Map<String, Object> map) throws Exception {
		menuDao.updateHeadUpAsc(map);
	}	
	
}
