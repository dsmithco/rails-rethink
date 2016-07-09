(function(){
  document.onreadystatechange = function () {
      if (document.readyState === "interactive") {
          // add code here
          disableLinks();
          resizeContent();
          setup_menu_toggle();
      }
      window.onresize = resizeContent;
  } 

  function disableLinks(){
    var disabled_links = document.getElementsByClassName("disabled");
    for (var i = 0; i < disabled_links.length; i++) {
      disabled_links[i].onclick = function(e){
        e.preventDefault();
        return false;
      };
    }
  }


  function resizeContent() {
    console.log('window resized');
    // var divs = document.querySelectorAll("[class^='columns-']");
    //
    // for (var i = 0; i < divs.length; i++) {
    //   div = divs[i];
    // }
  }

  // removeClass, takes two params: element and classname
  function removeClass(el, cls) {
    var reg = new RegExp("(\\s|^)" + cls + "(\\s|$)");
    el.className = el.className.replace(reg, " ").replace(/(^\s*)|(\s*$)/g,"");
  }

  // hasClass, takes two params: element and classname
  function hasClass(el, cls) {
    return el.className && new RegExp("(\\s|^)" + cls + "(\\s|$)").test(el.className);
  }

  function setup_menu_toggle() {
    var toggles = document.querySelectorAll(".top-menu>.toggle");
    for (var i = 0; i < toggles.length; i++) {
      var toggle = toggles[i];
      toggle.onclick = function(e){

        var parent = toggle.parentNode;
        if(hasClass(parent, 'open')) {
          removeClass(parent, 'open');
        }else{
          parent.className += ' open';
          document.addEventListener('click', function(event) {
            var isClickInside = parent.contains(event.target);
            if (!isClickInside) {
              removeClass(parent, 'open');
            }
          });
        }
        e.preventDefault();
        return false;
      };
    }
  }

})();
