var InspireTests = {};

InspireTests.AddHistory = function(url, title){
  if(!Modernizr.localstorage)
    return;
  
  var history = localStorage.getItem("recentlyViewed");
  history = history == null ? [] : JSON.parse(history);
  
  history.unshift({
    "url": url,
    "title": title
  });
  
  while(history.length > 10)
    history.pop();
  
  localStorage.setItem("recentlyViewed", JSON.stringify(history));
};

InspireTests.PrintHistory = function(element){
  if(!element)
    return;
  
  var history = localStorage.getItem("recentlyViewed");
  history = history == null ? [] : JSON.parse(history);
  
  var html = "<ol>";
  $.each(history, function(index, item){
    html += "<li><a href='" + item.url + "'>" + item.title + "</a></li>";
  });
  html += "</ol>";
  
  element.append(html);
};

$(document).ready(function(){
  InspireTests.PrintHistory($('#recently_viewed'));
});