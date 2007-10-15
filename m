Message-ID: <BLU122-W16C92462BF23C28A73ADBFF6A30@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8ad2d464-02e5-4941-be63-7aab30b80bf9_"
From: Dennis Bartsch <dennis_bartsch@hotmail.com>
Subject: RE: [B.A.T.M.A.N.] strange default routes
Date: Mon, 15 Oct 2007 16:01:54 +0100
In-Reply-To: <200710151608.47855.lindner_marek@yahoo.de>
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
	<200710151608.47855.lindner_marek@yahoo.de>
MIME-Version: 1.0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--_8ad2d464-02e5-4941-be63-7aab30b80bf9_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Marek,

we used rev718 ... from yesterday evening ... and all facts you mentioned a=
re right ... we disabled anything that enables batman to set or announce de=
fault routes ... thats why we completely don't understand whats happening t=
here. and because the same things happens on a slackware/i386 node AND on a=
n openWRT_post7.09/ixp4xx but not on an openWRT_pre7.06/i386 the failure is=
 not likely to be in the operating system.=20

in the evening i'll post what you asked for ... atm i am not in reach of th=
e equipment ...

greets
dennis bartsch

> From: lindner_marek@yahoo.de
> To: b.a.t.m.a.n@open-mesh.net
> Subject: Re: [B.A.T.M.A.N.] strange default routes
> Date: Mon, 15 Oct 2007 16:08:47 +0200
>=20
>=20
> Hi,
>=20
> > root@OpenWrt:/etc/init.d# route -n
> > Destination  Gateway  Genmask  Flags Metric Ref    Use Iface
> > [...]
> > 0.0.0.0         0.0.0.0     0.0.0.0      !        0         0       0  =
   *
> > [...]
> >
> > batmand has been started with the following parameters:  /usr/sbin/batm=
and
> > -g 0 -r 0 eth2
>=20
> as Antonio said you disabled all internet traffic via batman.
> Furthermore, default routes created by batman are found in table 68 (use =
"ip=20
> route ls table 68" to see its content) but "route -n" shows you table 254=
.
>=20
>=20
> > root@OpenWrt:/etc/init.d# /usr/sbin/batmand -g 0 -r 0 eth2:0 -d 4
> > WARNING: You are using the unstable batman branch. If you are intereste=
d in
> > [ 0] Error - can't add rule to 105.0.0.0/8: Invalid argument
> > [ 0] Error - can't add rule to 105.0.0.0/8: Invalid argument
> > Using interface eth2:0 with address 105.13.0.54 and broadcast address
> > 105.255.255.255 B.A.T.M.A.N. 0.3-beta (compatibility version 4)
> > [ 0] Error - can't add rule to 0.0.0.0/0: Invalid argument
> > [ 10] Error - can't add rule to 0.0.0.0/0: Invalid argument
>=20
> Here batman tries to set the policy routing rules and not routing table=20
> entries. It would be interesting to know the revision you use and could y=
ou=20
> please add the output of (while batmand is running) "ip rule".
>=20
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

_________________________________________________________________
Windows Live Writer Beta - Ver=F6ffentlichen Sie Multimediainhalte in Ihrem=
 Blog!
http://get.live.com/betas/writer_betas=

--_8ad2d464-02e5-4941-be63-7aab30b80bf9_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">Hello Marek,<br>=
<br>we used rev718 ... from yesterday evening ... and all facts you mention=
ed are right ... we disabled anything that enables batman to set or announc=
e default routes ... thats why we completely don't understand whats happeni=
ng there. and because the same things happens on a slackware/i386 node AND =
on an openWRT_post7.09/ixp4xx but not on an openWRT_pre7.06/i386 the failur=
e is not likely to be in the operating system. <br><br>in the evening i'll =
post what you asked for ... atm i am not in reach of the equipment ...<br><=
/div><br>greets<br>dennis bartsch<br><br><hr id=3D"stopSpelling">&gt; From:=
 lindner_marek@yahoo.de<br>&gt; To: b.a.t.m.a.n@open-mesh.net<br>&gt; Subje=
ct: Re: [B.A.T.M.A.N.] strange default routes<br>&gt; Date: Mon, 15 Oct 200=
7 16:08:47 +0200<br>&gt; <br>&gt; <br>&gt; Hi,<br>&gt; <br>&gt; &gt; root@O=
penWrt:/etc/init.d# route -n<br>&gt; &gt; Destination  Gateway  Genmask  Fl=
ags Metric Ref    Use Iface<br>&gt; &gt; [...]<br>&gt; &gt; 0.0.0.0        =
 0.0.0.0     0.0.0.0      !        0         0       0     *<br>&gt; &gt; [=
...]<br>&gt; &gt;<br>&gt; &gt; batmand has been started with the following =
parameters:  /usr/sbin/batmand<br>&gt; &gt; -g 0 -r 0 eth2<br>&gt; <br>&gt;=
 as Antonio said you disabled all internet traffic via batman.<br>&gt; Furt=
hermore, default routes created by batman are found in table 68 (use "ip <b=
r>&gt; route ls table 68" to see its content) but "route -n" shows you tabl=
e 254.<br>&gt; <br>&gt; <br>&gt; &gt; root@OpenWrt:/etc/init.d# /usr/sbin/b=
atmand -g 0 -r 0 eth2:0 -d 4<br>&gt; &gt; WARNING: You are using the unstab=
le batman branch. If you are interested in<br>&gt; &gt; [ 0] Error - can't =
add rule to 105.0.0.0/8: Invalid argument<br>&gt; &gt; [ 0] Error - can't a=
dd rule to 105.0.0.0/8: Invalid argument<br>&gt; &gt; Using interface eth2:=
0 with address 105.13.0.54 and broadcast address<br>&gt; &gt; 105.255.255.2=
55 B.A.T.M.A.N. 0.3-beta (compatibility version 4)<br>&gt; &gt; [ 0] Error =
- can't add rule to 0.0.0.0/0: Invalid argument<br>&gt; &gt; [ 10] Error - =
can't add rule to 0.0.0.0/0: Invalid argument<br>&gt; <br>&gt; Here batman =
tries to set the policy routing rules and not routing table <br>&gt; entrie=
s. It would be interesting to know the revision you use and could you <br>&=
gt; please add the output of (while batmand is running) "ip rule".<br>&gt; =
<br>&gt; Regards,<br>&gt; Marek<br>&gt; ___________________________________=
____________<br>&gt; B.A.T.M.A.N mailing list<br>&gt; B.A.T.M.A.N@open-mesh=
.net<br>&gt; https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n<br><br /><h=
r />Schon gesehen? Tolle Bilder von Sarah Connor gibt es hier! <a href=3D'h=
ttp://redirect.gimas.net/?cat=3Dhmtl&n=3DM1007S&d=3Dhttp://search.msn.de/im=
ages/results.aspx?q=3DSarah%20Connor' target=3D'_new'>Live Search</a></body=
>
</html>=

--_8ad2d464-02e5-4941-be63-7aab30b80bf9_--
