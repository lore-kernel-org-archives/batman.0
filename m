Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 18 Jan 2010 23:57:01 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100118225701.GA14262@pandem0nium>
References: <20100104182710.GA24091@pandem0nium>
	<20100117201558.GA8696@pandem0nium>
	<201001181931.22344.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <201001181931.22344.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add bonding functionality
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


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whoops,

this is definitly a bug, thanks for pointing that out. Committed in r1552.

On Mon, Jan 18, 2010 at 07:31:22PM +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> > i've just committed this patch in revision 1551, as no further comments=
 and
> >  critiques came in. I would consider this patch rather simple, and as
> >  experimental feature it is switched off by default anyways ... :)
> >=20
> > I've changed only a small thing in the committed patch: When neighbors =
are
> >  purged, the bonding candidate list gets updated instead of bonding
> >  switched off.
>=20
> did not have the time to go through your patch in much detail. I just scr=
olled=20
> over it and stumbled over routing.c line 1018. I guess you wanted to writ=
e:
> spin_*un*lock_irqsave(&orig_hash_lock, flags);
>=20
> Regards,
> Marek
>=20

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktU5z0ACgkQrzg/fFk7axaOKwCg3Ee1s7lQhD8ru5tyJpemIaFG
NfwAni1JOzQDpyOAocESGfXcsavKmvRb
=QeRQ
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
