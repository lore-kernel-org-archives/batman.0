Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DEC1.8B2D7D83"
Date: Wed, 27 May 2009 19:52:00 +0800
Message-ID: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24D@MBX21.stu.nus.edu.sg>
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24B@MBX21.stu.nus.edu.sg>
From: "Kartik Muralidharan" <kartik_m@nus.edu.sg>
Subject: Re: [B.A.T.M.A.N.] MultiRadio Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9DEC1.8B2D7D83
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

@Marek

*       what do you mean ? You want to know where in the code batman
handles multiple radio interfaces ?

=20

Yes. I have just started going through the code so wondering how
multiple interfaces are handled.

=20

@Benjamin

>At the Wireless Battle Mesh of Paris, the author of Babel wrote a

>quick patch to add some cost to hop over the same wifi interface.

=20

>Here is a summary:

=20

>http://hackerspace.be/wbm2009#toc9

=20

=20

We are trying to service the internet access through a regular
infrastructure mode via an access point connected to the wired interface
on the node. Apart from that each node has 2 wireless interfaces that
can be used to reduce intra hop interference. So wanted to know if
BATMAN can take advantage of two radio on each node to improve
throughput.

=20

________________________________

From: Kartik Muralidharan=20
Sent: Wednesday, May 27, 2009 1:52 PM
To: 'b.a.t.m.a.n@open-mesh.net'
Subject: MultiRadio Batman

=20

Hello,

We have finally deployed a WMN testbed on our campus , currently running
roofnet. However I would like to run BATMAN as the underlying routing
protocol. Could you help me out with deploying and testing BATMAN on the
nodes.

=20

Further since our nodes have two radio we are looking at taking
advantage of the same. Any pointers from a coding perspective to tackle
this would be great as I am hoping to publish the same.

=20

Also does Batman advanced operate in Monitor mode?

=20

Thanks

Kartik


------_=_NextPart_001_01C9DEC1.8B2D7D83
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40"
xmlns:ns0=3D"http://schemas.microsoft.com/office/2004/12/omml">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--a:link
	{mso-style-priority:99;}
span.MSOHYPERLINK
	{mso-style-priority:99;}
a:visited
	{mso-style-priority:99;}
span.MSOHYPERLINKFOLLOWED
	{mso-style-priority:99;}

 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:Calibri;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Calibri;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1539003716;
	mso-list-type:hybrid;
	mso-list-template-ids:1067322050 -492394572 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:3;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Courier New";}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>@Marek<o:p></o:p></span></font></p>

<p class=3DMsoPlainText =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&Oslash;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]>what
do you mean ? You want to know where in the code batman handles multiple =
radio
interfaces ?<o:p></o:p></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Yes. I have just started going through the code so wondering how =
multiple
interfaces are handled.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>@Benjamin<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;At the Wireless Battle Mesh of Paris, the author of =
<st1:City
w:st=3D"on"><st1:place w:st=3D"on">Babel</st1:place></st1:City> wrote =
a<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;quick patch to add some cost to hop over the same wifi =
interface.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Here is a summary:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;http://hackerspace.be/wbm2009#toc9<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>We are trying to service the =
internet
access through a regular infrastructure mode via an access point =
connected to
the wired interface on the node. Apart from that each node has 2 =
wireless
interfaces that can be used to reduce intra hop interference. So wanted =
to know
if BATMAN can take advantage of two radio on each node to improve =
throughput.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
Kartik
Muralidharan <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, May 27, =
2009 1:52
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
'b.a.t.m.a.n@open-mesh.net'<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> MultiRadio =
Batman</span></font><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>We
have finally deployed a WMN testbed on our campus , currently running =
roofnet.
However I would like to run BATMAN as the underlying routing protocol. =
Could
you help me out with deploying and testing BATMAN on the =
nodes.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Further
since our nodes have two radio we are looking at taking advantage of the =
same.
Any pointers from a coding perspective to tackle this would be great as =
I am
hoping to publish the same.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Also
does Batman advanced operate in Monitor =
mode?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Kartik<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9DEC1.8B2D7D83--
