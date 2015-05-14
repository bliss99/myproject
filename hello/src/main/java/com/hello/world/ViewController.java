package com.hello.world;

import java.util.List;

import javax.annotation.Resource;

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

@Controller
public class ViewController {

	private static final Logger logger = LoggerFactory.getLogger(ViewController.class);

	// Resource 어노테이션을 이용하여 BbsDao 선언.
    @Resource(name = "bbsDao")
    private BbsDao bbsDao;

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

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public @ResponseBody String procBbsSave(@ModelAttribute("bbsVo") BbsVo bbsVo, RedirectAttributes redirectAttributes) {
        Integer idx = bbsVo.getIdx();

        if (idx == null || idx == 0) {
            this.bbsDao.insert(bbsVo);
            idx = bbsVo.getIdx();
            redirectAttributes.addFlashAttribute("message", "추가되었습니다.");
        }
        return idx+"";
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
