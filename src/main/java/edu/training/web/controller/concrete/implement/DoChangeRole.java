package edu.training.web.controller.concrete.implement;

import java.io.IOException;

import edu.training.web.bean.User;
import edu.training.web.controller.concrete.Command;
import edu.training.web.service.ServiceException;
import edu.training.web.service.ServiceProvider;
import edu.training.web.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DoChangeRole implements Command {

	private final UserService userService = ServiceProvider.getInstance().getUserService();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("Controller?command=go_to_start_page&Info=No rights");
			return;
		}

		User user = (User) session.getAttribute("user");
		UserRole role = user.getRole();
		if (role != UserRole.ADMIN) {
			response.sendRedirect("Controller?command=go_to_start_page&Info=No rights");
			return;
		}

		String login = request.getParameter("login");
		String newRole = request.getParameter("newRole");

		try {
			if (userService.changeRole(login, newRole)) {
				request.getRequestDispatcher("Controller?command=go_to_main_page&changeRole=Роль успешно изменена").forward(request, response);
			} else {
				request.getRequestDispatcher("Controller?command=go_to_main_page&errorchangeRole=Ошибка изменения роли").forward(request, response);
			}
		} catch (ServiceException e) {
			request.getRequestDispatcher("Controller?command=go_to_main_page&errorchangeRole=Ошибка").forward(request, response);
		}
	}
}