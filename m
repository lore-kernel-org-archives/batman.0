Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DF53.89C68666"
Date: Thu, 28 May 2009 13:17:04 +0800
Message-ID: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D251@MBX21.stu.nus.edu.sg>
From: "Kartik Muralidharan" <kartik_m@nus.edu.sg>
Subject: [B.A.T.M.A.N.] Multiradio Batman
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

------_=_NextPart_001_01C9DF53.89C68666
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Let's say a packet comes from node A interface ath0 of node B, and
> there is a route on node B for the packet to go to node C, route which
> use the same interface ath0. In this case, you might want to add a
> cost to hop over the same wireless interface.
=20
>Ok, good idea. I quickly made a patch:
>http://www.open-mesh.net/changeset/1276
=20
>Feel free to test it. :-)
=20
>Regards,
>Marek

=20

But how would batman choose the next hop if at every node there are two
interfaces available. The ideal ofcourse would be
11a->11b->11a->11b->11a on each hop.

=20

Regards

Kartik=20


------_=_NextPart_001_01C9DF53.89C68666
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1><pre><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt;<i><span style=3D'font-style:italic'> =
Let's say a packet comes from node A interface ath0 of node B, =
and<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> there is a route on node B for the packet =
to go to node C, route =
which<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> use the same interface ath0. In this case, =
you might want to add =
a<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> cost to hop over the same wireless =
interface.<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>&gt;Ok, =
good idea. I quickly made a =
patch:<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>&gt;<a
href=3D"http://www.open-mesh.net/changeset/1276">http://www.open-mesh.net=
/changeset/1276</a><o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>&gt;Feel =
free to test it. :-)<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;Regards,<o:p></o:p></span></font></pre><pr=
e><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;Marek<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>But how would batman choose the next hop if at every node there =
are two
interfaces available. The ideal ofcourse would be =
11a-&gt;11b-&gt;11a-&gt;11b-&gt;11a
on each hop.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Kartik <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9DF53.89C68666--
