Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 26 Aug 2016 17:13:49 +0800
Message-ID: <1793249.mGSfB4ccnr@voltaire>
In-Reply-To: <5621960.PaUi3NJltb@bentobox>
References: <20160823011303.18487-1-linus.luessing@c0d3.blue>
 <5621960.PaUi3NJltb@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12177887.LRcyMJy0Zu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix elp packet data
	reservation
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

--nextPart12177887.LRcyMJy0Zu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, August 23, 2016 8:32:26 AM HKT Sven Eckelmann wrote:
> On Dienstag, 23. August 2016 03:13:03 CEST Linus L=FCssing wrote:
> > The skb_reserve() call only reserved headroom for the mac header, but
> > not the elp packet header itself.
> >=20
> > Fixing this by using skb_put()'ing towards the skb tail instead of
> > skb_push()'ing towards the skb head.
> >=20
> > Fixes: a4b88af77e28 ("batman-adv: ELP - adding basic infrastructure")
> > Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> > ---
>=20
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 0b75ad1.

Thanks,
Marek

--nextPart12177887.LRcyMJy0Zu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJXwAhNAAoJEFNVTo/uthzAK8IH/Rri7FISuou1Od/TWIzjOFzR
iWHxmuK265L31ImGJ2Rta1DbfgaDbDy3icLIfBGH4DPgz7w5x2Eh0NZV2Dc4ux3R
iRHtdGO4xRk1640n/wBnPIAtzE5KsGZII+Fxzqda3oOeDCs0sRpbn3DhI3fzF2ht
CtXQmWA/zCVWfrzsD4f38DqnSV6o7xOs9IMbZ9+fqs+uWJjkf4Eau07fY8QreAbH
EQIxcgSKK4Dpmgd2Cu7kd4kHdmvLqqaX4MEZU7hjnAw906ivyeZ9G9ysBY8WWt23
AEjdVDeVc9X7hR+n5xjG9kXIbAp7g/26rrfhGN/JNcCsrlIqunxTfxgKOPk1N74=
=ODSA
-----END PGP SIGNATURE-----

--nextPart12177887.LRcyMJy0Zu--

