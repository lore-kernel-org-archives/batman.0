Return-Path: <nickthefarrow@hotmail.com>
Message-ID: <SNT107-W1743C6216DE9D4A6F5A50BA60D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8b83fcbb-2061-45cd-98d6-d36c73a937c3_"
From: nick farrow <nickthefarrow@hotmail.com>
Date: Wed, 5 Aug 2009 08:30:30 +0000
In-Reply-To: <200908051533.26117.lindner_marek@yahoo.de>
References: <200908051533.26117.lindner_marek@yahoo.de>
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

--_8b83fcbb-2061-45cd-98d6-d36c73a937c3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Marek=2C

=20

Thanks for the reply.

=20

All the mesh nodes and test PC are in the same subnet 172.16.1.1=2C2=2C3=2C=
 with the PC on 172.16.1.4 attached to the ethernet on .3


I had thought that as they all on the same subnet and bridged that this wou=
ld be sufficient just relying on standard arps across the entire network as=
 there is no routing. On this basis I assumed there is no need to announce =
any networks/hosts. Is this a correct understanding?

=20

Regards

=20

nick

=20
> From: lindner_marek@yahoo.de
> To: b.a.t.m.a.n@lists.open-mesh.net
> Date: Wed=2C 5 Aug 2009 15:33:25 +0800
> Subject: Re: [B.A.T.M.A.N.] Routing help?
>=20
>=20
> Hi=2C
>=20
> >I have 3 linksys wrt54 flashed with openwrt 7.09=2C webif'ed and install=
ed
> > BATMAN 0.2-rv478.1=2C all OK I think.
>=20
> not sure what web interface you installed but are you aware of the fact t=
hat=20
> revision 478 is more than 2 years old ? Your current problem seems unrela=
ted=20
> to batman but if you experience trouble / bugs with batman it might be wi=
se to=20
> upgrade to the latest stable release.
>=20
>=20
> >From the ssh prompt on .3 I can ping .2 with no loss and ping .1 with ~ =
6%
> > loss. However=2C if I try to ping .1 from the pc connected on the ether=
net
> > port of .3 I get no route to host. Putting wireshark on the ethernet if=
c
> > shows the arp going out but nothing coming back. Interestingly enough i=
f I
> > ssh into .3 and ping .1=2C with wireshark running on the ethernet of .3=
 Is
> > see the outgoing ICMP but not the reply (which is there because the pin=
g
> > succeeds) . It seems as if the local host traffic is not truly bridged.
>=20
> You bridged the LAN & WLAN on every device but the devices are not bridge=
d=20
> with each other=2C hence you mix bridges & routing.=20
>=20
> What IP address did you assign to your PC ? Does your PC have a route tow=
ards=20
> the .1 (probably not) ? You also have make sure that all nodes have a rou=
te=20
> towards your PC. You can achieve that using HNA. See:
> http://www.open-mesh.net/wiki/AnnouncingNetworks for a detailed explanati=
on.
>=20
> Regards=2C
> Marek
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

--_8b83fcbb-2061-45cd-98d6-d36c73a937c3_
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
Thanks for the reply.<BR>
&nbsp=3B<BR>
All the mesh nodes&nbsp=3Band test PC are in the same subnet 172.16.1.1=2C2=
=2C3=2C with the PC on 172.16.1.4 attached to the ethernet on .3<BR><BR>
I had thought that as they all on the same subnet and bridged that this wou=
ld&nbsp=3Bbe sufficient&nbsp=3Bjust relying on standard arps across the ent=
ire network as there is no routing. On this basis I assumed there is no nee=
d to announce any networks/hosts. Is this a correct understanding?<BR>
&nbsp=3B<BR>
Regards<BR>
&nbsp=3B<BR>
nick<BR>
&nbsp=3B<BR>&gt=3B From: lindner_marek@yahoo.de<BR>&gt=3B To: b.a.t.m.a.n@l=
ists.open-mesh.net<BR>&gt=3B Date: Wed=2C 5 Aug 2009 15:33:25 +0800<BR>&gt=
=3B Subject: Re: [B.A.T.M.A.N.] Routing help?<BR>&gt=3B <BR>&gt=3B <BR>&gt=
=3B Hi=2C<BR>&gt=3B <BR>&gt=3B &gt=3BI have 3 linksys wrt54 flashed with op=
enwrt 7.09=2C webif'ed and installed<BR>&gt=3B &gt=3B BATMAN 0.2-rv478.1=2C=
 all OK I think.<BR>&gt=3B <BR>&gt=3B not sure what web interface you insta=
lled but are you aware of the fact that <BR>&gt=3B revision 478 is more tha=
n 2 years old ? Your current problem seems unrelated <BR>&gt=3B to batman b=
ut if you experience trouble / bugs with batman it might be wise to <BR>&gt=
=3B upgrade to the latest stable release.<BR>&gt=3B <BR>&gt=3B <BR>&gt=3B &=
gt=3BFrom the ssh prompt on .3 I can ping .2 with no loss and ping .1 with =
~ 6%<BR>&gt=3B &gt=3B loss. However=2C if I try to ping .1 from the pc conn=
ected on the ethernet<BR>&gt=3B &gt=3B port of .3 I get no route to host. P=
utting wireshark on the ethernet ifc<BR>&gt=3B &gt=3B shows the arp going o=
ut but nothing coming back. Interestingly enough if I<BR>&gt=3B &gt=3B ssh =
into .3 and ping .1=2C with wireshark running on the ethernet of .3 Is<BR>&=
gt=3B &gt=3B see the outgoing ICMP but not the reply (which is there becaus=
e the ping<BR>&gt=3B &gt=3B succeeds) . It seems as if the local host traff=
ic is not truly bridged.<BR>&gt=3B <BR>&gt=3B You bridged the LAN &amp=3B W=
LAN on every device but the devices are not bridged <BR>&gt=3B with each ot=
her=2C hence you mix bridges &amp=3B routing. <BR>&gt=3B <BR>&gt=3B What IP=
 address did you assign to your PC ? Does your PC have a route towards <BR>=
&gt=3B the .1 (probably not) ? You also have make sure that all nodes have =
a route <BR>&gt=3B towards your PC. You can achieve that using HNA. See:<BR=
>&gt=3B http://www.open-mesh.net/wiki/AnnouncingNetworks for a detailed exp=
lanation.<BR>&gt=3B <BR>&gt=3B Regards=2C<BR>&gt=3B Marek<BR>&gt=3B <BR>&gt=
=3B <BR>&gt=3B _______________________________________________<BR>&gt=3B B.=
A.T.M.A.N mailing list<BR>&gt=3B B.A.T.M.A.N@lists.open-mesh.net<BR>&gt=3B =
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n<BR><br /><hr />Windows =
Live Messenger: Thanks for 10 great years-enjoy free winks and emoticons. <=
a href=3D'http://clk.atdmt.com/UKM/go/157562755/direct/01/' target=3D'_new'=
>Get Them Now</a></body>
</html>=

--_8b83fcbb-2061-45cd-98d6-d36c73a937c3_--
