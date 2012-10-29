Return-Path: <ordex@autistici.org>
Date: Mon, 29 Oct 2012 09:13:40 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121029081340.GA5944@ritirata.org>
References: <1351423037-5292-1-git-send-email-ordex@autistici.org>
 <1351423037-5292-4-git-send-email-ordex@autistici.org>
 <20121028.185927.374901219739099234.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20121028.185927.374901219739099234.davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: separate
 BATADV_ATTR_HIF_UINT sysfs name from hard-iface variable
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Sun, Oct 28, 2012 at 06:59:27PM -0400, David Miller wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> Date: Sun, 28 Oct 2012 12:17:04 +0100
>=20
> > From: Marek Lindner <lindner_marek@yahoo.de>
> >=20
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> >  net/batman-adv/sysfs.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> I was wondering how you could possibly change the list of arguments to
> these macros, yet avoid changing any of the users.
>=20
> And sure enough it's because these macros are completely unused.

when this macro was introduced a user was going to be added as well, but th=
en we
delayed some work and the user was not introduced anymore..

>=20
> Please just remove them instead of changing their interfaces when no
> users exist.

Yes, I will resend the pull request with a patch that removes this macro at=
 all.
We will re-introduce it as soon as the user is ready too.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCOOrQACgkQpGgxIkP9cwfnUwCeJox1sRMZlt9FwShaPHzfFxgB
uoMAmwcaNEQCA3PafurKoMBY/JtpbPdl
=J6D5
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
