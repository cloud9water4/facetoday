package facetoday.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import facetoday.controller.action.Action;

public class ActionMapping implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		ServletContext context = arg0.getServletContext();
		String fileName = context.getInitParameter("fileName");
		Properties props = new Properties();
		try {
			props.load(context.getResourceAsStream(fileName));			
		} catch (Exception e) {
			System.out.println("Resource Read Error!!!" + e);
		}
		
		HashMap<String, Action> mapper = new HashMap<String, Action>();
		Set keyList = props.keySet();
		Iterator<String> iter =keyList.iterator();
		String key = null;
		Action action = null;
		while (iter.hasNext()) {
			key = iter.next();			
			try {
				action = (Action)Class.forName(props.getProperty(key)).newInstance();
				mapper.put(key, action);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		context.setAttribute("mapper", mapper);
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {}
}