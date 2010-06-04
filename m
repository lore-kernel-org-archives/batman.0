Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 4 Jun 2010 18:37:04 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100604163704.GA5425@pandem0nium>
References: <20100525225411.GA23108@pandem0nium>
	<201005261239.35972.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <201005261239.35972.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: bonding
	and	interface alternating
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

i've checked in a changed and fixed up version of this patch in r1686.

This version has the interface alternating enabled by default, so
we don't need to change the "bonding_enabled" to "bonding_mode" anymore.
We have decided here in Bracciano to have alternating as default as it
appears to be beneficial most of the times, but we couldn't really think
of a scenario where this might be a problem.

I've also added some documentation at
http://www.open-mesh.net/wiki/bonding-alternating
and i'm looking for comments and proofreading and comments. ;)

I've also followed your other comments (hopefully correctly), so thank=20
you very much for the review.

best regards
	Simon

On Wed, May 26, 2010 at 12:39:22PM +0200, Sven Eckelmann wrote:
> Only some non-technical comments about the patch for now:
>=20
> I thought we decided that the "Staging: " part in the title will be appen=
ded=20
> when the stuff will be send to Greg and should be omitted inside our sour=
ce=20
> trees. Also your patch wouldn't apply in linux-next because the bonding s=
tuff=20
> is in master and not in maint (only maint will be send to the kernel folk=
s).
>=20
> > This is an experimental patch and targeted for upcoming experiments at
> > Wireless Battle Mesh v3 in Bracciano/Italy.
> >=20
> > Feedback, comments and reviews appreciated!
>=20
> That part is quite interesting for the mailinglist but should not be part=
 of=20
> the commit message, or am I wrong? In that situation such information sho=
uld=20
> be appended after the "---". git-am or similar tools should automatically=
=20
> ignore that parts, but the receiver can still read that comment.
>=20
> > Index: a/batman-adv-kernelland/main.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/batman-adv-kernelland/main.h	(revision 1679)
> > +++ a/batman-adv-kernelland/main.h	(working copy)
> > @@ -63,6 +63,10 @@
> >   * to be considered as bonding candidates */
> >=20
> >  #define BONDING_TQ_THRESHOLD	50
> > +#define BONDING_NONE		0
> > +#define BONDING_ROUNDROBIN 	1
>=20
> You've wrote something like "space""tab""1" here. Can you please remove t=
he=20
> space before the tab.
>=20
> Have you already painted some nice graphics or wrote some text to explain=
 the=20
> modes further (yes, code is the best documentation, but a bad specificati=
on)?
>=20
> The rest looks like it should be tested in italy :)
>=20
> Best regards,
> 	Sven



--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwJK7AACgkQrzg/fFk7axY5hwCg14gGe8GrtbcxmMp2c63mXO9b
OLUAoNsaVtXEEOsP3SMbAoZFtJBqGnsK
=Cqua
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
