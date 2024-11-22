package egovframework.example.cmmn.MyList.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import egovframework.example.cmmn.MyList.vo.Search;
import egovframework.example.cmmn.MyList.vo.ListVo;

@Mapper
public interface ListDao {
	public List<ListVo> selectList(Search search) throws Exception;

	public void insertList(ListVo listVo) throws Exception;
	
	public ListVo selectDetail(int testId) throws Exception;
	
	public void updateList(ListVo listVo) throws Exception;
	
	public void deleteList(ListVo listVo) throws Exception;
	
	public int getBoardListCnt(Search search) throws Exception;
	
}
