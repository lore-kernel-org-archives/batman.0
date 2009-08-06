Return-Path: <nickthefarrow@hotmail.com>
Message-ID: <SNT107-W15FB756F128D90901F56F5A60A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_10a63317-b78e-4f69-adb2-98e0fb3c7742_"
From: nick farrow <nickthefarrow@hotmail.com>
Date: Thu, 6 Aug 2009 15:47:26 +0000
In-Reply-To: <200908062226.21948.lindner_marek@yahoo.de>
References: <200908051533.26117.lindner_marek@yahoo.de>
	<SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
	<SNT107-W36378936CB704146168424A60A0@phx.gbl> 
	<200908062226.21948.lindner_marek@yahoo.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv
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

--_10a63317-b78e-4f69-adb2-98e0fb3c7742_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Marek=2C

=20

Thanks for clearing this up.

=20

With no broadcom support in 2.6 then there is no kmod driver for batman.

=20

It looks like its back to the earlier version of that did work (batman 0.2-=
rv478-1) just that it did not forward same subnet arps. I realise that perf=
ormance is not going to be great with this but it will work

=20

To do this do I basically setup one subnet for the batman nodes to run in=
=2C then further subnets for the hosts at each wrt batman mesh node=2C then=
 just configure each batmand node to announce the host subnet?

=20

So for a 3 node mesh=2C break the default bridge=2C assign a static network=
 address to the eth0=2C assign a different subnet address to wl0

i.e

mesh node 1

eth0 172.16.1.1/24

wl0 192.168.1.1

run with batmand -a 172.16.1.0 wl0

=20

mesh node 2

eth0 172.16.2.1/24

wl0 192.168.1.2

run with batmand -a 172.16.2.0 wl0

=20

etc

=20

Does this look correct to allow say 172.16.1.2 on the ethernet of mesh1 to =
ping 172.16.2.2 on the ethernet of mesh2?

=20

Thanks again for sticking with this

=20

nick

=20

=20

=20
> From: lindner_marek@yahoo.de
> To: b.a.t.m.a.n@lists.open-mesh.net
> Date: Thu=2C 6 Aug 2009 22:26:21 +0800
> Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv
>=20
>=20
> Hi=2C
>=20
> > There seem to be 2 versions of advanced batman - batman-adv and
> > kmod-batman-advanced=2C however for the k8.09.1/brcm 2.4 release there =
does
> > not seem to be the kmod driver. So I have installed the batman-adv
> > (batmand-adv_r1176-1_mipsel.ipk and battools) there is no batctl here.
>=20
> batman-adv was the first attempt to write a layer 2 routing daemon.=20
> Unfortunately=2C due to the fact that it was written as user space applic=
ation=20
> it came with a big performance penalty. We ported the code into kernel sp=
ace=20
> by writing the batman-adv kernel module. Since the module is stable the d=
aemon=20
> is deprecated. The OpenWRT package was removed - not sure why you still c=
an=20
> install it.
>=20
> batctl comes with the batman-adv kernel module as it has nothing to do wi=
th=20
> the user space daemon.
>=20
> The kernel module requires linux 2.6 (nobody backported it to 2.4 yet). U=
nless=20
> you use the open source wifi drivers for the WRT you are stuck with the b=
inary=20
> only wl driver which runs on linux 2.4 only. That is why you can't select=
=20
> kmod-batman-advanced.
>=20
> Regards=2C
> Marek
>=20
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

_________________________________________________________________
Windows Live Messenger: Celebrate 10 amazing years with free winks and emot=
icons.
http://clk.atdmt.com/UKM/go/157562755/direct/01/=

--_10a63317-b78e-4f69-adb2-98e0fb3c7742_
Content-Type: text/html; charset="iso-8859-1"
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
Hi Marek=2C<BR>
&nbsp=3B<BR>
Thanks for clearing this up.<BR>
&nbsp=3B<BR>
With no broadcom support in 2.6 then there is no kmod driver for batman.<BR=
>
&nbsp=3B<BR>
It looks like its&nbsp=3Bback to the earlier version of that did work (batm=
an 0.2-rv478-1) just that it did not forward same subnet arps. I realise th=
at performance is not going to be great with this but it will work<BR>
&nbsp=3B<BR>
To do this do I basically setup one subnet for the batman nodes to run in=
=2C then further subnets for the hosts at each wrt batman mesh node=2C then=
 just configure each batmand node to announce the host subnet?<BR>
&nbsp=3B<BR>
So for a 3 node mesh=2C break the default bridge=2C assign a static network=
 address to the eth0=2C assign a different subnet address to wl0<BR>
i.e<BR>
mesh node 1<BR>
eth0 172.16.1.1/24<BR>
wl0 192.168.1.1<BR>
run with batmand -a 172.16.1.0 wl0<BR>
&nbsp=3B<BR>
mesh node 2<BR>
eth0 172.16.2.1/24<BR>
wl0 192.168.1.2<BR>
run with batmand -a 172.16.2.0 wl0<BR>
&nbsp=3B<BR>
etc<BR>
&nbsp=3B<BR>
Does this look correct to allow say 172.16.1.2 on the ethernet of mesh1 to =
ping 172.16.2.2 on the ethernet of mesh2?<BR>
&nbsp=3B<BR>
Thanks again for sticking with this<BR>
&nbsp=3B<BR>
nick<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>&gt=3B From: lindner_marek@yahoo.de<BR>&gt=3B To: b.a.t.m.a.n@l=
ists.open-mesh.net<BR>&gt=3B Date: Thu=2C 6 Aug 2009 22:26:21 +0800<BR>&gt=
=3B Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv<BR>&gt=3B <=
BR>&gt=3B <BR>&gt=3B Hi=2C<BR>&gt=3B <BR>&gt=3B &gt=3B There seem to be 2 v=
ersions of advanced batman - batman-adv and<BR>&gt=3B &gt=3B kmod-batman-ad=
vanced=2C however for the k8.09.1/brcm 2.4 release there does<BR>&gt=3B &gt=
=3B not seem to be the kmod driver. So I have installed the batman-adv<BR>&=
gt=3B &gt=3B (batmand-adv_r1176-1_mipsel.ipk and battools) there is no batc=
tl here.<BR>&gt=3B <BR>&gt=3B batman-adv was the first attempt to write a l=
ayer 2 routing daemon. <BR>&gt=3B Unfortunately=2C due to the fact that it =
was written as user space application <BR>&gt=3B it came with a big perform=
ance penalty. We ported the code into kernel space <BR>&gt=3B by writing th=
e batman-adv kernel module. Since the module is stable the daemon <BR>&gt=
=3B is deprecated. The OpenWRT package was removed - not sure why you still=
 can <BR>&gt=3B install it.<BR>&gt=3B <BR>&gt=3B batctl comes with the batm=
an-adv kernel module as it has nothing to do with <BR>&gt=3B the user space=
 daemon.<BR>&gt=3B <BR>&gt=3B The kernel module requires linux 2.6 (nobody =
backported it to 2.4 yet). Unless <BR>&gt=3B you use the open source wifi d=
rivers for the WRT you are stuck with the binary <BR>&gt=3B only wl driver =
which runs on linux 2.4 only. That is why you can't select <BR>&gt=3B kmod-=
batman-advanced.<BR>&gt=3B <BR>&gt=3B Regards=2C<BR>&gt=3B Marek<BR>&gt=3B =
<BR>&gt=3B <BR>&gt=3B <BR>&gt=3B __________________________________________=
_____<BR>&gt=3B B.A.T.M.A.N mailing list<BR>&gt=3B B.A.T.M.A.N@lists.open-m=
esh.net<BR>&gt=3B https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n<BR><b=
r /><hr />Windows Live Messenger: Thanks for 10 great years-enjoy free wink=
s and emoticons. <a href=3D'http://clk.atdmt.com/UKM/go/157562755/direct/01=
/' target=3D'_new'>Get Them Now</a></body>
</html>=

--_10a63317-b78e-4f69-adb2-98e0fb3c7742_--
