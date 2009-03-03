Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C99BAE.628EBE06"
Date: Tue, 3 Mar 2009 11:16:03 +0800
Message-ID: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D236@MBX21.stu.nus.edu.sg>
From: "Kartik Muralidharan" <kartik_m@nus.edu.sg>
Subject: [B.A.T.M.A.N.] Running Batman
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

------_=_NextPart_001_01C99BAE.628EBE06
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I was able to compile/link batman statically and configure using the
instructions given by Sven

=20
LDFLAGS=3D"-s -static" /usr/bin/make
=20
You can check it with `file batmand`. It should print something like
batmand: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),
statically=20
linked, for GNU/Linux 2.6.8, stripped

=20

=20

$ wlanconfig ath0 create wlandev wifi0 wlanmode adhoc

$ iwconfig ath0 essid testnet

$ iwconfig ath0 ap 02:00:de:ad:be:ef

$ iwconfig ath0 channel 10

$ ip addr add $IP brd $BRDCAST dev ath0

$ ip link set ath0 up

=20

=20

On running the command wlanconfig ath0 create wlandev wifi0 wlanmode
adhoc I get the following output

=20

ath0: unable to register device

ath0

=20

I currently have 2 devices and use the following IP address
configuration

=20

IP :192.168.1.10 & 192.168.1.11

BRDCAST: 192.168.1.255

=20

Finally I run ./batmand ath0

=20

This echos :Using interface ath0 with address IP and broadcast address
BDCAST

=20

To test I tried pinging one device from the other, but it doesn't seem
to work.  Have I missed out something or is my configuration just wrong.
Also whats the best way to test if the configuration and devices are
running correctly.

=20

Thanks

Kartik

=20

=20

=20

=20


------_=_NextPart_001_01C99BAE.628EBE06
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
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

<div class=3DSection1>

<p class=3DMsoNormal>Hi All,<o:p></o:p></p>

<p class=3DMsoNormal>I was able to compile/link batman statically and =
configure
using the instructions given by Sven<o:p></o:p></p>

<pre><o:p>&nbsp;</o:p></pre><pre>LDFLAGS=3D&quot;-s -static&quot; =
/usr/bin/make<o:p></o:p></pre><pre><o:p>&nbsp;</o:p></pre><pre>You can =
check it with `file batmand`. It should print something =
like<o:p></o:p></pre><pre>batmand: ELF 32-bit LSB executable, Intel =
80386, version 1 (SYSV), statically <o:p></o:p></pre><pre>linked, for =
GNU/Linux 2.6.8, stripped<o:p></o:p></pre>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>$
wlanconfig ath0 create wlandev wifi0 wlanmode =
adhoc<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>$
iwconfig ath0 essid testnet<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>$
iwconfig ath0 ap 02:00:de:ad:be:ef<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>$
iwconfig ath0 channel 10<o:p></o:p></span></p>

<pre>$ ip addr add $IP brd $BRDCAST dev ath0<o:p></o:p></pre>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>$
ip link set ath0 up<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal>On running the command <span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>wlanconfig ath0 create wlandev wifi0 wlanmode =
adhoc I
get the following output</span><o:p></o:p></p>

<p class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p>

<p class=3DMsoNormal><b>ath0: unable to register =
device<o:p></o:p></b></p>

<p class=3DMsoNormal><b>ath0<o:p></o:p></b></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal>I currently have 2 devices and use the following IP =
address
configuration<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>IP :192.168.1.10 &amp; 192.168.1.11<o:p></o:p></p>

<p class=3DMsoNormal>BRDCAST: 192.168.1.255<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Finally I run ./batmand ath0<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>This echos :Using interface ath0 with address IP =
and
broadcast address BDCAST<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>To test I tried pinging one device from the other, =
but it doesn&#8217;t
seem to work. &nbsp;Have I missed out something or is my configuration =
just
wrong. Also whats the best way to test if the configuration and devices =
are
running correctly.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks<o:p></o:p></p>

<p class=3DMsoNormal>Kartik<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C99BAE.628EBE06--
