Batman.Filters.time_to_date = (time) ->
  date = new Date(Date.parse(time))
  date.toDateString()


class Dashing.Birthday extends Dashing.Widget
  colors = new Array("339966", "FF0000", "00FF00", "0000FF", "FFFF00", "FF00FF", "00FFFF")
  start  = colors[0]
  end    = colors[0]
  index  = 0
  cindex = 0


  ready: ->
    super
    setInterval(@startCountdown, 50)


  # Compares the end date to the current date. If they're the same, initiates party time. 
  # Otherwise, counts down the timer. This gets called twice every second and is pretty inefficient.
  startCountdown: =>
    node = $(@node)
    current_timestamp = Math.round(new Date().getTime() / 1000)
    end_timestamp = Math.round(Date.parse(node.find(".end").html()) / 1000)
    seconds_until_end = end_timestamp - current_timestamp
    if seconds_until_end < 0
      @set('timeleft', "Party Time!")
      if !node.attr('lame')
        @setColor(node)
    else
      d = Math.floor(seconds_until_end / 86400)
      h = Math.floor((seconds_until_end - (d * 86400)) / 3600)
      m = Math.floor((seconds_until_end - (d * 86400) - (h * 3600)) / 60)
      s = seconds_until_end - (d * 86400) - (h * 3600) - (m * 60)
      if d > 0
        dayname = 'day'
        if d > 1
          dayname = 'days'
        @set('timeleft', d + " "+ dayname + " " + @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))
      else
        @set('timeleft', @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))


  formatTime: (i) ->
    if i < 10 then "0" + i else i


  # Used to convert between color formats
  hex2dec: (hex) -> parseInt(hex, 16)
  dec2hex: (dec) -> (if dec < 16 then "0" else "") + dec.toString(16)


  # Returns the next background color for the div, as a hex code
  getColor: (start, end, percent) ->
    r1 = @hex2dec(start.slice(0, 2))
    g1 = @hex2dec(start.slice(2, 4))
    b1 = @hex2dec(start.slice(4, 6))
    r2 = @hex2dec(end.slice(0, 2))
    g2 = @hex2dec(end.slice(2, 4))
    b2 = @hex2dec(end.slice(4, 6))
    pc = percent / 100
    r  = Math.floor(r1 + (pc * (r2 - r1)) + .5)
    g  = Math.floor(g1 + (pc * (g2 - g1)) + .5)
    b  = Math.floor(b1 + (pc * (b2 - b1)) + .5)
    return "#" + @dec2hex(r) + @dec2hex(g) + @dec2hex(b)
  
  
  # Sets the div's background color to the next one in the sequence
  setColor: (target) ->
    if index == 0
      start = end
      end = colors[ cindex = (cindex+1) % colors.length ]
    target.css('background-color', @getColor(start, end, index))
    index = (index+5) % 100
    