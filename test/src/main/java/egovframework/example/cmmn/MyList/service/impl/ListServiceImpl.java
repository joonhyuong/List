package egovframework.example.cmmn.MyList.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import egovframework.example.cmmn.MyList.vo.Search;
import egovframework.example.cmmn.MyList.dao.ListDao;
import egovframework.example.cmmn.MyList.service.ListService;
import egovframework.example.cmmn.MyList.vo.ListVo;

@Service 
public class ListServiceImpl implements ListService{
	@Autowired
	private ListDao listDao;
	
	@Override
	public List<ListVo> selectList(Search search) throws Exception {
		return listDao.selectList(search);
	}
	
	@Override
	public void insertList(ListVo listVo) throws Exception {
		listDao.insertList(listVo);
	}
	
	@Override
	public ListVo selectDetail(int testId) throws Exception {
		return listDao.selectDetail(testId);
	}
	
	@Override
	public void updateList(ListVo listVo) throws Exception {
		listDao.updateList(listVo);
	}
	
	@Override
	public void deleteList(ListVo listVo) throws Exception {
		listDao.deleteList(listVo);
	}
	
	@Override
	public int getBoardListCnt(Search search) throws Exception {
		return listDao.getBoardListCnt(search);
	}
	
}
