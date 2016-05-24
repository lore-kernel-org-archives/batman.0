Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 May 2016 14:49:31 +0200
Message-ID: <1876515.iCZETFfYbK@prime>
In-Reply-To: <20160524100018.GB21783@prodigo.lan>
References: <1464042677-7787-1-git-send-email-linus.luessing@c0d3.blue>
 <20160524100018.GB21783@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4046334.O33gTVquOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: Remove unused
	primary_if variable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart4046334.O33gTVquOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

On Tuesday 24 May 2016 18:00:18 Antonio Quartulli wrote:
> On Tue, May 24, 2016 at 12:31:17AM +0200, Linus L=FCssing wrote:
> > Fixes: 29b9256e6631 ("batman-adv: consider outgoing interface in OG=
M
> > sending") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>=

> > ---
> >=20
> > Note sure whether the "forw_packet->if_incoming !=3D primary_if" ch=
eck
> > vanished on purpose or by accident in the mentioned commit. Or whet=
her it
> > got substituted by some other check. Therefore sending the patch as=
 RFC.
> I think Simon can better comment on this, but my understanding is tha=
t such
> check has been moved to batadv_iv_ogm_schedule(), thus primary_if is =
useless
> in this function.
>=20
> Simon, comments ?

Yes, the check has been moved. I would agree that the check is redundan=
t now.=20
Please resend without RFC and add my Acked-by :)

Cheers,
     Simon
--nextPart4046334.O33gTVquOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXRE3bAAoJEKEr45hCkp6hvKcQAKbNSuMVMnRoRVrGIKZ2LPiM
HbPBRP5HhrtDC29JAkdc9J9jbl0F1sd00BUaS8NUHhNTIvUjXp9iqccmZVrJaR9j
Lm6vip3sDU+gQB//UX5dNtb56kWbp/YF8IQ4RTnyIOeg206iuI3QlWxMjFzkKU0P
53/Mu1GhjwMWTwWk7TrPB33EXTCeBgDP/GO8eSgOzfetQky1b3DEfP0/ffs14WsJ
2OT5ow0lKChHHCorXo/RuNKAizOGg4N+sZtGqswLrCznRJJN4H0eztgRCaxB4Eu5
JPU1D2FoKlIHQlnJjxPrpY70Fr8fOV19xZzOR1OC5lBCqY0OnnX561H5ISZZAAyV
sSXL/xDZmMCvs29iIqzfUWiLJjoIdfWkHbtnerxm24Hs/eVyuVhMh+g2+hKednWH
9RRgx0zsvjb+lrrmSYVUuns1zMwwi9250AhFXoVs7XIB6Tz6Thb0c5DBUkT7zGSi
kDmGFgAkiZej5UkswaxOL3hz2YGJetyTy8qKbG94URLgPehuxPnOlm/Q9Kb7HKhy
dHRwht75bn9a6AAWd6CU4HCSdRDWimVQWP+ef5+S9kboT15Fd6lFR43S44wug7y+
uFlxJHq9c7EUjFtDh8w1npHe+bFsWmEDJE5+mE3PCYvn28hvQd3hhpVAwcMbIB4I
/EWC/A+Ak+6OTHDruz/v
=1D69
-----END PGP SIGNATURE-----

--nextPart4046334.O33gTVquOG--

