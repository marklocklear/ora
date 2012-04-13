// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function validate() {
    var count = 0;
    var valid = true;
    var radio_groups = {}
    $(":radio").each(function(){
      radio_groups[this.name] = true;
    })
    for(group in radio_groups){
      count++;
      if (!$(":radio[name='"+group+"']:checked").length) {
          var question = count;
          valid = false;
      }
    }
    if (!valid) {
      alert('Please answer question number ' + question);
      return false;
    }
  }
function validate_email() {
  if(""==document.getElementById('email1').value) {
    alert("Please enter at least one email address.");
    return false;
  }
}
