Return-Path: <ordex@autistici.org>
Date: Mon, 30 Jul 2012 12:16:33 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120730101633.GH2578@ritirata.org>
References: <1343603730-3824-1-git-send-email-ordex@autistici.org>
 <201207301147.03506.lindner_marek@yahoo.de>
 <20120730100704.GG2578@ritirata.org>
 <201207301212.19763.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <201207301212.19763.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the WIFI flag from the
 local to global entry
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


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2012 at 12:12:19PM +0200, Marek Lindner wrote:
> On Monday, July 30, 2012 12:07:04 Antonio Quartulli wrote:
> > > And why is this explanation not part of the commit message ?
> >=20
> > Because it is left as exercise for the reader ;-)
> > Actually I didn't mention it because the Ap-Isolation part is a
> > "consequence". What this patch wants to fix is an issue in the client
> > entry state consistency, regardless of the semantic of such state.
> >=20
> > Anyhow, if you think it is worth adding it, I will do that.
>=20
> Well, we need some explanations *why* we want this change. The way you ar=
e=20
> describing it now it sounds like we want to preserve all relevant flags d=
uring=20
> the transition from local to global client and vice versa ?

Yes, that is the message I had in mind while writing the commit message. Bu=
t ok,
I will send v2 and I'll be more verbose in order to let people understand w=
hat
this issue could lead to.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAWXwEACgkQpGgxIkP9cwdwYACcCeG+PmsFTzLMDRJ9E50Sj6IX
sZ8AoJfHbZjFicWawN20wfKM3QxJ+pOt
=+bUe
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
