package com.jonas.MyCRM.service;

import com.jonas.MyCRM.labas.Ticket;
import com.jonas.MyCRM.labas.TicketStatus;
import com.jonas.MyCRM.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    @Override
    public void save(Ticket ticket) {
        ticketRepository.save(ticket);
    }



}
