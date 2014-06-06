package facetoday.service;

import java.security.MessageDigest;
import java.util.Formatter;

public class PwdEncryption {
	private PwdEncryption() {}
	
	public static String pwdCode(String pwd) {
		String sha = null;
		
		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-256");
			crypt.reset();
			crypt.update(pwd.getBytes("UTF-8"));
			byte[] hash = crypt.digest();
			Formatter formatter = new Formatter();
			
			for (byte data : hash) {
				formatter.format("%02x",data);
			}
			sha = formatter.toString();
			formatter.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return sha;
	}
}
