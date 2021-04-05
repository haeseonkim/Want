<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to WANT!</title>
	<!-- bootstrap, jquery -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="./resources/css/before_home.css" rel="stylesheet">

</head>
<body>

  <section id="hero">
    <div class="hero-container" data-aos="fade-up">
      <h1>Want</h1>
      <h2>What A Nice Trip</h2>
      <a href="./home.do" class="btn-get-started scrollto">Get Started</a>
    </div>
  </section><!-- End Hero -->
	<script>
	$(".btn-get-started").on('click', function(){
		$.ajax({
			url: 'visitCount.do',
			type: 'get',
			success:function(flag){
				if(flag == 1){
					console.log("visitCount++ 성공");
				}else{
					console.log("visitCount++ 실패");
				}
			}
		});
	})
	</script>
</body>
</html>