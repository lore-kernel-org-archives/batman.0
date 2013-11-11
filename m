Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Nov 2013 16:04:17 +0800
Message-ID: <2967765.EH6Nq9tJVD@diderot>
In-Reply-To: <20131111070502.GA3713@neomailbox.net>
References: <1384123721-23691-1-git-send-email-linus.luessing@web.de>
 <20131111070502.GA3713@neomailbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1553839.eW7Cdk7Q2F";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: introduce capability
	initialization bitfield
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1553839.eW7Cdk7Q2F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 11 November 2013 08:05:02 Antonio Quartulli wrote:
> On Sun, Nov 10, 2013 at 11:48:41PM +0100, Linus L=FCssing wrote:
> > The new bitfield allows us to keep track whether capability subsets=
 of
> > an originator have gone through their initialization phase yet.
> >=20
> > The translation table is the only user right now, but a new one wil=
l be
> > added soon.
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
>=20
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 47d2674.

Thanks,
Marek

--nextPart1553839.eW7Cdk7Q2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSgI+FAAoJEFNVTo/uthzAFcYH/AuI00bIsKDNPpp2wEC1TyE9
FJNabHWZd9xH1g82rtH19HAX9B/uK9XrDyvfnWQ8KmlG3lNQidjHPyZjfVbVwZ2z
BoBCIkW6/qBWQ2Dw6Zm68QSPr8bnyn9tuyR5r/nk/BLR/sz2HhmkKZmFUd814le0
EodfFutkl+YY7LkLIWiSgrrVaRHbCQ+9N4nEpYY+w79fY0CMjhLPNAXw1DWZP+wT
STlxvJEMT55S5M5OMm1uL5AfJ69I3JESK/RDuKra1bi9ZWwwwvv4LXxe9cqLLrZs
lY8kKTCywAf39On6mDZ5uOPKSw8+7sU58TrAkPYe+hgq4Fr+XKrxQVgMHCm0PUA=
=/R/j
-----END PGP SIGNATURE-----

--nextPart1553839.eW7Cdk7Q2F--

