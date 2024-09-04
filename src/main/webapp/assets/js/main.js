
// $('#side-menu-area').on('click', 'span.side-menu-trigger', function () {

//    let $this = $(this),
//        wraper = $(this).parents('body').find('>.wraper');
//    if ($this.hasClass('open')) {
//        document.getElementById('mySidenav').style.width = '0';
//        $this.removeClass('open').find('i.fa').removeClass('fa-bars').addClass('fa-bars');
//        wraper.removeClass('open');
//    } else {
//        wraper.addClass('open');
//        $this.addClass('open').find('i.fa').removeClass('fa-bars').addClass('fa-bars');
//        document.getElementById('mySidenav').style.width = '350px';
//    }

// });

// $('#mySidenav').on('click', '.closebtn', function (e) {
//    e.preventDefault();
//    let $this = $(this),
//        wraper = $(this).parents('body').find('>.wraper');
//    wraper.removeClass('open');
//    document.getElementById('mySidenav').style.width = '0';
//    $('#side-menu-area span.side-menu-trigger').removeClass('open').find('i.fa').removeClass('fa-times').addClass('fa-bars');
// });


// Slider
{
    let counter = 1;
    setInterval(function(){
        document.getElementById('radio' + counter).checked = true;
        counter++;
        if(counter > 3){
            counter = 1;
        }
    }, 5000);
}


// Hidden Password

// let eye = document.getElementById("eye");
// let password = document.getElementById("password");
// let cpassword = document.getElementById("cpassword");
// let showPassword = false;

// eye.addEventListener("click",function(){
//   // password.setAttribute("type","text");
//   if(showPassword == false){
//    if (password.type === "password") {
//      password.type = "text";
//    } else {
//      password.type = "password";
//    }
//    eye.classList.add("fa-eye-slash");
//    eye.classList.remove("fa-eye");
//    showPassword = true;
//   }else{
//     if (password.type === "text") {
//       password.type = "password";
//     } else {
//       password.type = "text";
//     }
//     eye.classList.remove("fa-eye-slash");
//     eye.classList.add("fa-eye");
//     showPassword = false;
//   }
// });

let eye = document.getElementById("eye");
let ceye = document.getElementById("ceye");
let password = document.getElementById("password");
let cpassword = document.getElementById("cpassword");
let showPassword = false;
let hidePassword = false;

eye.addEventListener("click",function(){
    // password.setAttribute("type","text");
    if(showPassword == false){
        if (password.type === "password") {
            password.type = "text";
        } else {
            password.type = "password";
        }
        eye.classList.add("fa-eye-slash");
        eye.classList.remove("fa-eye");
        showPassword = true;
    }else{
        if (password.type === "text") {
            password.type = "password";
        } else {
            password.type = "text";
        }
        eye.classList.remove("fa-eye-slash");
        eye.classList.add("fa-eye");
        showPassword = false;
    }
});

ceye.addEventListener("click",function(){
    if(hidePassword == false){
        if (cpassword.type === "password") {
            cpassword.type = "text";
        } else {
            cpassword.type = "password";
        }
        ceye.classList.add("fa-eye-slash");
        ceye.classList.remove("fa-eye");
        hidePassword = true;
    }else{
        if (cpassword.type === "text") {
            cpassword.type = "password";
        } else {
            cpassword.type = "text";
        }
        ceye.classList.remove("fa-eye-slash");
        ceye.classList.add("fa-eye");
        hidePassword = false;
    }
});