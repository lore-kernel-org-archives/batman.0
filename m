Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DECF.03F9042A"
Date: Wed, 27 May 2009 21:28:26 +0800
Message-ID: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24F@MBX21.stu.nus.edu.sg>
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

------_=_NextPart_001_01C9DECF.03F9042A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>I tried Batman at the WBM to see if it was finding the fastest route
>in terms of bandwidth, and it was not doing it. So Batman will
>continue to hop on the same channel, even if another route is faster
>in terms of bandwidth
=20
Just to clarify. Every node has 2 radios. One on 11a and the other 11b.
Does batman take advantage of this like WCETT/iAware/MIC ....
=20
Thanks
Kartik

=20

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


------_=_NextPart_001_01C9DECF.03F9042A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
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
pre
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

<div class=3DSection1><pre><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt;I tried Batman at the WBM to see if it =
was finding the fastest route<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>&gt;in =
terms of bandwidth, and it was not doing it. So Batman =
will<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;continue to hop on the same channel, even =
if another route is faster<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>&gt;in =
terms of bandwidth<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Just to =
clarify. Every node has 2 radios. One on 11a and the other 11b. Does =
batman take advantage of this like WCETT/iAware/MIC =
&#8230;.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Thanks<o:p></o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Kartik<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

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
same. Any
pointers from a coding perspective to tackle this would be great as I am =
hoping
to publish the same.<o:p></o:p></span></font></p>

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

------_=_NextPart_001_01C9DECF.03F9042A--
