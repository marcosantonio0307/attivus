//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

function format(mask, doc){
  var i = doc.value.length;
  var out = mask.substring(0,1);
  var text = mask.substring(i)
  
  if (text.substring(0,1) != out){
            doc.value += text.substring(0,1);
  }
}