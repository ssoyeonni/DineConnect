package com.dineConnect.springboot.dineConnect.reservation;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

import java.time.LocalDate;
import java.time.LocalTime;

//DB에 만들
@Entity(name="reservation")
public class Reservation {

	public Reservation() {
		
	}
	
	// Source -> Constructor Using Field
	public Reservation(int id, String username) {
		super();
		this.id = id;
		this.username = username;
	}
	@Id
	@GeneratedValue
	private int id;
	private String username;

	private LocalDate date;
	private LocalTime time;

	// Source -> Getters and Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}


	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public LocalTime getTime() {
		return time;
	}

	public void setTime(LocalTime time) {
		this.time = time;
	}


	// Source -> toString
	@Override
	public String toString() {
		return "Reservation [id=" + id + ", username=" + username + ", date=" + date + ", time=" + time + "]";
	}

}
