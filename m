Return-Path: <ordex@autistici.org>
Date: Sat, 31 Mar 2012 23:43:23 +0300
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120331204322.GA31423@ritirata.org>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 31, 2012 at 04:22:06 -0600, dan wrote:
> I can't see anything in my reading on this.
>=20
> Is there a mechanism to identify throughput between two nodes? or
> between a client and a destination for the purpose of routing through
> the highest throughput path?
>=20
> For instance, track the maximum throughput on each interface over
> time. Compare it to the current throughput on the interface and send
> what is leftover as 'available throughput' with the TQ each node.  Now
> instead of adding up the numbers as with TQ, just take the min.  Take
> the lowest throughput along the path and have a node be able to
> utilize the highest throughput path that has acceptable TQ.  As a
> node's interface gets loaded up (vs observed maximum) it will inform
> it's neighbors in the same way it informs them of the TQ of each
> interface and then the neighbors can choose to route around if there
> is a good alternate path.
>=20
> Basically, I'm thinking that TQ isn't the only or most optimal way to
> route simply because available throughput should be considered
> somehow.  As far as I can tell, a 56k link with .001% packet loss is
> better than a 54Mb link with .1% packet loss, though both are solid
> interfaces and the 54Mb link should be prefered heavily over the 56k
> link.  The 56k link probably will start dropping packets once it is
> saturated, but one client might run up against slow ACKs keeping the
> remote server from sending enough data to saturate the connection so
> the client could be getting a very slow connection while a 54Mb link
> sits virtually unused.

Hello Dan,

there is not such mechanism in batman-adv right now. It is a really good id=
ea
and we already started to think about that during WBMv5. Personally, I'm
applying to the GSOC2012 and I'm proposing something similar.

I also think that packet loss is not the correct way to go.

Regarding your idea, how would you measure the maximum throughput?


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPd2xqAAoJEFMQTLzJFOZFbVAH+wcUJn2Z1ArryYBhtLmVmvGw
EnD7AoHmJi9VkZ6KrUFMjUDQiUmvG4VPR+ur+g2ZDk9s/urxI0YBVUflL1z0CsrR
b3LYLxU1mUbW+4P60Q4bYgq9AHuNx/P0aNHNswi98iqfGHGu5jIUmBFvtM6wTLGn
CVaLC0aLdS9SGNphwQ8NUFqM905rCKAhYG4UrDKFB0tIgNLA6oxOpc29SsFwCk29
Qn5E/U0ltCYZDDtoluWnXmxhTevv2acdOCXD3ONFOyQxAziEXZ2TyT6r2z+W+Oq2
pB9Rtp2ybHS02NIlQTwSCxjtSaO8eFiekp5fmUEtlNX+WDqc0B1ut+mxlw6Me/c=
=UB2o
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
