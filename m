Message-ID: <48037EF6.7050306@fokus.fraunhofer.de>
Date: Mon, 14 Apr 2008 17:57:42 +0200
From: Sebastian Robitzsch <sebastian.robitzsch@fokus.fraunhofer.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Suitability of B.A.T.M.A.N. protocol to my	disaster
	relief network project
References: <4801C1DF.5080600@gmail.com>
	<20080414145207.GA7687@hrz.tu-chemnitz.de>
In-Reply-To: <20080414145207.GA7687@hrz.tu-chemnitz.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF30185C00CED37A04329550"
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF30185C00CED37A04329550
Content-Type: multipart/mixed; boundary="------------010601070104090509030802"

This is a multi-part message in MIME format.
--------------010601070104090509030802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey guys,

 I'm reading this mailing list since BATMAN is a potential approach for
a project of mine (which envisages an emergency scenario as well).
Anyway ... Tim - As far as I've understood you try to build a Mesh with
a WiMAX backhaul that consists of WiFi based APs ... right?

I propose BATMAN focuses on _mobile_ ad-hoc networks and WiMAX is still
more a carrier grade technology (see the minor comment within this
mail). From this it follows the question whether BATMAN is really a good
choice for creating a Mesh network based on WiMAX backhaul AND WiFi
APs... it's my point of view ;) ...
Nevertheless, BATMAN could be a feasible routing algorithm that has to
be extended.

some more comments inline ...


Rgds,
Sebastian

Simon Wunderlich wrote:
> On Sun, Apr 13, 2008 at 03:18:39AM -0500, Tim LePes wrote:
>> Greetings!
>>
>> If this list is the wrong place to be asking about this, please let me=

>> apologize up front.  :)
>=20
> This is exactly the right place to ask questions about B.A.T.M.A.N.,
> don't hesitate ... ;)
>=20
> =20
>> I am thinking of putting WiMAX radios in the mesh nodes, for the
>> purported range.  There are several things that I am unsure of, so any=

>> suggestions or comments on any points are more than welcome.  Forgive =
me
>> if I just ramble out some of my thoughts/questions here...
>>
>> Is WiMAX a good choice for this?  I have not really seen a lot of WiMA=
X
>> hardware.  The SoC board will be running Linux and is a PowerPC
>> architecture, so drivers will of course be important with whatever
>> radios go in the device.
>=20
> Personally i have no experience with WiMAX. As far as i could read,
> there seems to be a "mesh mode" in WiMAX, but i have no idea on which r=
outing
> protocol it is based.

just a minor comment on this: the 802.16j standard is released as a
draft (version3 - I think). This provides a Mesh network based on WiMAX.
But it is still a draft standard and has not been implemented (driver),
yet.

> Another interesting thing would be if it is
> already implemented ....
> A fairly new site is: http://linuxwimax.org/ which provides intel
> wifi/wimax link 5050 support.=20
> If i had the choice, i'd personally stick to WiFi as it's well tested,
> and keep the option to integrate WiMAX later, if it proves to be usable=
=2E
> :)
>=20
>> Would it be best to have two radios in the mesh nodes?  If only one is=

>> needed, then perhaps I can put one WiMAX for the backhaul and one
>> regular WiFi 802.11a/b/g and provide a WAP for the downlink sites.  Or=

>> simply save on the BoM by only using single radios.  Or maybe single
>> radios would work for the nodes comfortably "meshed" with others, but
>> dual-radios could be used in a directional repeater node specifically
>> made to extend the mesh connectivity over distances?  Or do I have tha=
t
>> backwards?  Maybe multiple radios would be better for the chatty
>> meshed-up nodes versus the far-flung nodes making a chain back to the
>> internet connectivity points at the periphery of a disaster area.  I a=
m
>> certainly open to any suggestions on other technologies to consider, t=
oo.
>=20
> Multiple radios are always a good idea, e.g. having a backhaul in
> 802.11a (5ghz band) and AP in 802.11bg (2.4 Ghz). Minimizing
> interferences is always a good idea, and you could replace one radio
> later with a WiMAX radio, if you want to.
>=20
>> How well do BATMAN or other meshes scale?  What is the ideal density f=
or
>> nodes in the mesh, and how much better does it get with more node
>> density before you have a diminishing return?
>=20
> Depends very much on your setup. If you use many nodes in one area in
> the same band, you'll probably have lot of interferences and packet los=
s.=20
> If you have lots of "direct connections", you have less flexibility but=

> probably less interferences, and better link quality. B.A.T.M.A.N. and
> OLSR would scale up at least into a few hundreds participants afaik, so=
=20
> it's not a problem of the routing daemon.
>=20
>> How bad is the latency?  Is VoIP do-able?  Is it do-able for a few hop=
s
>> (like between field sites) but simply not do-able for longer trips out=

>> to the periphery of the mesh, where the internet connectivity is likel=
y
>> to be?
>=20
> This also depends very much one the link quality. With lots of
> interences, VoIP won't be fun with even in only 1 or 2 hops. In a
> "clean" enviroment, this should work quite well.
> As you probably know, WiFi retransmits packets on errors, so if you hav=
e
> much noise, the latency will rise, and VoIP will probably become
> unusuable.=20

IMO, if you think about an emergency scenario where the actual
infrastructure is down, you can assume around 5ms latency per WiFi node
if you care about radio management and channel selection. For WiMAX you
can assume around 15 ms per node (depends on the QoS profile).

>=20
>> Is this even the right approach to this sort of connectivity problem? =
 I
>> can see a mesh being useful for field-sites communicating with each
>> other.  But often I have seen that the ideal with a mesh is to have th=
e
>> internet-connected nodes be in the center of the mesh whereas in this
>> scenario, typically, the internet connection is only to be had at the
>> periphery.  Would it be better to have a split role system where
>> long-range internet connectivity is brought out over distance using so=
me
>> long-range repeater set-up, and the mesh spawned off from the end-poin=
t
>> of this line? (Or multiple such lines)?
>=20
> Mhm, you could build such long range extra lines, and having them on
> another channel would be better for interference reasons. These long-ra=
nge
> lines could go into the middle of the mesh, and B.A.T.M.A.N. could take=

> control of both radios (the adhoc one the and the long-range one). Stil=
l,
> all the Nodes would be B.A.T.M.A.N. nodes. The seperation would be just=
 a=20
> physical, not a logical one.
>> How much does the actual routing of traffic tax the processor in a mes=
h
>> node?  These boxes have 128Mb and can have a hard drive or SSD in them=
=2E
>> They run a fairly complete Linux on them.  I am already imagining they=

>> can be managed via http with a web interface fairly easily.  But I am
>> curious to find out how much more room I have to run other softwares. =
 I
>> have thought of them having the ability to boot found/donated PCs over=

>> PXE and bootstrapping Linux on the computers, served by the mesh node
>> (now a pxe/bootp server in addition to dhcp), to make quick and easy
>> internet terminals/kiosks.
>=20
> That's plenty. B.A.T.M.A.N. is designed to run on Linksys WRT machines,=
 which
> only have 8 to 32 Megs of RAM. It also does not have any dependencies
> (except Linux and libc ;).
> The stripped binary on my machine is 83kbyte. Space shouldn't be a
> problem here.
>=20
>> I would like to make the network as dead-simple to set up as possible.=

>> Emergency workers have enough to worry about without having to become
>> network experts.  At most I would expect that they could connect a
>> laptop to the Ethernet port and configure the devices with a web
>> interface.  But ideally I would like there to be zero configuration
>> on-site, if possible.  Plug and go, so long as you're in range.  Of
>> course there would have to be some management console (probably web
>> based) to get an idea of signal strengths, network performance, etc. f=
or
>> troubleshooting and fine tuning the network.
>=20
> That's possible, just make sure that each machine has an individual IP.=

> (If you use batman-advanced, you don't even need IPs, but it helps ;)
> Having a managment console would still be a good thing if you build up
> long-shots [1]. You'll see that long distants can be covered with WiFi
> too. Seeing the link qualities is always a good idea so you can plan
> where you could set up more routers. We have a visualization server [2]=
 for
> this. It simply offers a graph in graphviz-format [3], which can also b=
e
> displayed with fancy 3D tools [4] as we did. ;)
>=20
> Hope i could answer at least a few questions ...
>=20
> Best Regards,
> 	Simon
>=20
> [1] http://events.ccc.de/congress/2005/fahrplan/events/1078.en.html
> [2] http://open-mesh.net/batman/vis
> [3] http://graphviz.org/
> [4] http://s3d.berlios.de/
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--------------010601070104090509030802
Content-Type: text/x-vcard; charset=utf-8;
 name="sebastian_robitzsch.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="sebastian_robitzsch.vcf"

begin:vcard
fn:Sebastian Robitzsch
n:Robitzsch;Sebastian
org:Fraunhofer Gesellschaft;FOKUS.NETwork research
adr;dom:;;Schloss Birlinghoven;Sankt Augustin;;53754
email;internet:sebastian.robitzsch@fokus.fraunhofer.de
title:Dipl.-Ing.(FH)
tel;work:+49 (0)22 41 - 14 2785
tel;fax:+49 (0)22 41 - 14 4 2785
tel;cell:+49 (0)1 72 - 3 52 80 72
note;quoted-printable:Skype:	seronline82=3D0D=3D0A=3D
	Jabber:	seronline@amessage.info=3D0D=3D0A=3D
	=3D0D=3D0A=3D
	www.seronline.de
x-mozilla-html:FALSE
url:www.fokus.fraunhofer.de/go/net/
version:2.1
end:vcard


--------------010601070104090509030802--

--------------enigDF30185C00CED37A04329550
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIA376v/InKjI/tV8RAn6cAJ9Gl7Cf54jMB06N5seBJT0ktMHKmwCg2jDW
+1+tcFas+YrHllZC+EdsFeU=
=fNJc
-----END PGP SIGNATURE-----

--------------enigDF30185C00CED37A04329550--
