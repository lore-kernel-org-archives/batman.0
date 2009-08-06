Return-Path: <nickthefarrow@hotmail.com>
Message-ID: <SNT107-W2D1401DEA4D77EF4E7F3EA60A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_eb98313b-f4c0-4a0f-b793-d2637e5ab28b_"
From: nick farrow <nickthefarrow@hotmail.com>
Date: Thu, 6 Aug 2009 15:13:40 +0000
In-Reply-To: <5635aa0d0908060707l73bf0412i9068a102b025ae80@mail.gmail.com>
References: <200908051533.26117.lindner_marek@yahoo.de>
	<200908051931.10324.lindner_marek@yahoo.de>
	<SNT107-W263AEF87A1D0726A92E172A60D0@phx.gbl>
	<200908051953.56292.lindner_marek@yahoo.de>
	<SNT107-W49473D7262E3265C059DBCA60D0@phx.gbl>
	<5635aa0d0908050939me70c61cpbf633d90175bc5b9@mail.gmail.com>
	<SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl> 
	<5635aa0d0908060707l73bf0412i9068a102b025ae80@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Routing help?
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

--_eb98313b-f4c0-4a0f-b793-d2637e5ab28b_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi=2C

=20

I know its inferior - I just need to do some range throughput work comparin=
g meshed/non meshed. So I'd like to use BATMAN but I have time pressures so=
 the one that I can working on my wrt54 boxes first is used !!

=20

Thanks
=20


Date: Thu=2C 6 Aug 2009 10:07:10 -0400
From: outbackdingo@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.net
Subject: Re: [B.A.T.M.A.N.] Routing help?

well im not quite sure why you want to go 802.11S othere then adhoc with ba=
tman=2Caccording to some docs S has a limitation on nodes/hops=2C unless it=
s been overcome. just go brcm2.4 on 8.09.1 and you can move forward


On 8/6/09=2C nick farrow <nickthefarrow@hotmail.com> wrote:

Hi Thanks for that=2C
=20
I originally wanted the 2.6 kernel for 802.11s=2C but then found build issu=
es with 2.4 in K8.09 and it all got messy. So back to the trusted k7.09 wit=
h batman to the rescue. This thread I kicked off on the openwrt forum would=
 seem to confirm no native brcm support in k8.09 https://forum.openwrt.org/=
viewtopic.php?id=3D20620
=20
nick
=20


Date: Wed=2C 5 Aug 2009 12:39:34 -0400
From: outbackdingo@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.net

Subject: Re: [B.A.T.M.A.N.] Routing help?

thats based on a 2.6 kernel build=2C OpenWRT still supports this board on 2=
.4 kernel
under 8.09 or 8.09.1=2C your so legacy is kinda funny. im sure you can find=
 a 8.09.1 build for that unit


On 8/5/09=2C nick farrow <nickthefarrow@hotmail.com> wrote:=20

Hi Marek=2C

Thanks for the update.

I'm using 7.09 as last time I looked there was no support for the broadcom =
802.11 in 8.09.

nick

> From: lindner_marek@yahoo.de
> To: b.a.t.m.a.n@lists.open-mesh.net
> Date: Wed=2C 5 Aug 2009 19:53:56 +0800
> Subject: Re: [B.A.T.M.A.N.] Routing help?=20

>=20
> On Wednesday 05 August 2009 19:35:48 nick farrow wrote:
> > Thanks very much - so advance sounds like the solution=2C I'll try this=
. Does
> > the whole bridge work be default with this install or is there some spe=
cial
> > configuration?
>=20
> For your setup I suggest you kill the bridge between ethernet and wifi si=
nce=20
> batman-adv will create a new brdige interface you should work with: bat0 =
You=20
> should bridge your ethernet with that device and the rest should work as =
you=20
> want to have it.
>=20
>=20
> > My ipkg does list batman adv but its an alpha=2C is this the still the =
best
> > current version to use?
>=20
> You are using an old version of OpenWRT (7.09). There are updated batman=
=20
> packages in 8.09.
>=20
> Regards=2C
> Marek
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n



Celebrate a decade of Messenger with free winks=2C emoticons=2C display pic=
s=2C and more. Get Them Now
_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@lists.open-mesh.net
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n





Windows Live Messenger: Thanks for 10 great years-enjoy free winks and emot=
icons. Get Them Now
_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@lists.open-mesh.net
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n



_________________________________________________________________
Windows Live Messenger: Thanks for 10 great years=97enjoy free winks and em=
oticons.
http://clk.atdmt.com/UKM/go/157562755/direct/01/=

--_eb98313b-f4c0-4a0f-b793-d2637e5ab28b_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Hi=2C<BR>
&nbsp=3B<BR>
I know its&nbsp=3Binferior - I just&nbsp=3Bneed to&nbsp=3Bdo&nbsp=3Bsome ra=
nge throughput work comparing meshed/non meshed. So I'd like to use BATMAN =
but I have time pressures&nbsp=3Bso the one that I can working on my&nbsp=
=3Bwrt54 boxes first&nbsp=3Bis used !!<BR>
&nbsp=3B<BR>
Thanks<BR>&nbsp=3B<BR>
<HR id=3DstopSpelling>
Date: Thu=2C 6 Aug 2009 10:07:10 -0400<BR>From: outbackdingo@gmail.com<BR>T=
o: b.a.t.m.a.n@lists.open-mesh.net<BR>Subject: Re: [B.A.T.M.A.N.] Routing h=
elp?<BR><BR>well im not quite sure why you want to go 802.11S othere then a=
dhoc with batman=2Caccording to some docs S has a limitation on nodes/hops=
=2C unless its been overcome. just go brcm2.4 on 8.09.1 and you can move fo=
rward<BR><BR>
<DIV><SPAN class=3DEC_gmail_quote>On 8/6/09=2C <B class=3DEC_gmail_senderna=
me>nick farrow</B> &lt=3B<A href=3D"mailto:nickthefarrow@hotmail.com">nickt=
hefarrow@hotmail.com</A>&gt=3B wrote:</SPAN>
<BLOCKQUOTE style=3D"PADDING-LEFT: 1ex" class=3DEC_gmail_quote>
<DIV>Hi Thanks for that=2C<BR>&nbsp=3B<BR>I originally wanted&nbsp=3Bthe 2.=
6 kernel for 802.11s=2C but then found build issues with 2.4&nbsp=3Bin K8.0=
9 and it all got messy. So back to the trusted&nbsp=3Bk7.09 with batman to =
the rescue. This thread I kicked off on the openwrt forum would seem to con=
firm no&nbsp=3Bnative&nbsp=3Bbrcm support in k8.09 <A href=3D"https://forum=
.openwrt.org/viewtopic.php?id=3D20620">https://forum.openwrt.org/viewtopic.=
php?id=3D20620</A><BR>&nbsp=3B<BR>nick<BR>&nbsp=3B<BR>
<HR>
Date: Wed=2C 5 Aug 2009 12:39:34 -0400<BR>From: <A href=3D"mailto:outbackdi=
ngo@gmail.com">outbackdingo@gmail.com</A><SPAN class=3Dq><BR>To: <A href=3D=
"mailto:b.a.t.m.a.n@lists.open-mesh.net">b.a.t.m.a.n@lists.open-mesh.net</A=
><BR></SPAN>
<DIV><SPAN id=3DEC_q_122eee0acc235d54_2 class=3DEC_e>Subject: Re: [B.A.T.M.=
A.N.] Routing help?<BR><BR>thats based on a 2.6 kernel build=2C OpenWRT sti=
ll supports this board on 2.4 kernel<BR>under 8.09 or 8.09.1=2C your so leg=
acy is kinda funny. im sure you can find a 8.09.1 build for that unit<BR><B=
R>
<DIV><SPAN>On 8/5/09=2C <B>nick farrow</B> &lt=3B<A href=3D"mailto:nickthef=
arrow@hotmail.com">nickthefarrow@hotmail.com</A>&gt=3B wrote:</SPAN>=20
<BLOCKQUOTE style=3D"PADDING-LEFT: 1ex">
<DIV>Hi Marek=2C<BR><BR>Thanks for the update.<BR><BR>I'm using 7.09 as las=
t time I looked there was no support for the broadcom 802.11 in 8.09.<SPAN>=
<BR><BR>nick<BR><BR>&gt=3B From: <A href=3D"mailto:lindner_marek@yahoo.de">=
lindner_marek@yahoo.de</A><BR>&gt=3B To: <A href=3D"mailto:b.a.t.m.a.n@list=
s.open-mesh.net">b.a.t.m.a.n@lists.open-mesh.net</A><BR></SPAN>&gt=3B Date:=
 Wed=2C 5 Aug 2009 19:53:56 +0800<BR>&gt=3B Subject: Re: [B.A.T.M.A.N.] Rou=
ting help?=20
<DIV><SPAN><BR>&gt=3B <BR>&gt=3B On Wednesday 05 August 2009 19:35:48 nick =
farrow wrote:<BR>&gt=3B &gt=3B Thanks very much - so advance sounds like th=
e solution=2C I'll try this. Does<BR>&gt=3B &gt=3B the whole bridge work be=
 default with this install or is there some special<BR>&gt=3B &gt=3B config=
uration?<BR>&gt=3B <BR>&gt=3B For your setup I suggest you kill the bridge =
between ethernet and wifi since <BR>&gt=3B batman-adv will create a new brd=
ige interface you should work with: bat0 You <BR>&gt=3B should bridge your =
ethernet with that device and the rest should work as you <BR>&gt=3B want t=
o have it.<BR>&gt=3B <BR>&gt=3B <BR>&gt=3B &gt=3B My ipkg does list batman =
adv but its an alpha=2C is this the still the best<BR>&gt=3B &gt=3B current=
 version to use?<BR>&gt=3B <BR>&gt=3B You are using an old version of OpenW=
RT (7.09). There are updated batman <BR>&gt=3B packages in 8.09.<BR>&gt=3B =
<BR>&gt=3B Regards=2C<BR>&gt=3B Marek<BR>&gt=3B <BR>&gt=3B ________________=
_______________________________<BR>&gt=3B B.A.T.M.A.N mailing list<BR>&gt=
=3B <A href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.op=
en-mesh.net</A><BR>&gt=3B <A href=3D"https://lists.open-mesh.net/mm/listinf=
o/b.a.t.m.a.n">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</A><BR><=
BR></SPAN></DIV>
<HR>
Celebrate a decade of Messenger with free winks=2C emoticons=2C display pic=
s=2C and more. <A href=3D"http://clk.atdmt.com/UKM/go/157562755/direct/01/"=
>Get Them Now</A></DIV><BR>_______________________________________________<=
BR>B.A.T.M.A.N mailing list<BR><A href=3D"mailto:B.A.T.M.A.N@lists.open-mes=
h.net">B.A.T.M.A.N@lists.open-mesh.net</A><BR><A href=3D"https://lists.open=
-mesh.net/mm/listinfo/b.a.t.m.a.n">https://lists.open-mesh.net/mm/listinfo/=
b.a.t.m.a.n</A><BR><BR></BLOCKQUOTE></DIV><BR><BR></SPAN></DIV>
<HR>
Windows Live Messenger: Thanks for 10 great years-enjoy free winks and emot=
icons. <A href=3D"http://clk.atdmt.com/UKM/go/157562755/direct/01/">Get The=
m Now</A></DIV><BR>_______________________________________________<BR>B.A.T=
.M.A.N mailing list<BR><A href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B=
.A.T.M.A.N@lists.open-mesh.net</A><BR><A href=3D"https://lists.open-mesh.ne=
t/mm/listinfo/b.a.t.m.a.n">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.=
a.n</A><BR><BR></BLOCKQUOTE></DIV><BR><br /><hr />Internet Explorer 8 - acc=
elerate your Hotmail.  <a href=3D'http://clk.atdmt.com/UKM/go/134665338/dir=
ect/01/' target=3D'_new'>Download Internet Explorer 8</a></body>
</html>=

--_eb98313b-f4c0-4a0f-b793-d2637e5ab28b_--
