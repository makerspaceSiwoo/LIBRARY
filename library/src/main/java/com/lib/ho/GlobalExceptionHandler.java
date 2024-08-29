package com.lib.ho;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception exception, Model model, RedirectAttributes redirectAttributes) {
		
		redirectAttributes.addFlashAttribute("message", "오류가 발생하였습니다. 다시 시도해주세요.");
		
		model.addAttribute("exception", exception);
		return "/errors";
	}

}