Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 31 May 2017 15:39:23 +0200
Message-ID: <13855542.45yYzsjnKj@prime>
In-Reply-To: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1660287.3sEkRTxnmT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] MAC addresses of loop detect frames in global
 translation-table
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

--nextPart1660287.3sEkRTxnmT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Andreas,

yes, those are loop detection packets. Preventing these entries from the lo=
cal=20
translation table has been implemented only recently. We can potentially do=
=20
the same for global addresses as well, it just hasn't been done so far ... =
at=20
least I don't see a reason prevening us from that. It is probably added by=
=20
"speedy join" in the first place.

Thanks,
      Simon

On Wednesday, May 31, 2017 3:18:39 PM CEST Andreas Pape wrote:
> Hello,
>=20
> I stumbled across some weired MAC addresses starting with ba:be in the
> global translation-table when running batman-adv-2017.0.1. I run my setup
> with bla enabled.
>=20
> Most of the entries in the global tt of my devices consist of these mac
> addresses. Looking through the code they come from frames which seem to be
> used for loop detection. Adding such MAC addresses to the local tt is
> prevented with the help of the batadv_bla_is_loopdetect_mac function. I
> wonder why adding these macs to the global tt is not prevented in a
> simliar way. Would it be possible to add a corresponding check to
> batadv_tt_global_add to prevent these macs from being added to the global
> tt? Or is there a specific reason why these mac addresses must occur in
> the global tt and which I have not understood so far?
>=20
> Best regards,
> Andreas
>=20
>=20
>=20
> ..................................................................
> PHOENIX CONTACT ELECTRONICS GmbH
>=20
> Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmo=
nt
> USt-Id-Nr.: DE811742156
> Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> Gesch=E4ftsf=FChrer / Executive Board: Ulrich Leidecker, Christoph Leifer
> __________________________________________________________________
> Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte
> Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail
> irrt=FCmlich erhalten haben, informieren Sie bitte sofort den Absender und
> vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige
> Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
> -------------------------------------------------------------------------=
=2D-
> ------------------------- This e-mail may contain confidential and/or
> privileged information. If you are not the intended recipient (or have
> received this e-mail in error) please notify the sender immediately and
> destroy this e-mail. Any unauthorized copying, disclosure, distribution or
> other use of the material or parts thereof is strictly forbidden.
> ___________________________________________________________________


--nextPart1660287.3sEkRTxnmT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkux4sACgkQoSvjmEKS
nqHrxxAAqrAgc55+3ehwFg7dZNAe8a6YKG5avVd+iBGr9flvCf7uY/zWwburlC2R
Ezjpt66JWDg2TxwIo0MJd5tNfnUN9msIYh4FeboJadoNfW7SA7/qgz1EqeseUXBG
ROSHs5BGXQwH9XwnUHH2M43FpUXheAGPwpZ++usrteth49kPK5mcCYvxcCYdjf/4
8gYzbr0H0tEY5VxoYqEJil4WDRouqOdhSuG9RhQfSLdUpedf9E2eVhYx1TtW6J4H
X+vI+LbQpiuUyrGBi4s2Fsgr6p1KlaPuHZRTaGQ32qrtKROER+THv7nDyTXVjeBD
y0pmq5pZZmB12kIOQZwqCKR3YtUwMJOjMq5ehH17eL6Dgvqqh4+wenRNTBSFTOEl
JP+j0+Yw7SpV0JZlnVwifO1v4kLz9PGco5ejgErRpkRByvhgq9SWbHN52yVt5opC
gbeZ5pzNPpeJAO01MLHBptrSEaxEDrywmwl8RXY/tNJUIZyuTXYuW/2s6CjmPK3v
55u0VQLBmWTAl+Js+Rzi45Q0XozxhT/FiyKbaoCMVrFMPEZ0ZfwiNDnLk4NLZG+d
/IhC+ryjKQAoyT22tIJyDYVdKzqfLwP6DrxKbzNisS4H0EzcBVV5CYrPKzizT34+
mQ1tOodkEVVXPWMkNtonVy6S3c46OqtaQLMe6KxtAQrSsdaiH48=
=n0Hz
-----END PGP SIGNATURE-----

--nextPart1660287.3sEkRTxnmT--

