Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 17 Jul 2011 21:14:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110717191407.GA7377@pandem0nium>
References: <1310899392-1941-1-git-send-email-sven@narfation.org>
	<1310901079-14967-1-git-send-email-sven@narfation.org>
	<2528846.xa574SJbNA@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <2528846.xa574SJbNA@sven-desktop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Start to fiddle with compat
 stuff
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


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sven,

actually I wanted an ugly macro which keeps the kernel version check in
the compat.h only - I tried my luck based on your patch, but i failed=20
miserably... I just can't tame the preprocessor. Sorry. :D

I'm fine with dropping the support for < 2.6.29, it does not hurt me=20
both personally and professionally. I don't know if there is anyone
who uses old kernels and can't patch back themselves.=20

As a compromise, we might upload compat patches on open-mesh.org for
release versions of batman-adv. No maintaining, just "best effort service".
We keep some more unmaintained patches there too [1]. What do you think?

Is there anyone using old kernels?

best regards,
	Simon

[1] http://downloads.open-mesh.org/batman/patches/

On Sun, Jul 17, 2011 at 01:15:03PM +0200, Sven Eckelmann wrote:
> On Sunday 17 July 2011 13:11:19 Sven Eckelmann wrote:
> >  README           |    2 +-
> >  compat.c         |    8 ++++++++
> >  compat.h         |   17 +++++++++++++++++
> >  soft-interface.c |   31 ++++++++++++++++++++++++++++++-
> >  4 files changed, 56 insertions(+), 2 deletions(-)
>=20
> The sendmail killed my comment. So here it is again:
>=20
> This is just a small note... but it is completely unacceptable for the ke=
rnel
> folks. d0tslash wanted to have "another ugly compat.h macro" - so he can
> continue here.
>=20
> Kind regards,
> 	Sven



--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4jNH8ACgkQrzg/fFk7axanvACgopBAFjLkXh7DFSmi/LDNduFY
yaQAoKtFNTG0uePNBOeqkhcLpMW9FZ/M
=ppE9
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
