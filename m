Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 Jul 2014 11:01:30 +0200
References: <53D00BAF.9070506@hachmer.de> <53D05D84.20700@altermundi.net>
 <88409a9ed363089a1dfc08d0baa9dea5@hachmer.de>
In-Reply-To: <88409a9ed363089a1dfc08d0baa9dea5@hachmer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart703101406.ZCTHEYG3ZC";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201407241101.34652.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] alfred - one gateway - multiple interfaces
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart703101406.ZCTHEYG3ZC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Tobias,

thank you very much for stating your requirement - even if that it's not=20
implemented yet, maybe there are people out there who want that too and can=
=20
help implenting it. It shouldn't be too hard ...

> As I said, a workaround could be to just simply duplicate the init
> script (adjusting all relevant names like pid and so on, of course).

I'd like to point out that you'd also need to add an option in alfred and i=
ts=20
clients to duplicate the unix socket used to communicate between alfred=20
clients and the server - currently that is hardcoded:

#define ALFRED_SOCK_PATH		"/var/run/alfred.sock"

>=20
> But there could be more communities out there which will stumble over
> the same issue, sooner or later. So I just wanted the developer to know,
> that there is such a requirement.
>=20
> And, maybe, this could be achieved in a way we don't know about?
> Anybody here?

In any case, if someone wants to work on that, patches are welcome :)

Cheers,
    Simon

--nextPart703101406.ZCTHEYG3ZC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPQy2oACgkQrzg/fFk7axZUXgCgtwQYiZn5Q+APM6NUC9uELCny
rA4AoOWCAuQsx9WChXIM+TIevcSbwn91
=ykDf
-----END PGP SIGNATURE-----

--nextPart703101406.ZCTHEYG3ZC--
