package facetoday.exception;

/**
 * 정동구
 * 비밀번호 불일치 예외 처리
 */
public class PasswdConfirmException extends RuntimeException {
	public PasswdConfirmException() {
		super("입력 비밀번호와 재입력 비밀번호가 불일치합니다.");
	}
}
