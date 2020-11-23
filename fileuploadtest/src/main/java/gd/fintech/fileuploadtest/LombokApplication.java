package gd.fintech.fileuploadtest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import gd.fintech.fileuploadtest.vo.VoTest;

@SpringBootApplication
public class LombokApplication {

	public static void main(String[] args) {
		SpringApplication.run(LombokApplication.class, args);
		VoTest vt = new VoTest();
		vt.setX(7);
		vt.setY(10);
		
		System.out.println(vt);
	}
}
