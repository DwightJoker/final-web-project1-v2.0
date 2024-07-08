package edu.training.web.controller.concrete.implement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

import edu.training.web.controller.concrete.Command;

public class SetLocale implements Command {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String localeString = request.getParameter("locale");
        Locale locale;
        if (localeString != null && localeString.equals("en")) {
            locale = new Locale("en", "US");
        } else {
            locale = new Locale("ru", "RU");
        }
        request.getSession().setAttribute("locale", locale);
        response.sendRedirect(request.getHeader("referer")); // Redirect back to the page where the request came from
    }
}