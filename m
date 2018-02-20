Return-Path: <a@unstable.cc>
References: <20180220110810.10676-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <62d91c19-4a87-2727-f9d5-e3fdfbfb5e39@unstable.cc>
Date: Tue, 20 Feb 2018 19:41:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180220110810.10676-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mn8PleoWek0FhqfSVfYkU7VmkzQoZaT3A"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid relation operator
 comparison with bool
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, David Binderman <dcb314@hotmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mn8PleoWek0FhqfSVfYkU7VmkzQoZaT3A
Content-Type: multipart/mixed; boundary="24QO1IBrfOUi9k1r7sboVKYabfXxoYKP0";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, David Binderman <dcb314@hotmail.com>
Message-ID: <62d91c19-4a87-2727-f9d5-e3fdfbfb5e39@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid relation operator
 comparison with bool
References: <20180220110810.10676-1-sven@narfation.org>
In-Reply-To: <20180220110810.10676-1-sven@narfation.org>

--24QO1IBrfOUi9k1r7sboVKYabfXxoYKP0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 20/02/18 19:08, Sven Eckelmann wrote:
> commit 34b3c3850e7d ("batman-adv: Distributed ARP Table - create DHT he=
lper
> functions") introduced a return check of batadv_compare_eth which uses =
a
> boolean return value since commit 16af73458aca ("batman-adv: main,
> batadv_compare_eth return bool"). A relational (<, >, <=3D or >=3D) ope=
rator
> is not the right one for such a check.
>=20
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: David Binderman <dcb314@hotmail.com>
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: Markus Pargmann <mpa@pengutronix.de>
> ---

Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli


--24QO1IBrfOUi9k1r7sboVKYabfXxoYKP0--

--Mn8PleoWek0FhqfSVfYkU7VmkzQoZaT3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlqMCYUACgkQB6U8WA7y
zXQVEg//YYiewm4KOlpQ0n1sLUPcaW2pj1OUk3iUpH60nRgRwgibcnQTFvZ+ZdTo
0gkYK2gtAsFwbY0mynGaLx43D7y7StL/9HVLmXhLyPEyPhm11J5nw5XyDBoD+jsb
mCa33bK9ac+j3u6R2B0birbAGwloUelzRN3R5E2Lo8aGTTdDePpFiaNdXLvZJFTw
v9pPa1wiib9AyImZ4WMaa5KeUK+GALU0sG5CGPuTGxkWmmynZZo64kbixJItZbPX
LGBkQKVesiCmfZwvPo71cSQPqgC9aWri6xYH793prb3xwCTUpdpHooEjbci0a8G2
mqgOL9LldI0ojhBDO21kRk86i0CEI05dix9ujX2eQLB4Rs5nJRkoqPLb1R2PjL1w
QW00jNIQu75nOZYaiEzpmWna6DD2orGPOtB9pqSncS7AlndNU2YV00FcTr2Zvjjq
SaWkJt9R3glp+JbwszJ7eOEN/lelLzn5q/bcmVl3VykIgg17W7rID0U3BtVYgXtA
dZjnxCDHmp04rooTEhteqhxpGfkHGwrsoHdU9ZKrWIkxas37tEoVfe35mNK4fy+q
YkSz/B4/ckETm4/VEOpZfzOFRLulW8goAU5Te6Bw2nms9ZcDTnmbifnKj5tM3I88
5t8ci7EZPq+3mxGO4aiZeQQBlOi46w2H6sDsnpt5FxHaft4S5s0=
=XGdV
-----END PGP SIGNATURE-----

--Mn8PleoWek0FhqfSVfYkU7VmkzQoZaT3A--
