package com.jonas.MyCRM.web;

import com.jonas.MyCRM.labas.ObjectD;
import com.jonas.MyCRM.labas.Status;
import com.jonas.MyCRM.labas.Ticket;
import com.jonas.MyCRM.labas.TicketStatus;
import com.jonas.MyCRM.model.User;
import com.jonas.MyCRM.repository.ObjectRepository;
import com.jonas.MyCRM.repository.StatusRepository;
import com.jonas.MyCRM.repository.TicketRepository;
import com.jonas.MyCRM.repository.UserRepository;
import com.jonas.MyCRM.service.SecurityService;
import com.jonas.MyCRM.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.LinkedList;

@Controller
public class TicketController {

    @Autowired
    private SecurityService securityService;

    @Autowired
    private StatusRepository statusRepository;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ObjectRepository objectRepository;

    //-----------------Create ticket
    @RequestMapping(value = "/ticketcreate", method = RequestMethod.GET)
    public String ticketCreate(Model model) {

        LinkedList<Status> list=runStatus();
        model.addAttribute("lists", list);
        LinkedList<User> user=userRun();
        model.addAttribute("userlist",user);
        LinkedList<ObjectD> objectDS=objectRun();
        model.addAttribute("objectlist",objectDS);
        model.addAttribute("ticketForm", new TicketStatus());

        return "ticketcreate";
    }

    public LinkedList<User> userRun(){

        LinkedList<User> list=new LinkedList<>();
        for(User user: userRepository.findAll()){
            //if(user.getStaffPosition().equals("Vairuotojas")){
                list.add(user);
            //}
        }

        return list;
    }

    public LinkedList<ObjectD> objectRun(){

        LinkedList<ObjectD> list=new LinkedList<>();
        for(ObjectD objectD: objectRepository.findAll()){
            list.add(objectD);
        }

        return list;
    }




    @RequestMapping(value = "/ticketcreate", method = RequestMethod.POST)
    public String ticketCreate(@ModelAttribute("ticketForm") TicketStatus ticketForm, Model model) {
        Ticket ticket=new Ticket();
        ticket.setId(ticketForm.getId());
        ticket.setTicketTitle(ticketForm.getTicketTitle());
        ticket.setAssignee(ticketForm.getAssignee());
        ticket.setCreatedBy(ticketForm.getCreatedBy());
        ticket.setStatus(statusRepository.findOne(ticketForm.getStatus_id()));
        ticket.setObjectD(objectRepository.findOne(ticketForm.getObject_id()));

        ticketService.save(ticket);

        return "redirect:/ticketlist";
    }


    //---------------- Ticket list

    @RequestMapping (value = {"/ticketlist"}, method = RequestMethod.GET)
    public String ticketas(Model model){

        LinkedList<Ticket> list = runTicket();
        LinkedList<Status> listS = runStatus();
        model.addAttribute("lists",list);
        model.addAttribute("listsS",listS);

        return "ticketlist";
    }

    public LinkedList<Ticket> runTicket(){
        LinkedList<Ticket> list=new LinkedList<>();
        for(Ticket ticket : ticketRepository.findAll()){
            list.add(ticket);
        }
        return list;
    }

    public LinkedList<Status> runStatus(){
        LinkedList<Status> list=new LinkedList<>();
        for(Status status : statusRepository.findAll()){
            list.add(status);
        }
        return list;
    }

    @RequestMapping(value = "ticketlist/{id}/delete", method = RequestMethod.GET)
    public String deleteTicket(@PathVariable("id") Long id) {
        ticketRepository.delete(id);
        return "redirect:/ticketlist";
    }

    //--------------Ticket View

    @RequestMapping(value = "/ticketlist/{id}/view", method = RequestMethod.GET)
    public String showTicket(@PathVariable("id") Long id, Model model) {

        Ticket ticket = ticketRepository.findById(id);
        model.addAttribute(ticket);

        return "viewTicket";

    }
}
