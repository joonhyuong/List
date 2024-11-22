package egovframework.example.cmmn.MyList.service;

import java.util.List;

import egovframework.example.cmmn.MyList.vo.Search;
import egovframework.example.cmmn.MyList.vo.ListVo;

public interface ListService {
	public List<ListVo> selectList(Search search) throws Exception;
	
	public void insertList(ListVo listVo) throws Exception;
	
	public ListVo selectDetail(int testId) throws Exception;
	
	public void updateList(ListVo listVo) throws Exception;
	
	public void deleteList(ListVo listVo) throws Exception;
	
	public int getBoardListCnt(Search search) throws Exception;
	
}
