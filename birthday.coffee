Batman.Filters.time_to_date = (time) ->
  date = new Date(Date.parse(time))
  date.toDateString()


class Dashing.Birthday extends Dashing.Widget

  ready: ->
    super
    setInterval(@startCountdown, 50)

  startCountdown: =>
    current_timestamp = Math.round(new Date().getTime()/1000)
    end_timestamp = Math.round(Date.parse($(@node).find(".end").html())/1000)
    seconds_until_end = end_timestamp - current_timestamp
    if seconds_until_end < 0
      @set('timeleft', "Party Time!")
      JSFX_StartEffects()
    else
      d = Math.floor(seconds_until_end/86400)
      h = Math.floor((seconds_until_end-(d*86400))/3600)
      m = Math.floor((seconds_until_end-(d*86400)-(h*3600))/60)
      s = seconds_until_end-(d*86400)-(h*3600)-(m*60)
      if d >0
        dayname = 'day'
        if d > 1
          dayname = 'days'
        @set('timeleft', d + " "+dayname+" " + @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))
      else
        @set('timeleft', @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))


  formatTime: (i) ->
    if i < 10 then "0" + i else i




`
function getColor(start, end, percent){
  function hex2dec(hex){return(parseInt(hex,16));}
  function dec2hex(dec){return (dec < 16 ? "0" : "") + dec.toString(16);}
  var r1 = hex2dec(start.slice(0,2)), g1=hex2dec(start.slice(2,4)), b1=hex2dec(start.slice(4,6));
  var r2 = hex2dec(end.slice(0,2)),   g2=hex2dec(end.slice(2,4)),   b2=hex2dec(end.slice(4,6));
  var pc = percent/100;
  var r  = Math.floor(r1+(pc*(r2-r1)) + .5), g=Math.floor(g1+(pc*(g2-g1)) + .5), b=Math.floor(b1+(pc*(b2-b1)) + .5);
  return("#" + dec2hex(r) + dec2hex(g) + dec2hex(b));
}

var colors = new Array("339966", "FF0000", "00FF00", "0000FF", "FFFF00", "FF00FF", "00FFFF");
var start  = colors[0];
var end    = colors[0];
var index  = 0;
var cindex = 0;
var faderObj = new Array();

function fadeSpan()
{
  if(index == 0)
  {
    start = end;
    end = colors[ cindex = (cindex+1) % colors.length ];
  }

  for(var i=0 ; i<faderObj.length ; i++)
    faderObj[i].style.backgroundColor = getColor(start, end, index);

  index = (index+5) % 100;
}

function fadeAll()
{
  for(var i=0 ; i<arguments.length ; i++)
    faderObj[i] = document.getElementById(arguments[i]);
  fadeSpan();
}

function JSFX_StartEffects()
{
  fadeAll("birthday");
}
`