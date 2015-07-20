Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Jul 2015 13:50:17 +0800
Message-ID: <1787190.Gq8ZxEKgiS@voltaire>
In-Reply-To: <20150719132823.GA7888@odroid>
References: <1437120223-11556-1-git-send-email-sven@narfation.org>
 <1437120223-11556-2-git-send-email-sven@narfation.org>
 <20150719132823.GA7888@odroid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4220600.knhq4zEveo";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Avoid crashing kernel
	with multicast asserts
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


--nextPart4220600.knhq4zEveo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, July 19, 2015 15:28:23 Linus L=FCssing wrote:
> Sounds good, that'll probably spare us some discussions about
> BUG_ON()s on netdev :).
>=20
> Acked-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied in revision 7ad001a.

Thanks,
Marek

--nextPart4220600.knhq4zEveo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVrIwdAAoJEFNVTo/uthzAxckIAKmKBCJ3C2D15G6grJuVq5NW
OlxX+96lvtxXOL8DUKi9pgorDL+UWNq94gjWcnqoIwmRar93lOptPiqOezS+pEuJ
LX20kD26nOcw1Sy1dD8N+TJKklkKM39kSnBImEgGZF24OfklBOLp03D3XQLuqZZW
zBbkBLXTSVWjVbxmT3m5bLPLnCo9c3O0/bwsN4gIrUcXlp3oKPXsQeO+zYfrD+U8
Qi+TMWNvZX68XQQYRxUhg37X+ezHPDdM3vUbLoBhJN6tbQYunCJO9qCVWxjMos1J
/lq5PNiGAN+9GLPGHx1KsvJQCoddkcE4itYDjUEEAFcjtfXGUAeJyhSMwko8SzY=
=Ibh6
-----END PGP SIGNATURE-----

--nextPart4220600.knhq4zEveo--

