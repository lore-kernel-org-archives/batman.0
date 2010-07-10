Return-Path: <hrogge@googlemail.com>
From: Henning Rogge <hrogge@googlemail.com>
Date: Sat, 10 Jul 2010 10:54:41 +0200
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<4C37C205.3030003@tiwoc.de>
	<201007101040.53995.sven.eckelmann@gmx.de>
In-Reply-To: <201007101040.53995.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1382412.m8FVn0IXqr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007101055.11401.hrogge@googlemail.com>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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

--nextPart1382412.m8FVn0IXqr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Samstag 10 Juli 2010, 10:40:52 schrieb Sven Eckelmann:
> Daniel Seither wrote:
> > Am 10.07.2010 01:07, Sven Eckelmann wrote:
> > > batman-adv works quite well for us - but that doesn't mean that it is
> > > good in context of the current kernel development. And who should know
> > > it better than the netdev guys.
> >=20
> > Hagen Paul Pfeifer suggested in his message "a generalized architecture
> > and a user space implementation of the protocol". What came to my mind
> > when I read this again was a division of control plane and
> > data/forwarding plane as known from traditional routing.
> >=20
> > The whole forwarding stuff would stay in the kernel, using a simple
> > routing table (for destination X, send to node Y on interface Z).
>=20
> This would go against the bonding/alternating functionality.
The bonding/alternating functionality could be part of the routing framewor=
k.=20
I think there is something similar on IP layer routing in linux.

(a framework like this would make it very easy to port additional routing=20
daemons for layer 2 routing, I already hear the 802.11s group crying becaus=
e=20
of competitors ;) ).

Henning Rogge

=2D-=20
1) You can't win.
2) You can't break even.
3) You can't leave the game.
=E2=80=94 The Laws of Thermodynamics, summarized

--nextPart1382412.m8FVn0IXqr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkw4NVYACgkQcenvcwAcHWdsawCfaYJsZmwf17qrTxiFW//g3+rR
CskAnRPbGPksU3BhifhXe2xu2nFHaN4g
=DPEc
-----END PGP SIGNATURE-----

--nextPart1382412.m8FVn0IXqr--
