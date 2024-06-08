package com.dineConnect.springboot.dineConnect.reservation;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;


@Controller
@SessionAttributes("name")
public class ReservationControllerJpa {

	private final ReservationService reservationService;
	private final ReservationRepository reservationRepository;

	public ReservationControllerJpa(ReservationService reservationService, ReservationRepository reservationRepository) {
		this.reservationService = reservationService;
		this.reservationRepository = reservationRepository;
	}

	@RequestMapping("list-reservations")
	public String listAllReservations(ModelMap model) {
		String username = (String) model.get("name");
		List<Reservation> reservations = reservationRepository.findByUsername(username);
		model.addAttribute("reservations", reservations);
		return "listReservations";
	}

	@RequestMapping(value = "select-time", method = RequestMethod.GET)
	public String showtimeReservationPage() {
		return "selectTime";
	}

	@RequestMapping(value = "My-Page", method = RequestMethod.GET)
	public String showMyPage(ModelMap model) {
		String username = (String) model.get("name");
		List<Reservation> reservations = reservationRepository.findByUsername(username);
		model.addAttribute("reservations", reservations);
		return "myPage";
	}

	@RequestMapping(value = "make-reservation", method = RequestMethod.GET)
	public String makeReservation(@RequestParam("date") String date,
								  @RequestParam("time") String time) {
		System.out.println("예약 날짜:" + date + ", 예약 시간: " + time);
		return "redirect:/";
	}

	@RequestMapping(value = "submit", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> submit(@RequestParam(required = false) String username,
										 @RequestParam(required = false) String selectedDate,
										 @RequestParam(required = false) String selectedTime,
										 ModelMap model) {
		//예외없이
		if (username == null || username.isEmpty() || selectedDate == null || selectedDate.isEmpty() || selectedTime == null || selectedTime.isEmpty()) {
			return ResponseEntity.badRequest().body("날짜와 시간을 선택해주세요.");
		}

		try {
			LocalDate date = LocalDate.parse(selectedDate);
			LocalTime time = LocalTime.parse(selectedTime);

			Reservation newReservation = new Reservation();
			newReservation.setUsername(username);
			newReservation.setDate(date);
			newReservation.setTime(time);
			reservationService.save(newReservation);

			return ResponseEntity.ok(selectedDate + " " + selectedTime + "에 예약되었습니다.");
		} catch (DateTimeParseException e) { //예외처리
			return ResponseEntity.badRequest().body("유효한 날짜와 시간을 선택해주세요.");
		}
	}

	@RequestMapping(value = "get-disabled-times", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDisabledTimes(@RequestParam String date) {
		LocalDate localDate = LocalDate.parse(date);
		List<Reservation> reservations = reservationRepository.findByDate(localDate);
		List<String> disabledTimes = reservations.stream()
				.map(reservation -> reservation.getTime().toString())
				.collect(Collectors.toList());
		Map<String, Object> response = new HashMap<>();
		response.put("disabledTimes", disabledTimes);
		return response;
	}

	@RequestMapping(value = "cancel-reservation", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> cancelReservation(@RequestParam Long id, ModelMap model) {
		try {
			reservationRepository.deleteById(id);
			String username = (String) model.get("name");
			List<Reservation> reservations = reservationRepository.findByUsername(username);
			model.addAttribute("reservations", reservations);
			return ResponseEntity.ok("예약이 취소되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예약 취소 중 오류가 발생했습니다.");
		}
	}
}

