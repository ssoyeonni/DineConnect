package com.dineConnect.springboot.dineConnect.reservation;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
	List<Reservation> findByUsername(String username);
	List<Reservation> findByDate(LocalDate date);
}
