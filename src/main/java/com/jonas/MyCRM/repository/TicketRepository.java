package com.jonas.MyCRM.repository;


import com.jonas.MyCRM.labas.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TicketRepository  extends JpaRepository<Ticket, Long> {

}
