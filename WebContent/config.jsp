<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">

<title>추가 정보 입력</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- custom -->
<link href="css/offcanvas.css" rel="stylesheet">
<link href="css/blog.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#profile').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#imgInp").change(function() {
			alert(this.value);
			readURL(this);
		});
	});
</script>
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top" id="bar">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"> <span
					class="glyphicon glyphicon-globe"></span> FaceToday
				</a>
			</div>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><span class="glyphicon glyphicon-bell"></span><b
						class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="index.jsp">로그아웃</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span><b
						class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">프로필 편집</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="index.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</div>

	<div class="container">
		<!-- <div class="row col-sm-8 blog-main"> -->
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">추가 개인 정보 입력</h2>
			</div>
			<div class="panel-body">추가로 입력하는 개인 정보는 필수 입력 사항이 아니며, 개인의 동의
				없이 제 3자에게 제공하지 않긴, 개뿔</div>

			<form method="post" enctype="multipart/form-data" id="config">
				<!-- Table -->
				<table class="table">
					<tr>
						<td><strong>1. 프로필 사진 입력</strong><br /> <span
							class="help-block">프로필 사진은 글을 남길 때 회원님의 얼굴로 표시됩니다.</span> <img
							class="img-responsive img-rounded" id="profile"
							src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNzEiIGhlaWdodD0iMTgwIj48cmVjdCB3aWR0aD0iMTcxIiBoZWlnaHQ9IjE4MCIgZmlsbD0iI2VlZSI+PC9yZWN0Pjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9Ijg1LjUiIHk9IjkwIiBzdHlsZT0iZmlsbDojYWFhO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1zaXplOjEycHg7Zm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7ZG9taW5hbnQtYmFzZWxpbmU6Y2VudHJhbCI+MTcxeDE4MDwvdGV4dD48L3N2Zz4="
							alt=" ">
							<p />
							<div class="form-group">
								<input type="file" id="imgInp" name="file">
							</div></td>
					</tr>
					<tr>
						<td><strong>2. 성별 입력</strong><br /> <span class="help-block">성별의
								선택은 음악 서비스를 제공하는 데 큰 도움이 됩니다.</span>
							<div class="form-group">
								<input type="radio" name="sex" value="male"> 남 <input
									type="radio" name="sex" value="female"> 여
							</div></td>
					</tr>
					<tr>
						<td><strong>3. 국가 및 지역 입력</strong><br /> <span
							class="help-block"> 국가 및 지역별로 날씨 등의 위치 기반 서비스를 제공합니다.</span> <select
							data-placeholder="Choose a Country..." class="chosen-select"
							style="width: 350px;" tabindex="2">
								<option value="">국가 선택</option>
								<option value="United States">United States</option>
								<option value="United Kingdom">United Kingdom</option>
								<option value="Afghanistan">Afghanistan</option>
								<option value="Aland Islands">Aland Islands</option>
								<option value="Albania">Albania</option>
								<option value="Algeria">Algeria</option>
								<option value="American Samoa">American Samoa</option>
								<option value="Andorra">Andorra</option>
								<option value="Angola">Angola</option>
								<option value="Anguilla">Anguilla</option>
								<option value="Antarctica">Antarctica</option>
								<option value="Antigua and Barbuda">Antigua and Barbuda</option>
								<option value="Argentina">Argentina</option>
								<option value="Armenia">Armenia</option>
								<option value="Aruba">Aruba</option>
								<option value="Australia">Australia</option>
								<option value="Austria">Austria</option>
								<option value="Azerbaijan">Azerbaijan</option>
								<option value="Bahamas">Bahamas</option>
								<option value="Bahrain">Bahrain</option>
								<option value="Bangladesh">Bangladesh</option>
								<option value="Barbados">Barbados</option>
								<option value="Belarus">Belarus</option>
								<option value="Belgium">Belgium</option>
								<option value="Belize">Belize</option>
								<option value="Benin">Benin</option>
								<option value="Bermuda">Bermuda</option>
								<option value="Bhutan">Bhutan</option>
								<option value="Bolivia, Plurinational State of">Bolivia,
									Plurinational State of</option>
								<option value="Bonaire, Sint Eustatius and Saba">Bonaire,
									Sint Eustatius and Saba</option>
								<option value="Bosnia and Herzegovina">Bosnia and
									Herzegovina</option>
								<option value="Botswana">Botswana</option>
								<option value="Bouvet Island">Bouvet Island</option>
								<option value="Brazil">Brazil</option>
								<option value="British Indian Ocean Territory">British
									Indian Ocean Territory</option>
								<option value="Brunei Darussalam">Brunei Darussalam</option>
								<option value="Bulgaria">Bulgaria</option>
								<option value="Burkina Faso">Burkina Faso</option>
								<option value="Burundi">Burundi</option>
								<option value="Cambodia">Cambodia</option>
								<option value="Cameroon">Cameroon</option>
								<option value="Canada">Canada</option>
								<option value="Cape Verde">Cape Verde</option>
								<option value="Cayman Islands">Cayman Islands</option>
								<option value="Central African Republic">Central
									African Republic</option>
								<option value="Chad">Chad</option>
								<option value="Chile">Chile</option>
								<option value="China">China</option>
								<option value="Christmas Island">Christmas Island</option>
								<option value="Cocos (Keeling) Islands">Cocos (Keeling)
									Islands</option>
								<option value="Colombia">Colombia</option>
								<option value="Comoros">Comoros</option>
								<option value="Congo">Congo</option>
								<option value="Congo, The Democratic Republic of The">Congo,
									The Democratic Republic of The</option>
								<option value="Cook Islands">Cook Islands</option>
								<option value="Costa Rica">Costa Rica</option>
								<option value="Cote D'ivoire">Cote D'ivoire</option>
								<option value="Croatia">Croatia</option>
								<option value="Cuba">Cuba</option>
								<option value="Curacao">Curacao</option>
								<option value="Cyprus">Cyprus</option>
								<option value="Czech Republic">Czech Republic</option>
								<option value="Denmark">Denmark</option>
								<option value="Djibouti">Djibouti</option>
								<option value="Dominica">Dominica</option>
								<option value="Dominican Republic">Dominican Republic</option>
								<option value="Ecuador">Ecuador</option>
								<option value="Egypt">Egypt</option>
								<option value="El Salvador">El Salvador</option>
								<option value="Equatorial Guinea">Equatorial Guinea</option>
								<option value="Eritrea">Eritrea</option>
								<option value="Estonia">Estonia</option>
								<option value="Ethiopia">Ethiopia</option>
								<option value="Falkland Islands (Malvinas)">Falkland
									Islands (Malvinas)</option>
								<option value="Faroe Islands">Faroe Islands</option>
								<option value="Fiji">Fiji</option>
								<option value="Finland">Finland</option>
								<option value="France">France</option>
								<option value="French Guiana">French Guiana</option>
								<option value="French Polynesia">French Polynesia</option>
								<option value="French Southern Territories">French
									Southern Territories</option>
								<option value="Gabon">Gabon</option>
								<option value="Gambia">Gambia</option>
								<option value="Georgia">Georgia</option>
								<option value="Germany">Germany</option>
								<option value="Ghana">Ghana</option>
								<option value="Gibraltar">Gibraltar</option>
								<option value="Greece">Greece</option>
								<option value="Greenland">Greenland</option>
								<option value="Grenada">Grenada</option>
								<option value="Guadeloupe">Guadeloupe</option>
								<option value="Guam">Guam</option>
								<option value="Guatemala">Guatemala</option>
								<option value="Guernsey">Guernsey</option>
								<option value="Guinea">Guinea</option>
								<option value="Guinea-bissau">Guinea-bissau</option>
								<option value="Guyana">Guyana</option>
								<option value="Haiti">Haiti</option>
								<option value="Heard Island and Mcdonald Islands">Heard
									Island and Mcdonald Islands</option>
								<option value="Holy See (Vatican City State)">Holy See
									(Vatican City State)</option>
								<option value="Honduras">Honduras</option>
								<option value="Hong Kong">Hong Kong</option>
								<option value="Hungary">Hungary</option>
								<option value="Iceland">Iceland</option>
								<option value="India">India</option>
								<option value="Indonesia">Indonesia</option>
								<option value="Iran, Islamic Republic of">Iran, Islamic
									Republic of</option>
								<option value="Iraq">Iraq</option>
								<option value="Ireland">Ireland</option>
								<option value="Isle of Man">Isle of Man</option>
								<option value="Israel">Israel</option>
								<option value="Italy">Italy</option>
								<option value="Jamaica">Jamaica</option>
								<option value="Japan">Japan</option>
								<option value="Jersey">Jersey</option>
								<option value="Jordan">Jordan</option>
								<option value="Kazakhstan">Kazakhstan</option>
								<option value="Kenya">Kenya</option>
								<option value="Kiribati">Kiribati</option>
								<option value="Korea, Democratic People's Republic of">Korea,
									Democratic People's Republic of</option>
								<option value="Korea, Republic of">Korea, Republic of</option>
								<option value="Kuwait">Kuwait</option>
								<option value="Kyrgyzstan">Kyrgyzstan</option>
								<option value="Lao People's Democratic Republic">Lao
									People's Democratic Republic</option>
								<option value="Latvia">Latvia</option>
								<option value="Lebanon">Lebanon</option>
								<option value="Lesotho">Lesotho</option>
								<option value="Liberia">Liberia</option>
								<option value="Libya">Libya</option>
								<option value="Liechtenstein">Liechtenstein</option>
								<option value="Lithuania">Lithuania</option>
								<option value="Luxembourg">Luxembourg</option>
								<option value="Macao">Macao</option>
								<option value="Macedonia, The Former Yugoslav Republic of">Macedonia,
									The Former Yugoslav Republic of</option>
								<option value="Madagascar">Madagascar</option>
								<option value="Malawi">Malawi</option>
								<option value="Malaysia">Malaysia</option>
								<option value="Maldives">Maldives</option>
								<option value="Mali">Mali</option>
								<option value="Malta">Malta</option>
								<option value="Marshall Islands">Marshall Islands</option>
								<option value="Martinique">Martinique</option>
								<option value="Mauritania">Mauritania</option>
								<option value="Mauritius">Mauritius</option>
								<option value="Mayotte">Mayotte</option>
								<option value="Mexico">Mexico</option>
								<option value="Micronesia, Federated States of">Micronesia,
									Federated States of</option>
								<option value="Moldova, Republic of">Moldova, Republic
									of</option>
								<option value="Monaco">Monaco</option>
								<option value="Mongolia">Mongolia</option>
								<option value="Montenegro">Montenegro</option>
								<option value="Montserrat">Montserrat</option>
								<option value="Morocco">Morocco</option>
								<option value="Mozambique">Mozambique</option>
								<option value="Myanmar">Myanmar</option>
								<option value="Namibia">Namibia</option>
								<option value="Nauru">Nauru</option>
								<option value="Nepal">Nepal</option>
								<option value="Netherlands">Netherlands</option>
								<option value="New Caledonia">New Caledonia</option>
								<option value="New Zealand">New Zealand</option>
								<option value="Nicaragua">Nicaragua</option>
								<option value="Niger">Niger</option>
								<option value="Nigeria">Nigeria</option>
								<option value="Niue">Niue</option>
								<option value="Norfolk Island">Norfolk Island</option>
								<option value="Northern Mariana Islands">Northern
									Mariana Islands</option>
								<option value="Norway">Norway</option>
								<option value="Oman">Oman</option>
								<option value="Pakistan">Pakistan</option>
								<option value="Palau">Palau</option>
								<option value="Palestinian Territory, Occupied">Palestinian
									Territory, Occupied</option>
								<option value="Panama">Panama</option>
								<option value="Papua New Guinea">Papua New Guinea</option>
								<option value="Paraguay">Paraguay</option>
								<option value="Peru">Peru</option>
								<option value="Philippines">Philippines</option>
								<option value="Pitcairn">Pitcairn</option>
								<option value="Poland">Poland</option>
								<option value="Portugal">Portugal</option>
								<option value="Puerto Rico">Puerto Rico</option>
								<option value="Qatar">Qatar</option>
								<option value="Reunion">Reunion</option>
								<option value="Romania">Romania</option>
								<option value="Russian Federation">Russian Federation</option>
								<option value="Rwanda">Rwanda</option>
								<option value="Saint Barthelemy">Saint Barthelemy</option>
								<option value="Saint Helena, Ascension and Tristan da Cunha">Saint
									Helena, Ascension and Tristan da Cunha</option>
								<option value="Saint Kitts and Nevis">Saint Kitts and
									Nevis</option>
								<option value="Saint Lucia">Saint Lucia</option>
								<option value="Saint Martin (French part)">Saint Martin
									(French part)</option>
								<option value="Saint Pierre and Miquelon">Saint Pierre
									and Miquelon</option>
								<option value="Saint Vincent and The Grenadines">Saint
									Vincent and The Grenadines</option>
								<option value="Samoa">Samoa</option>
								<option value="San Marino">San Marino</option>
								<option value="Sao Tome and Principe">Sao Tome and
									Principe</option>
								<option value="Saudi Arabia">Saudi Arabia</option>
								<option value="Senegal">Senegal</option>
								<option value="Serbia">Serbia</option>
								<option value="Seychelles">Seychelles</option>
								<option value="Sierra Leone">Sierra Leone</option>
								<option value="Singapore">Singapore</option>
								<option value="Sint Maarten (Dutch part)">Sint Maarten
									(Dutch part)</option>
								<option value="Slovakia">Slovakia</option>
								<option value="Slovenia">Slovenia</option>
								<option value="Solomon Islands">Solomon Islands</option>
								<option value="Somalia">Somalia</option>
								<option value="South Africa">South Africa</option>
								<option value="South Georgia and The South Sandwich Islands">South
									Georgia and The South Sandwich Islands</option>
								<option value="South Sudan">South Sudan</option>
								<option value="Spain">Spain</option>
								<option value="Sri Lanka">Sri Lanka</option>
								<option value="Sudan">Sudan</option>
								<option value="Suriname">Suriname</option>
								<option value="Svalbard and Jan Mayen">Svalbard and Jan
									Mayen</option>
								<option value="Swaziland">Swaziland</option>
								<option value="Sweden">Sweden</option>
								<option value="Switzerland">Switzerland</option>
								<option value="Syrian Arab Republic">Syrian Arab
									Republic</option>
								<option value="Taiwan, Province of China">Taiwan,
									Province of China</option>
								<option value="Tajikistan">Tajikistan</option>
								<option value="Tanzania, United Republic of">Tanzania,
									United Republic of</option>
								<option value="Thailand">Thailand</option>
								<option value="Timor-leste">Timor-leste</option>
								<option value="Togo">Togo</option>
								<option value="Tokelau">Tokelau</option>
								<option value="Tonga">Tonga</option>
								<option value="Trinidad and Tobago">Trinidad and Tobago</option>
								<option value="Tunisia">Tunisia</option>
								<option value="Turkey">Turkey</option>
								<option value="Turkmenistan">Turkmenistan</option>
								<option value="Turks and Caicos Islands">Turks and
									Caicos Islands</option>
								<option value="Tuvalu">Tuvalu</option>
								<option value="Uganda">Uganda</option>
								<option value="Ukraine">Ukraine</option>
								<option value="United Arab Emirates">United Arab
									Emirates</option>
								<option value="United Kingdom">United Kingdom</option>
								<option value="United States">United States</option>
								<option value="United States Minor Outlying Islands">United
									States Minor Outlying Islands</option>
								<option value="Uruguay">Uruguay</option>
								<option value="Uzbekistan">Uzbekistan</option>
								<option value="Vanuatu">Vanuatu</option>
								<option value="Venezuela, Bolivarian Republic of">Venezuela,
									Bolivarian Republic of</option>
								<option value="Viet Nam">Viet Nam</option>
								<option value="Virgin Islands, British">Virgin Islands,
									British</option>
								<option value="Virgin Islands, U.S.">Virgin Islands,
									U.S.</option>
								<option value="Wallis and Futuna">Wallis and Futuna</option>
								<option value="Western Sahara">Western Sahara</option>
								<option value="Yemen">Yemen</option>
								<option value="Zambia">Zambia</option>
								<option value="Zimbabwe">Zimbabwe</option>
						</select> <select data-placeholder="Choose a Country..."
							class="chosen-select" style="width: 350px;" tabindex="2">
								<option value="">지역 선택</option>
								<option value="Seoul">Seoul</option>
								<option value="Busan">Busan</option>
								<option value="UlSan">UlSan</option>
								<option value="Daegu">Daegu</option>
								<option value="Daejeon">Daejeon</option>
								<option value="Jeju">Jeju</option>
						</select>
					</tr>
					<tr>
						<td><strong>4. 학교 및 소속 정보 입력</strong><br /> <span
							class="help-block">친구들을 찾거나, 그룹 활동시에 장점을 제공합니다.</span> <select
							data-placeholder="Choose a Country..." class="chosen-select"
							style="width: 350px;" tabindex="2">
								<option value="">생각 중 생각 중</option>
								<option value="Seoul">Busan National University</option>
								<option value="Busan">Busan</option>
								<option value="UlSan">UlSan</option>
								<option value="Daegu">Daegu</option>
								<option value="Daejeon">Daejeon</option>
								<option value="Jeju">Jeju</option>
						</select></td>
					</tr>
				</table>
				<div class="panel-footer">
					<table>
					<tr>
					<td width="770">&nbsp</td>
					<td>
					<input type="submit" class="btn btn-success" value="제출"/> 
					<input type="button" class="btn btn-danger" onclick="history.back();" value="취소"/>
					</td>
					</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	<!-- blog main 끝 -->

	<!-- </div> -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="resource/js/bootstrap.min.js"></script>
</body>
</html>