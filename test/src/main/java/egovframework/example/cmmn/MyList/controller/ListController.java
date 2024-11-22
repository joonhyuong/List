package egovframework.example.cmmn.MyList.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.cmmn.EgovSampleExcepHndlr;
import egovframework.example.cmmn.MyList.service.ListService;
import egovframework.example.cmmn.MyList.vo.ListVo;
import egovframework.example.cmmn.MyList.vo.Search;

import java.util.Map;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ListController {
	
	private static final Logger logger = LoggerFactory.getLogger(ListController.class);
	
	@Autowired
	private ListService listService;
	
	@RequestMapping(value = "/listDetail.do", method = RequestMethod.POST)
	public String listDetail(@RequestParam("testId") int testId,
							 @RequestParam("password") String password,
							 @RequestParam(value = "editMode", required = false, defaultValue = "false") boolean editMode,
							 RedirectAttributes redirectAttributes,
							 Model model) throws Exception {
		ListVo listVo = listService.selectDetail(testId);
		String hashedPassword = DigestUtils.sha256Hex(password);

		// 비밀번호 검증
		if (!listVo.getPassword().equals(hashedPassword)) {
			redirectAttributes.addFlashAttribute("message", "비밀번호가 일치하지 않습니다.");
			return "redirect:/testList.do"; // 비밀번호 틀리면 목록으로 돌아감
		}

		model.addAttribute("vo", listVo);
		model.addAttribute("editMode", editMode); // 수정 가능 상태로 이동
		return "test/listDetail";  // JSP 뷰 이름
	}
	
	//글 상세 페이지(클릭했을 때)
	@RequestMapping(value="/listDetail.do", method = RequestMethod.GET)
	public String listDetailreadonly(@RequestParam("testId") int testId,
			@RequestParam(value = "editMode", required = false, defaultValue = "false") boolean editMode,
			Model model) throws Exception{
		
		ListVo listVo = listService.selectDetail(testId);
		model.addAttribute("vo", listVo);
		model.addAttribute("editMode", editMode);
		return "test/listDetail";
	}
	
	//글 작성 페이지
	@RequestMapping(value="/listRegister.do")
	public String listRegister() {
		return "test/listRegister";
	}
	
	//글 쓰기
	@RequestMapping(value="/insertList.do", method = RequestMethod.POST)
	public String write(HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception { //@ModelAttribute("listVo") ListVo listVo,
	    // 폼 데이터 직접 확인
		String testTitle = request.getParameter("testTitle");
		String testContent = request.getParameter("testContent");
		String testName = request.getParameter("testName");
		String inputPassword = request.getParameter("password");
	    
		String hashedPassword = DigestUtils.sha256Hex(inputPassword);
	    
		ListVo listVo = new ListVo();
		listVo.setTestTitle(testTitle);
		listVo.setTestContent(testContent);
		listVo.setTestName(testName);
		listVo.setPassword(hashedPassword);
	    

		listService.insertList(listVo);
	    
	    redirectAttributes.addFlashAttribute("message", "게시글이 등록되었습니다.");
	    return "redirect:testList.do";
	}
	
	@RequestMapping(value = "/updateList.do", method = RequestMethod.POST)
	public String updateList(@ModelAttribute ListVo listVo,
	                         RedirectAttributes redirectAttributes) throws Exception {
		// 기존 게시글 정보 확인
		ListVo existingPost = listService.selectDetail(listVo.getTestId());
	    
		if (existingPost.getTestTitle().equals(listVo.getTestTitle()) &&
			existingPost.getTestContent().equals(listVo.getTestContent())) {
			redirectAttributes.addFlashAttribute("message", "수정된 내용이 없습니다.");
			return "redirect:/listDetail.do?testId=" + listVo.getTestId();
		}

		existingPost.setTestTitle(listVo.getTestTitle());
		existingPost.setTestContent(listVo.getTestContent());
		// 비밀번호 검증은 이미 완료
		listService.updateList(existingPost);  // DB 업데이트 실행
	    
		redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");
		return "redirect:/listDetail.do?testId=" + listVo.getTestId(); // 수정된 게시글 보기로 이동
	}

	@RequestMapping(value = "/deleteList.do", method = RequestMethod.POST)
	public String deleteList(@RequestParam("testId") int testId,
							 @RequestParam("password") String password,
							 RedirectAttributes redirectAttributes) throws Exception {
		String hashedPassword = DigestUtils.sha256Hex(password);
		ListVo existingPost = listService.selectDetail(testId);
		logger.debug("Deleting post with testId: " + testId);
		logger.debug("Hashed password from input: " + hashedPassword);

		if (!existingPost.getPassword().equals(hashedPassword)) {
			redirectAttributes.addFlashAttribute("message", "비밀번호가 일치하지 않습니다.");
			return "redirect:/testList.do";
		}

		// Use ListVo to pass the testId and hashedPassword
		ListVo listVo = new ListVo();
		listVo.setTestId(testId);
		listVo.setPassword(hashedPassword);

		listService.deleteList(listVo); // Pass the ListVo object

		redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
		
		return "redirect:/testList.do";
	}
	
	//글 목록 페이지, 페이징, 검색
	@RequestMapping(value="/testList.do")
	public String testListDo(Model model
			,@RequestParam(required=false,defaultValue="1")int page
			,@RequestParam(required=false,defaultValue="1")int range
			,@RequestParam(required=false,defaultValue="testTitle")String searchType
			,@RequestParam(required=false)String keyword
			,@ModelAttribute("search")Search search,
			RedirectAttributes redirectAttributes)throws Exception{
		
		//검색
		model.addAttribute("search", search);
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		//전체 개시글 개수
		int listCnt = listService.getBoardListCnt(search);
		model.addAttribute("totalPosts", listCnt);
		
		if (listCnt == 0) {
			redirectAttributes.addFlashAttribute("message", "검색 결과가 없습니다.");
			return "redirect:/testList.do";
		}
		
		//검색 후 페이지
		search.pageInfo(page, range, listCnt);
		
		//페이징
		model.addAttribute("pagination", search);
		
		List<ListVo> postList = listService.selectList(search);
		
		//최근 게시물에 new 표시 추가
		for (ListVo post : postList) {
			if (post.getTestDate() != null && isRecent(post.getTestDate())) {
				post.setIsNew(true);
			} else {
				post.setIsNew(false);
			}
		}
		
		//게시글 화면 출력
		model.addAttribute("list", postList);
		
		return "test/testList";
	}
	
	//최근 게시물 판단하는 메소드
	private boolean isRecent(java.util.Date postDate) {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime postDateTime = postDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
		
		logger.debug("Current Time: " + now);
		logger.debug("Post Time: " + postDateTime);
		logger.debug("Current Time: " + ChronoUnit.HOURS.between(postDateTime, now));
		
		return ChronoUnit.HOURS.between(postDateTime, now) <= 3; //4시간 이내인지 확인
	}
}
