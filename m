Return-Path: <Eric.Conner@QinetiQ-NA.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA88A0.80C24386"
Date: Tue, 29 Dec 2009 11:03:48 -0500
Message-ID: <94CAE17FD1DB4640BF8FF28D61FDFA8A273262@RESQNAOEX01.qnao.net>
From: "Conner, Eric" <Eric.Conner@QinetiQ-NA.com>
Subject: [B.A.T.M.A.N.] avahi over batmand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA88A0.80C24386
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Can avahi work over batmand or do I need batman-adv in order to run
avahi?

=20

I have a test set up with 3 nodes all running the linux 2.6.31 kernel
with batmand and an ad-hoc network.  BATMAN tells me that all the nodes
are connected through the center point which is the hop for nodes 1 and
3.  I can ping all 3 nodes but only when the BATMAN daemon is running.
However when I browse avahi services (avahi-browse -avr) from the end
points, I can not see the services from the opposite end point (i.e.
node 1 can only see the services from itself and node 2 not the services
from node 3 and node 3 can only see its services and those on node 2,
but not from node 1).

=20

Is there something special I can do with avahi or batman to get node 1
to see the avahi services on node 3 and vice versa?

=20

Thanks
Eric

=20


------_=_NextPart_001_01CA88A0.80C24386
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
p.section1, li.section1, div.section1
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Can avahi work over batmand or do I need batman-adv =
in order
to run avahi?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a test set up with 3 nodes all running the =
linux 2.6.31
kernel with batmand and an ad-hoc network. &nbsp;BATMAN tells me that =
all the nodes
are connected through the center point which is the hop for nodes 1 and =
3. &nbsp;I
can ping all 3 nodes but only when the BATMAN daemon is running. =
&nbsp;However when
I browse avahi services (</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>avahi-browse =
&#8211;avr</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>) from the
end points, I can not see the services from the opposite end point (i.e. =
node 1
can only see the services from itself and node 2 not the services from =
node 3 and
node 3 can only see its services and those on node 2, but not from node =
1).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is there something special I can do with avahi or =
batman to
get node 1 to see the avahi services on node 3 and vice =
versa?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<br>
Eric<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA88A0.80C24386--
