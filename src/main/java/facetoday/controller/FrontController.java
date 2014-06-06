package facetoday.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import facetoday.controller.action.Action;

public class FrontController extends HttpServlet{
	HashMap<String,Action> mapper=null;
			@Override
    public void init() throws ServletException {
       mapper=(HashMap)getServletContext().getAttribute("mapper");
    }
			@Override
			protected void doGet(HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException {
				process(response, request);
			}
			@Override
			protected void doPost(HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException {
				request.setCharacterEncoding("UTF-8");
				process(response, request);
			}
		protected void process(HttpServletResponse response, HttpServletRequest request) throws ServletException,IOException{
			String action=request.getParameter("command");
			if(action==null||action==""){
				action="list";
			}
			Action command=mapper.get(action);
			command.execute(response, request);
		}
}
