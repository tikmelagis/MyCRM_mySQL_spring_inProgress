package com.jonas.MyCRM.web;

import com.jonas.MyCRM.labas.Status;
import com.jonas.MyCRM.labas.Ticket;
import com.jonas.MyCRM.labas.TicketStatus;
import com.jonas.MyCRM.model.Role;
import com.jonas.MyCRM.model.StaffPosition;
import com.jonas.MyCRM.model.User;
import com.jonas.MyCRM.model.UserTainer;
import com.jonas.MyCRM.repository.*;
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

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private StaffRepository staffRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new UserTainer());
        LinkedList<StaffPosition> listStaff=runStaff();
        model.addAttribute("listStaff",listStaff);

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") UserTainer userForm, BindingResult bindingResult, Model model) {

        User user=new User();
        user.setUsername(userForm.getUsername());
        user.setFirstName(userForm.getFirstName());
        user.setLastName(userForm.getLastName());
        user.setPassword(userForm.getPassword());
        user.setPasswordConfirm(userForm.getPasswordConfirm());
        user.setRoleChoose(1L);
        user.setStaffPosition(staffRepository.findOne(userForm.getStaffPosition_id()));
        userValidator.validate(user, bindingResult);
        if (bindingResult.hasErrors()) {
            return "registration";
        }
        userService.save(user);

        //securityService.autologin(user.getUsername(), user.getPasswordConfirm());

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
        LinkedList<StaffPosition> listStaff=runStaff();
        model.addAttribute("listStaff", listStaff);


        return "useris";
    }


    public LinkedList<User> runinam(){
        LinkedList<User> list=new LinkedList<>();
        for(User useris : userRepository.findAll()){
            list.add(useris);
        }
        return list;
    }
    public LinkedList<StaffPosition> runStaff(){
        LinkedList<StaffPosition> list=new LinkedList<>();
        for(StaffPosition staff : staffRepository.findAll()){
            list.add(staff);
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
        UserTainer userTainer=new UserTainer();
        userTainer.setId(user.getId());
        userTainer.setUsername(user.getUsername());
        userTainer.setFirstName(user.getFirstName());
        userTainer.setLastName(user.getLastName());
        userTainer.setPassword(user.getPassword());
        userTainer.setRoleChoose(user.getRoleChoose());
        userTainer.setStaffPosition_id(user.getStaffPosition().getId());

        model.addAttribute("userForma", userTainer);
        LinkedList<StaffPosition> listStaff=runStaff();
        model.addAttribute("listStaff", listStaff);

        return "updateuser";

    }

    @RequestMapping(value = "/useris", method = RequestMethod.POST)
    public String saveOrUpdateUser(@ModelAttribute("userForma") @Validated UserTainer user, BindingResult result, Model model) {

        User user1 = new User();
        user1.setId(user.getId());
        user1.setUsername(user.getUsername());
        user1.setFirstName(user.getFirstName());
        user1.setLastName(user.getLastName());
        user1.setPassword(user.getPassword());
        user1.setRoleChoose(user.getRoleChoose());
        user1.setStaffPosition(userRepository.findById(user.getId()).getStaffPosition());

//        Set<Role> rol= new HashSet<>();
//        rol.add(roleRepository.findById(user.getRoleChoose()));
//        user.setRoles(rol);

        userRepository.save(user1);

        return "redirect:/useris";

    }


}
