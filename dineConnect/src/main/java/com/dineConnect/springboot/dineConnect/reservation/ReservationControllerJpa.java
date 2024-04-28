package com.dineConnect.springboot.dineConnect.reservation;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("name")
public class ReservationControllerJpa {
	
	//ReservationService 이용!
	
	
	

	//생성자 -> 자동으로 결합됨
	//reservationService를 사용해 Reservation 리스트를 받을 수 있다
	public ReservationControllerJpa(ReservationService reservationService, ReservationRepository reservationRepository) {
		super();
		this.reservationService = reservationService;
		this.reservationRepository = reservationRepository;
	}
	
	private ReservationService reservationService;
	
	//인스턴스 생성
	
	private ReservationRepository reservationRepository;
	
	

	@RequestMapping("list-reservations")
	public String listAllReservations(ModelMap model) {
		String username = (String)model.get("name");
		//1번 가져
		reservationRepository.getById(1);
		
		//구문을 새 지역 변수에 지정을 선택
		List<Reservation> reservations = reservationRepository.findByUsername(username);
		model.addAttribute("reservations", reservations);
		return "listReservations";
	}
	//GET
	@RequestMapping(value="select-time", method=RequestMethod.GET)
	public String showtimeReservationPage() {
		//구문을 새 지역 변수에 지정을 선택
		
		return "selectTime";
	}
	/** 임시삭제
	//POST
	@RequestMapping(value="select-time", method=RequestMethod.POST)
	public String NshowtimeReservationPage(@RequestParam String description) {
		//구문을 새 지역 변수에 지정을 선택
		reservationService.addReservation(description);
		return "selectTime";
	}
	*/
	
	
	
	
	
}
