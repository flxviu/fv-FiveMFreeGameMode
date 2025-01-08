local cfg = {}
cfg.display_css = [[
@font-face {
font-family:'fontcustom';
src:url(fonts/fontcustom.woff)
}
.div_mission {
position:absolute;
font-family:fontcustom;
top:200px;
right:10px;
font-weight:100;
text-align:right;
border-bottom-left-radius:10px;
border-top-right-radius:10px;
border:2px solid rgba(9,170,245,0.9);
box-shadow:0 0 5px 1px rgba(9,170,245,0.5);
background:linear-gradient(to right,rgba(255,255,255,0),rgba(3,183,238,0.5));
padding:9px;
font-size:21px;
width:155px;
color:#fff;
text-shadow:1.5px 1px #000
}
.div_mission .name {
animation:logomove 2.1s infinite;
color:#fff
}
.div_mission .step {
animation:logomove 2.1s infinite;
color:#fff
}
]]
return cfg