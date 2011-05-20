Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2011 10:37:52 +0200
References: <201105200955.27323.sven@narfation.org>
In-Reply-To: <201105200955.27323.sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3902460.oYQnQ6rCns";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105201037.53737.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] batman-adv bug 149: odd broadcast behavior --
	generated CRC errors
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: dbeberman@aicas.com

--nextPart3902460.oYQnQ6rCns
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Hi,
>=20
> I would assume that you don't monitor the bug as you didn't answer the
> questions on irc. So here the part of the IRC communication which needs
> comments/answers from your side.
[...]

Just talked to Marek and we both are a little bit irritated by following pa=
rt=20
of your first "mail":

> > Further, if the UDP packet is large enough to fragment into 2 packets, a
> > total of 6 packets are  broacast, with only the very last packet being
> > broadcast without error.

We don't know what fragmentation you are talking here. batman-adv doesn't=20
fragment the broadcast packet, wifi shall not fragment the broadcast packet:

"only mpdus with a unicast receiver address shall be fragmented.=20
broadcast/multicast frames shall not be fragmented even if their length=20
exceeds dot11FragmentationThreshold" - ieee802.11-2007 page 255

So the only fragmentation seems to be the IP(v6) fragmentation - and this=20
would mean that batman-adv only sees two independent packets which it=20
rebroadcasts complete independent - therefore it doesn't make any sense tha=
t=20
only the last of 6 packets isn't destroyed by the resend mechanism.

Could you please exactly tell us on which layer and which situation you=20
experienced what behaviour and how you did your measurements.

Kind regards,
	Sven

--nextPart3902460.oYQnQ6rCns
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1ihgAAoJEF2HCgfBJntGlyUQAKJqitBIfFfzjl0mVneLuW7R
fFPCwWkCtD2Y266CQa6bRLVmxIAnUrq830v9OS0Cz0gGlOZma5fsc10mk95wV9fa
CiDLfsP0FPvlKGBaNQ34Yi7bwbx88MxuuB/++W/ScFlwTcPbNYddVojzZvzLXkT7
E0KQf+PPIWHD8/yUhEJm1iC7U5VSa0dx2Kprht/SD0QRwWUl0hybhWBaEO2mtg3j
zDTON/aT4CqNV0hio/YvLiwT70o0IgjSPzbr+H62mOuX2KLhsMH3YDMNYnGM3HGB
9gVfivuWoYuWHRiT2G7Az2nv4Jv8hn/DEWJrmRXvdDKA4NZQSJyl8xQa3CgY0hvz
DgD7GISCInw/TycfCRdKZLPUYRbOv75I2NCR0VyoTo8fcE5Km9WIJIstzNd8owRl
OrYfMFlC290jlSjPQwvsff2MSpPJy5ZtGVH34l2L9901bwo/hRondzuzFR89TonE
Kr/SSQ11oueO9seQ/nVhg1rECttY7lOP6nw6S+AzJXikvnpvmZjeFZWuKxGvh5Ji
Lz4kY3QIziwwaC7MSjTQwh3StuMotsGaDbJc+CUOXdsUoQS1fk2vEo5z8ig9bPb6
MMFESul6ouQK9saZX0Zf0HcoE9jbEgrI7v9yaXVEzgLQ9sWSwY0c/7Hk2rAm2OYi
lXJA8SfAAkHBe0ND7j66
=aKdB
-----END PGP SIGNATURE-----

--nextPart3902460.oYQnQ6rCns--
