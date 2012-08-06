Return-Path: <ordex@autistici.org>
Date: Mon, 6 Aug 2012 15:43:09 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120806134309.GK12879@ritirata.org>
References: <501FC12D.3040608@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1rguoi8KZGYj2k4L"
Content-Disposition: inline
In-Reply-To: <501FC12D.3040608@gmail.com>
Subject: Re: [B.A.T.M.A.N.] multicast packet loss
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
To: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--1rguoi8KZGYj2k4L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2012 at 03:05:49PM +0200, Gioacchino Mazzurco wrote:
> Hi all!
>=20
> I am experiencing a multicast packet loss on batman-adv mesh, this can
> appear normal but it is not because the mesh is on top of wired Ethernet
> link!
>=20
> the host fe80::c8e0:2cff:fe9b:6d1f is sending a multicast hello message
> every 4 seconds on bat0 interface, but as you can see from the dump
> timing on a machine attached on the same switch they are not arriving
> regurarly so what is happening? Is this normal?

Hello Gioacchino,

I'd say that losing packets is not normal :-)
Have you tried to use batctl td on the wired interface? You should see the
"broadcast" packets going around. It would be interesting to understand if =
on
batctl you had more packets than what you are receiving on the node.

Cheers,


p.s. what kind of hello messages are they? Their size is changing over time=
=2E.

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--1rguoi8KZGYj2k4L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAfye0ACgkQpGgxIkP9cwcsawCfV5JHaA5iWHv0zFgB+x9F9bQV
AD0An07OC6H+jzZ5a3o63LNp3R9HGEIi
=YqmT
-----END PGP SIGNATURE-----

--1rguoi8KZGYj2k4L--
