Return-Path: <antonio@meshcoding.com>
Date: Sat, 23 Nov 2013 17:15:16 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131123161516.GH311@neomailbox.net>
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net>
 <20131101143305.GO6252@medion.lan>
 <20131101143903.GX970@neomailbox.net>
 <20131101151626.GP6252@medion.lan>
 <5275F6CC.9080009@altermundi.net>
 <20131103091832.GR6252@medion.lan>
 <52761A86.5080106@altermundi.net> <20131123092445.GN886@medion.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline
In-Reply-To: <20131123092445.GN886@medion.lan>
Subject: Re: [B.A.T.M.A.N.] lost connection to a client / Q:
	transglobal-table
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2013 at 10:24:45AM +0100, Bastian Bittorf wrote:
> * Gui Iribarren <gui@altermundi.net> [03.11.2013 20:37]:
> > btw, even with the ebtables rule, we had to turn off DAT in a
> > scenario equivalent to yours, because the DAT cache was also acting
> > funny (DUP arp replies from each node in the cloud)
> > haven't got around to properly debug it / report it, but still, be warn=
ed :)

I think all these strange behaviours are coming from the fact that what you=
 guys
are trying to do is not really supported by the underlying layer (batman-ad=
v).

I think a better idea is to start thinking how to bring anycast support in
batman-adv other than trying to mess up the rest :) That would surely help =
the
entire community.

After the last WBM we concentrated our efforts in creating a starting point=
 for
a "more general" solution and we collected the results in this page [*].

This page describes what you probably want to achieve at the end, so workin=
g all
together to make it possible would probably be the best option (instead of
trying to workaround unsupported setup and then asking for help to debug
inconsistent behaviours....).

> root@box:~ batctl dc
> Distributed ARP Table (bat0):
>           IPv4             MAC           last-seen
>  *  192.168.222.61 00:21:6a:32:7c:1c      3:50
>=20
> after some seconds the client disappaers from DAT-cache:

As you can imagine DAT is a cache and if it does not get refreshed
often enough the content will slowly disappear. Right now the timeout is 4
minutes and this is why "after" few second your entry goes away (it is at 3=
:50
at that moment). If you have not yet read the documentation, [1] explains t=
he
mechanism behind it.

>=20
> root@box:~ batctl tl
> Locally retrieved addresses (from bat0) announced via TT (TTVN: 2 CRC:
> 0x6023):
>        Client        Flags   Last seen=20
>  * 00:21:6a:32:7c:1c [....W]   0.010
>=20
> root@box:~ batctl dc
> Distributed ARP Table (bat0):
>           IPv4             MAC           last-seen
>=20
> after some time even the 'translocal-table' is empty, although with
> 'iw dev wlan0 station dump' i can see the active client. i'm
> normally connected, can ping/ssh the node itself but not further.
> (only hop by hop)
>=20
> how does batman detect, if a client is active? (can i trigger is somehow?)
> what can i do tho debug further?
>=20

As written in [2]:
"Every client MAC address that is recognized through the mesh interface wil=
l be
stored in a node local table called "local translation table" which will co=
ntain
all the clients the node is currently serving."

So if your client is timing out it means that no packet originated by it is
reaching your mesh interface.

If you want to debug further now you have to ask yourself what are you doin=
g to
prevent packets to reach bat0 :-)


Cheers,


[*] http://www.open-mesh.org/projects/open-mesh/wiki/Connecting-Batman-adv-=
clouds
[1] http://www.open-mesh.org/projects/batman-adv/wiki/DistributedArpTable-t=
echnical
[2] http://www.open-mesh.org/projects/batman-adv/wiki/Client-announcement

--=20
Antonio Quartulli

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSkNSUAAoJEADl0hg6qKeOp/kP/36dIoXlbEC8wGkcE4LXTjXf
VxGs7bSjeNkH+plfMONFa6sO4HhvmOusEkR8hv5P1zLrNdjG+/uIpTzULwUlc8Fj
KMPI92eCkchQ+oh1DDUHcNFn16o4sbTKx+9WuE2ry3KMWWi+k2f12roXncfowph9
c58HwtdFwkmb0ObGOSS9O1VMPejdStDL58AI1YnRwimYdJnwmiElKulq6X8Hlbe6
mjweEzavjNdlaZYZpLm7fv/FBbdU+vfypL6z0zau1o72D2VnvpbIL48sNxbDGEgW
KK8e6D30Xa4eiFossSblDVMpAVJI0mYRGN/OaUZ6zTFv9hXahPKBdLY694MyerNK
yM8+3WN5YcWIATl6CfZvHn6tPkKnQPBW2BiIJbcXVV0r6AY/1EZ0RC8HSlPyyZ8n
etSWDg3p3GMEfXK7yr/exWn4GEw2dLiNA71OSgJDNPK/Mg5HS1oQBGm+/8n3nz1L
YeBSprJKPF2gxwHzENyBkef121Zdk/8aZfxP1Qikv0eCCv+Sggg5+fzGmh78ZC/0
/fo7trIrQZEGxFlZxgVO9klR4PcOslJ1uBxlJ50GpNWZPmR6L9t6Mk0NSZppz5Fs
weugf+T7zQEkOjy8yRR4ZLiF7T6n42tZ5hOZW/U6WSctvcgZS8hFXkY9PVUdv6Iv
fIz/Fwzsy3iWZbNU1NIq
=g0ZP
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--
