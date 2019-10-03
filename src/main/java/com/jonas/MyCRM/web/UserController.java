package com.jonas.MyCRM.web;

import com.jonas.MyCRM.labas.Status;
import com.jonas.MyCRM.labas.Ticket;
import com.jonas.MyCRM.model.Role;
import com.jonas.MyCRM.model.User;
import com.jonas.MyCRM.repository.RoleRepository;
import com.jonas.MyCRM.repository.StatusRepository;
import com.jonas.MyCRM.repository.TicketRepository;
import com.jonas.MyCRM.repository.UserRepository;
import com.jonas.MyCRM.service.SecurityService;
import com.jonas.MyCRM.service.TicketService;
import com.jonas.MyCRM.service.UserService;
import com.jonas.MyCRM.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private StatusRepository statusRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }
        userForm.setRoleChoose(1L);
        userService.save(userForm);

        //securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/useris";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        return "welcome";
    }



    @RequestMapping (value = {"/useris"}, method = RequestMethod.GET)
    public String useris(Model model){

        LinkedList<User> list = runinam();
        model.addAttribute("lists",list);


        return "useris";
    }



    public LinkedList<User> runinam(){
        LinkedList<User> list=new LinkedList<>();
        for(User useris : userRepository.findAll()){
            list.add(useris);
        }
        return list;
    }



    @RequestMapping(value = "useris/{id}/delete", method = RequestMethod.GET)
    public String delete(@PathVariable("id") Long id) {
        userRepository.delete(id);
        return "redirect:/useris";
    }


    @RequestMapping(value = "/useris/{id}/update", method = RequestMethod.GET)
    public String showUpdateUserForm(@PathVariable("id") Long id, Model model) {

        User user = userRepository.findById(id);
        model.addAttribute("userForma", user);

        return "updateuser";

    }

    @RequestMapping(value = "/useris", method = RequestMethod.POST)
    public String saveOrUpdateUser(@ModelAttribute("userForma") @Validated User user, BindingResult result, Model model) {

        Set<Role> rol= new HashSet<>();
        rol.add(roleRepository.findById(user.getRoleChoose()));
        user.setRoles(rol);

        userRepository.save(user);

        return "redirect:/useris";

    }

    @Autowired
    private TicketService ticketService;

    @Autowired
    private TicketRepository ticketRepository;

    //-----------------Create ticket
    @RequestMapping(value = "/ticketcreate", method = RequestMethod.GET)
    public String ticketCreate(Model model) {

        LinkedList<Status> list=runStatus();
        model.addAttribute("lists", list);
        model.addAttribute("ticketForm", new Ticket());

        return "ticketcreate";
    }




    @RequestMapping(value = "/ticketcreate", method = RequestMethod.POST)
    public String ticketCreate(@ModelAttribute("ticketForm") Ticket ticketForm, Model model) {

        ticketService.save(ticketForm);

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


}
