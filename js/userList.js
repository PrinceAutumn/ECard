var fullSelect = false;

function fullcheck() {
  //获得数据
  var checkboxObj = document.getElementsByName("uid");
  if(fullSelect){
    for (var i = 0; i < checkboxObj.length; i++) {
      checkboxObj[i].checked = false;
      fullSelect = false;
    }
  } else {
    for (var i = 0; i < checkboxObj.length; i++) {
      checkboxObj[i].checked = "checked";
      fullSelect = true;
    }
  }
}

function reFullCheck() {
  //获得数据
  var checkboxObj = document.getElementsByName("uid");
  for (var i = 0; i < checkboxObj.length; i++) {
    checkboxObj[i].checked = false;
  }
}

function mouseOver(obj){
  obj.style.backgroundColor="#7B68EE";
  return;
}

function mouseOut(obj){
  obj.style.backgroundColor="#ffffff";
  return;
}
