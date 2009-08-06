Return-Path: <nickthefarrow@hotmail.com>
Message-ID: <SNT107-W36378936CB704146168424A60A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c7095990-8f33-43ab-ad8a-e101fe2aa4b6_"
From: nick farrow <nickthefarrow@hotmail.com>
Date: Thu, 6 Aug 2009 11:53:42 +0000
In-Reply-To: <SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
References: <200908051533.26117.lindner_marek@yahoo.de>
	<200908051931.10324.lindner_marek@yahoo.de>
	<SNT107-W263AEF87A1D0726A92E172A60D0@phx.gbl>
	<200908051953.56292.lindner_marek@yahoo.de>
	<SNT107-W49473D7262E3265C059DBCA60D0@phx.gbl> 
	<5635aa0d0908050939me70c61cpbf633d90175bc5b9@mail.gmail.com> 
	<SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Some handholding for batman-adv
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

--_c7095990-8f33-43ab-ad8a-e101fe2aa4b6_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi=2C

I nearly got close with the older version=2C Is could install and run it on=
 kamikaze 7.09 with a webif to look at what was happening=2C but this versi=
on did not allow arping across the mesh easily.

So to run the advanced versions of batman that would support this I have in=
stalled k8.09.1 and this has the support for the broadcom wifi in my wrt54.

There seem to be 2 versions of advanced batman - batman-adv and kmod-batman=
-advanced=2C however for the k8.09.1/brcm 2.4 release there does not seem t=
o be the kmod driver. So I have installed the batman-adv (batmand-adv_r1176=
-1_mipsel.ipk and battools) there is no batctl here.

After the box has rebooted there are no batmand processes=2C although I hav=
e the interface set to wl0 (
batmand-adv.general=3Dbatmand-adv
batmand-adv.general.originator_interval=3D
batmand-adv.general.visualisation_srv=3D
batmand-adv.general.interface=3Dwl0

and there are no messages in the log (there were when the interface was set=
 to ath0) so no idea. If I start them from the command line with this confi=
g they are running but have no idea how tell what and if anything is happen=
ing.

Could someone please give me some advice on
1) Do I need the kmod driver or is the batmand-adv sufficient for total mes=
h subnet giving arp (forwarding) success?
2) How do I tell what is going on - do I need batctl or is this for the kmo=
d install only?

Any help you can give would be really appreciated.

Regards

nick

From: nickthefarrow@hotmail.com
To: b.a.t.m.a.n@lists.open-mesh.net
Date: Thu=2C 6 Aug 2009 08:41:39 +0000
Subject: Re: [B.A.T.M.A.N.] Routing help?








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


On 8/5/09=2C nick farrow <nickthefarrow@hotmail.com> wrote:

Hi Marek=2C

Thanks for the update.

I'm using 7.09 as last time I looked there was no support for the broadcom =
802.11 in 8.09.

nick

> From: lindner_marek@yahoo.de
> To: b.a.t.m.a.n@lists.open-mesh.net
> Date: Wed=2C 5 Aug 2009 19:53:56 +0800
> Subject: Re: [B.A.T.M.A.N.] Routing help?

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
_________________________________________________________________
Windows Live Messenger: Thanks for 10 great years=97enjoy free winks and em=
oticons.
http://clk.atdmt.com/UKM/go/157562755/direct/01/=

--_c7095990-8f33-43ab-ad8a-e101fe2aa4b6_
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
Hi=2C<br><br>I nearly got close with the older version=2C Is could install =
and run it on kamikaze 7.09 with a webif to look at what was happening=2C b=
ut this version did not allow arping across the mesh easily.<br><br>So to r=
un the advanced versions of batman that would support this I have installed=
 k8.09.1 and this has the support for the broadcom wifi in my wrt54.<br><br=
>There seem to be 2 versions of advanced batman - batman-adv and kmod-batma=
n-advanced=2C however for the k8.09.1/brcm 2.4 release there does not seem =
to be the kmod driver. So I have installed the batman-adv (<a href=3D"http:=
//downloads.openwrt.org/kamikaze/8.09.1/brcm-2.4/packages/batmand-adv_r1176=
-1_mipsel.ipk">batmand-adv_r1176-1_mipsel.ipk</a> and battools) there is no=
 batctl here.<br><br>After the box has rebooted there are no batmand proces=
ses=2C although I have the interface set to wl0 (<br>batmand-adv.general=3D=
batmand-adv<br>batmand-adv.general.originator_interval=3D<br>batmand-adv.ge=
neral.visualisation_srv=3D<br>batmand-adv.general.interface=3Dwl0<br><br>an=
d there are no messages in the log (there were when the interface was set t=
o ath0) so no idea. If I start them from the command line with this config =
they are running but have no idea how tell what and if anything is happenin=
g.<br><br>Could someone please give me some advice on<br>1) Do I need the k=
mod driver or is the batmand-adv sufficient for total mesh subnet giving ar=
p (forwarding) success?<br>2) How do I tell what is going on - do I need ba=
tctl or is this for the kmod install only?<br><br>Any help you can give wou=
ld be really appreciated.<br><br>Regards<br><br>nick<br><br><hr id=3D"stopS=
pelling">From: nickthefarrow@hotmail.com<br>To: b.a.t.m.a.n@lists.open-mesh=
.net<br>Date: Thu=2C 6 Aug 2009 08:41:39 +0000<br>Subject: Re: [B.A.T.M.A.N=
.] Routing help?<br><br>



<style>
.ExternalClass .EC_hmmessage P
{padding:0px=3B}
.ExternalClass body.EC_hmmessage
{font-size:10pt=3Bfont-family:Verdana=3B}
</style>


Hi Thanks for that=2C<br>
&nbsp=3B<br>
I originally wanted&nbsp=3Bthe 2.6 kernel for 802.11s=2C but then found bui=
ld issues with 2.4&nbsp=3Bin K8.09 and it all got messy. So back to the tru=
sted&nbsp=3Bk7.09 with batman to the rescue. This thread I kicked off on th=
e openwrt forum would seem to confirm no&nbsp=3Bnative&nbsp=3Bbrcm support =
in k8.09 <a href=3D"https://forum.openwrt.org/viewtopic.php?id=3D20620">htt=
ps://forum.openwrt.org/viewtopic.php?id=3D20620</a><br>
&nbsp=3B<br>
nick<br>&nbsp=3B<br>
<hr id=3D"EC_stopSpelling">
Date: Wed=2C 5 Aug 2009 12:39:34 -0400<br>From: outbackdingo@gmail.com<br>T=
o: b.a.t.m.a.n@lists.open-mesh.net<br>Subject: Re: [B.A.T.M.A.N.] Routing h=
elp?<br><br>thats based on a 2.6 kernel build=2C OpenWRT still supports thi=
s board on 2.4 kernel<br>under 8.09 or 8.09.1=2C your so legacy is kinda fu=
nny. im sure you can find a 8.09.1 build for that unit<br><br>
<div><span class=3D"EC_EC_gmail_quote">On 8/5/09=2C <b class=3D"EC_EC_gmail=
_sendername">nick farrow</b> &lt=3B<a href=3D"mailto:nickthefarrow@hotmail.=
com">nickthefarrow@hotmail.com</a>&gt=3B wrote:</span>
<blockquote style=3D"padding-left: 1ex=3B" class=3D"EC_EC_gmail_quote">
<div>Hi Marek=2C<br><br>Thanks for the update.<br><br>I'm using 7.09 as las=
t time I looked there was no support for the broadcom 802.11 in 8.09.<span =
class=3D"q"><br><br>nick<br><br>&gt=3B From: <a href=3D"mailto:lindner_mare=
k@yahoo.de">lindner_marek@yahoo.de</a><br>&gt=3B To: <a href=3D"mailto:b.a.=
t.m.a.n@lists.open-mesh.net">b.a.t.m.a.n@lists.open-mesh.net</a><br></span>=
&gt=3B Date: Wed=2C 5 Aug 2009 19:53:56 +0800<br>&gt=3B Subject: Re: [B.A.T=
.M.A.N.] Routing help?
<div><span id=3D"EC_EC_q_122ea8d8de06a991_3" class=3D"EC_EC_e"><br>&gt=3B <=
br>&gt=3B On Wednesday 05 August 2009 19:35:48 nick farrow wrote:<br>&gt=3B=
 &gt=3B Thanks very much - so advance sounds like the solution=2C I'll try =
this. Does<br>&gt=3B &gt=3B the whole bridge work be default with this inst=
all or is there some special<br>&gt=3B &gt=3B configuration?<br>&gt=3B <br>=
&gt=3B For your setup I suggest you kill the bridge between ethernet and wi=
fi since <br>&gt=3B batman-adv will create a new brdige interface you shoul=
d work with: bat0 You <br>&gt=3B should bridge your ethernet with that devi=
ce and the rest should work as you <br>&gt=3B want to have it.<br>&gt=3B <b=
r>&gt=3B <br>&gt=3B &gt=3B My ipkg does list batman adv but its an alpha=2C=
 is this the still the best<br>&gt=3B &gt=3B current version to use?<br>&gt=
=3B <br>&gt=3B You are using an old version of OpenWRT (7.09). There are up=
dated batman <br>&gt=3B packages in 8.09.<br>&gt=3B <br>&gt=3B Regards=2C<b=
r>&gt=3B Marek<br>&gt=3B <br>&gt=3B _______________________________________=
________<br>&gt=3B B.A.T.M.A.N mailing list<br>&gt=3B <a href=3D"mailto:B.A=
.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-mesh.net</a><br>&gt=3B=
 <a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://li=
sts.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br><br></span></div>
<hr>
Celebrate a decade of Messenger with free winks=2C emoticons=2C display pic=
s=2C and more. <a href=3D"http://clk.atdmt.com/UKM/go/157562755/direct/01/"=
>Get Them Now</a></div><br>_______________________________________________<=
br>B.A.T.M.A.N mailing list<br><a href=3D"mailto:B.A.T.M.A.N@lists.open-mes=
h.net">B.A.T.M.A.N@lists.open-mesh.net</a><br><a href=3D"https://lists.open=
-mesh.net/mm/listinfo/b.a.t.m.a.n">https://lists.open-mesh.net/mm/listinfo/=
b.a.t.m.a.n</a><br><br></blockquote></div><br><br><hr>Windows Live Messenge=
r: Thanks for 10 great years-enjoy free winks and emoticons. <a href=3D"htt=
p://clk.atdmt.com/UKM/go/157562755/direct/01/">Get Them Now</a><br /><hr />=
Internet Explorer 8 - accelerate your Hotmail.  <a href=3D'http://clk.atdmt=
.com/UKM/go/134665338/direct/01/' target=3D'_new'>Download Internet Explore=
r 8</a></body>
</html>=

--_c7095990-8f33-43ab-ad8a-e101fe2aa4b6_--
