Return-Path: <ordex@autistici.org>
Date: Thu, 29 Nov 2012 04:28:21 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121129032821.GI32479@ritirata.org>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg5UinZxugVHYRyK70tUFTPQ7FHqRAsn0GP_gV=EZVMWtQ@mail.gmail.com>
 <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
 <201211291125.33400.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <201211291125.33400.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2012 at 11:25:33AM +0800, Marek Lindner wrote:
>=20
> HI,
>=20
> > Now I switch to MAC address of bat0 as the source and destination
> > address. In this case, I only have two nodes. Node A and node C.
> >=20
> > Now, I cannot send packet from node A to node C, and vice versa.
> > However, when I do batctl tcpdump bat0 on the receiver side, I can see
> > print out shown in the following.
> >=20
> > Warning - packet contains unknown ether type: 0x1337.
> >=20
> > Not sure what should I do now.
>=20
> this just means that batctl does not know how to print this packet type. =
Not=20
> surprising - you just created the packet type yourself. How should batctl=
 know=20
> about it ?=20
>=20
> I'd say if you get this warning on the other end your packet was successf=
ully=20
> delivered.
>=20
> Antonio, wouldn't it be possible to get the bat0 mac address from the glo=
bal=20
> table even if there were other clients bridged into that node ? The bat0 =
entry=20
> should be the only one with the no_purge flag set.

That is a local flag. It is not advertised and so not reported by the Global
Translation Table.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlC21lUACgkQpGgxIkP9cwd9eACgmRZ/5eqh7BUsuvmNblG9qZVZ
4r0AnAkEvjjFpEL8dEq3/WqU4GaYCVEE
=IZVO
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
