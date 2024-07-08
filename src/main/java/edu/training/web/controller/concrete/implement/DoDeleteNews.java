package edu.training.web.controller.concrete.implement;

import java.io.IOException;

import edu.training.web.controller.concrete.Command;
import edu.training.web.service.NewsService;
import edu.training.web.service.ServiceException;
import edu.training.web.service.ServiceProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DoDeleteNews implements Command {

	private final NewsService newsService = ServiceProvider.getInstance().getNewsService();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String newsIdString = request.getParameter("newsId");
		try {
			if (newsIdString != null && !newsIdString.isEmpty()) {

				int newsId = Integer.parseInt(newsIdString);
				newsService.deleteNews(newsId);

				request.getRequestDispatcher("Controller?command=go_to_main_page&deleteMessage=Новость успешно удалена")
						.forward(request, response);

			} else {

				request.getRequestDispatcher("Controller?command=go_to_main_page&errorMessage=Не передан ID новости")
						.forward(request, response);
			}
		} catch (NumberFormatException | ServiceException e) {

			request.getRequestDispatcher("Controller?command=go_to_main_page&errorMessage=Ошибка при удалении новости")
					.forward(request, response);
		}
	}
}