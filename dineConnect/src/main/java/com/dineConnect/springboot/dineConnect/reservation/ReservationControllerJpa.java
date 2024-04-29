package com.dineConnect.springboot.dineConnect.reservation;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

	// 예약하기 버튼을 누르면 username, date, time 저장하도록
	@RequestMapping("submit")
	public String submit(@RequestParam String username, @RequestParam LocalDate date,
						 @RequestParam LocalTime time, ModelMap model) {
		Reservation newReservation = new Reservation();
		newReservation.setUsername(username);
		newReservation.setDate(date);
		newReservation.setTime(time);
		reservationService.save(newReservation);

		List<Reservation> reservations = reservationService.findByUsername(username);
		model.addAttribute("reservations", reservations);

		return "listReservations";
	}

	// 버튼에서 날짜 받아와서 위 데이터베이스 저장에 연결(시간은 아직 구현x)
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String dateString = request.getParameter("selectedDate");
//		LocalDate Date = LocalDate.parse(dateString);
//
//		// 여기에서 selectedDate를 사용하여 데이터베이스에 저장하는 로직 추가
//	}


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
