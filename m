Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Aug 2014 13:00:37 +0800
Message-ID: <2458326.X8uHuyWsd1@diderot>
In-Reply-To: <1405506190-9733-1-git-send-email-sw@simonwunderlich.de>
References: <1405506190-9733-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3648526.BlnnZivu0i";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete variable
	primary_iface from orig_node
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


--nextPart3648526.BlnnZivu0i
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 16 July 2014 12:23:10 Simon Wunderlich wrote:
> This variable became obsolete when changing to the new bonding mechan=
ism
> based on the multi interface optimization. Since its not used anywher=
e,
> remove it.
>=20
> Reported-by: Linus L=FCssing <linus.luessing@web.de>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  types.h | 2 --
>  1 file changed, 2 deletions(-)

Applied in revision be0f6de.

Thanks,
Marek

--nextPart3648526.BlnnZivu0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJT6E31AAoJEFNVTo/uthzANiIH+gNhT+gOeDuyB7lANdRGdy72
3jMX8r5hmWdtX8XpU6JWEOFPa1E70hUrylB9ScRoN4LxdpenQyeMTMnq9zJh4OhS
2pSEgt6l3Foex746pBHszp9r7ivNqriAcqi+v/m0KKmFbU5Kwqaw1ievzX22LANF
i86JptfgdH/qZrq/8e4M3GuDkfdb41NnH1HJIc8A236m3NsR1oDDVmxPlpMivnph
ceR+7tTLMAGZnpNozaw4E3tRkprqZSc5oyIN+tyoHbmd1nOFh0unMlIy8fhW+5c4
A0iP0asFNSDv+2Qq04jZ0jyoFlhIZRoJtCt1B2g3O2beOEVfBZfPNVZswcJ1P4A=
=zDDW
-----END PGP SIGNATURE-----

--nextPart3648526.BlnnZivu0i--

