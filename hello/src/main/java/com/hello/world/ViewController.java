package com.hello.world;

import java.util.Enumeration;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hello.world.dao.BbsDao;
import com.hello.world.dao.BbsVo;
import com.hello.world.dao.ProveDao;
import com.hello.world.dao.ProveVo;

@Controller
public class ViewController {

	private static final Logger logger = LoggerFactory.getLogger(ViewController.class);

    @Resource(name = "bbsDao")
    private BbsDao bbsDao;
    
    @Resource(name = "proveDao")
    private ProveDao proveDao;

    // 게시판 목록
    @RequestMapping(value = "/bbs", method = RequestMethod.GET)
    public String dispBbsList(Model model) {
        logger.info("display view BBS list");
        List<BbsVo> list = this.bbsDao.getSelect();
        model.addAttribute("list", list);

        logger.info("totcal count" + list.size() );

        return "bbs/list";
    }

    // 게시판 상세보
    // PathVariable 어노테이션을 이용하여 RESTful 방식 적용
    // bbs/1 -> id = 1; id = 게시물 번호로 인식함.
    // 일반 적으로 (@ReuqstParam(value = "bbsVo", required = false, defaultValue = "0"), int idx, Model model)
    @RequestMapping("/{idx}")
    public String dispBbsView(@PathVariable int idx, Model model) {
        logger.info("display view BBS view idx = {}", idx);
        BbsVo object = this.bbsDao.getSelectOne(idx);

        String cont = object.getContent();
        
        //String s = "(?i)\\b((?:https?://|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]))";

        String str = "\\{{2}([0-9])\\}";
        Pattern patt = Pattern.compile(str);
        Matcher matcher = patt.matcher(cont);
        cont = matcher.replaceAll("<a href=\"javascript:fnOpenProve($1)\">");
        
        object.setContent(cont.replaceAll("\\{[0-9]\\}{2}", "</a>"));
        
        model.addAttribute("object", object);
        return "bbs/view";
    }

    // 게시판 쓰기
    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String dispBbsWrite(@RequestParam(value="idx", defaultValue="0") int idx, Model model) {
        logger.info("display view BBS write");

        if (idx > 0) {
            BbsVo object = this.bbsDao.getSelectOne(idx);
            model.addAttribute("object", object);
        }

        return "bbs/write";
    }
    
    // 찬성
    @RequestMapping(value = "/writeAgree", method = RequestMethod.GET)
    public String dispBbsWriteAgree(@RequestParam(value="idx", defaultValue="0") int idx, Model model) {
    	if (idx > 0) {
    		BbsVo object = this.bbsDao.getSelectOne(idx);
    		
    		String cont = object.getContent();
    		String str = "\\{{2}([0-9])\\}";
	        Pattern patt = Pattern.compile(str);
	        Matcher matcher = patt.matcher(cont);
	        cont = matcher.replaceAll("<a href=\"javascript:fnOpenProve($1)\">");
	        object.setContent(cont.replaceAll("\\{[0-9]\\}{2}", "</a>"));
	        
    		model.addAttribute("other", object);
    	}
    	model.addAttribute("opinion", "1");
    	
    	return "bbs/writeOpinion";
    }
    
    // 반대
    @RequestMapping(value = "/writeOppose", method = RequestMethod.GET)
    public String dispBbsWriteOppose(@RequestParam(value="idx", defaultValue="0") int idx, Model model) {
    	if (idx > 0) {
    		BbsVo object = this.bbsDao.getSelectOne(idx);
    		
    		String cont = object.getContent();
    		String str = "\\{{2}([0-9])\\}";
	        Pattern patt = Pattern.compile(str);
	        Matcher matcher = patt.matcher(cont);
	        cont = matcher.replaceAll("<a href=\"javascript:fnOpenProve($1)\">");
	        object.setContent(cont.replaceAll("\\{[0-9]\\}{2}", "</a>"));
	        
    		model.addAttribute("other", object);
    	}
    	model.addAttribute("opinion", "2");
    	
    	return "bbs/writeOpinion";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public @ResponseBody String procBbsSave(@ModelAttribute("bbsVo") BbsVo bbsVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        Integer idx = bbsVo.getIdx();

        this.bbsDao.insert(bbsVo);
        idx = bbsVo.getIdx();
        
        Enumeration<String> en = request.getParameterNames();
        
        ProveVo proveVo = new ProveVo();
        proveVo.setIdx(idx);
        while(en.hasMoreElements()){
        	String nm = en.nextElement();
        	if(nm.indexOf("prove_seq")>-1){
        		String prove_seq = request.getParameter(nm);
        		String num = nm.replaceAll("prove_seq", "");
        		proveVo.setSeq(Integer.parseInt(prove_seq));
        		proveVo.setNum(Integer.parseInt(num));
        		proveDao.updateIdx(proveVo);
        	}
        }
        
        redirectAttributes.addFlashAttribute("message", "추가되었습니다.");

        return idx+"";
    }
    
    @RequestMapping(value = "/saveProveTemp", method = RequestMethod.POST)
    public @ResponseBody String saveProveTemp(@ModelAttribute("proveVo") ProveVo proveVo, RedirectAttributes redirectAttributes) {
   		this.proveDao.insert(proveVo);
    	return proveVo.getSeq()+"";
    }
    
    @RequestMapping(value = "/getProve")
    public @ResponseBody ProveVo getProve(@RequestParam(value = "seq", required = false) int seq)  throws Exception{
        logger.info("display prove seq = {}", seq);
        ProveVo object = this.proveDao.getSelectOne(seq);

        return object;
    }
    
    @RequestMapping(value = "/getProve2")
    public @ResponseBody ProveVo getProve2(@ModelAttribute("proveVo") ProveVo proveVo)  throws Exception{
    	ProveVo object = this.proveDao.getSelectOneByNum(proveVo);
    	
    	return object;
    }
    
    @RequestMapping(value = "/write_ok", method = RequestMethod.POST)
    public String procBbsWrite(@ModelAttribute("bbsVo") BbsVo bbsVo, RedirectAttributes redirectAttributes) {
    	Integer idx = bbsVo.getIdx();
    	
    	if (idx == null || idx == 0) {
    		this.bbsDao.insert(bbsVo);
    		redirectAttributes.addFlashAttribute("message", "추가되었습니다.");
    		return "redirect:/bbs.bn";
    	} else {
    		this.bbsDao.update(bbsVo);
    		redirectAttributes.addFlashAttribute("message", "수정되었습니다.");
    		return "redirect:/write.bn?idx=" + idx;
    	}
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String procBbsDelete(@RequestParam(value = "idx", required = false) int idx) {
        this.bbsDao.delete(idx);
        return "redirect:/bbs.bn";
    }
}
