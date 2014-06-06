package facetoday.service;

import java.util.ArrayList;
import java.util.List;

import kr.co.shineware.nlp.komoran.core.MorphologyAnalyzer;
import kr.co.shineware.util.common.model.Pair;

public class MorphologicalAnalysis {
	
	public List<String> morphologicalAnalysis(String content) {
		MorphologyAnalyzer analyzer = new MorphologyAnalyzer("../datas/");

		List<List<Pair<String, String>>> result = analyzer.analyze(content);
		ArrayList<String> extractString = new ArrayList<String>();
		
		for (List<Pair<String, String>> eojeolResult : result) {
			for (Pair<String, String> wordMorph : eojeolResult) {
				System.out.println(wordMorph);
				extractString.add(wordMorph.getFirst());
			}
			System.out.println();
		}	
		return extractString;
	}
}
