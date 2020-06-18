
function hitungmundur(time){
  var countDownDate = new Date(time).getTime();
  console.log(time);
  var job = setTimeout(function(){
      var now = new Date().getTime();

      var distance = countDownDate - now;

      var days = Math.floor(distance / (1000 * 60 * 60 * 24));
      var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);

      if(distance < 0){
          document.getElementById("hari").innerHTML = "0";
          document.getElementById("jam").innerHTML = "0";
          document.getElementById("menit").innerHTML = "0";
          document.getElementById("detik").innerHTML = "0";
      }else{
          document.getElementById("hari").innerHTML = days;
          document.getElementById("jam").innerHTML = hours;
          document.getElementById("menit").innerHTML = minutes;
          document.getElementById("detik").innerHTML = seconds;
          hitungmundur(time);
      }
      
  },1000)
}
