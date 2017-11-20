Return-Path: <mschiffer@universe-factory.net>
References: <20171119140517.24329-1-sven@narfation.org>
 <20171119140517.24329-9-sven@narfation.org>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <b081019e-e45e-0593-484b-4107f4fb05af@universe-factory.net>
Date: Mon, 20 Nov 2017 09:30:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171119140517.24329-9-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="heMoBXwbTi6auouRJ3d0h0ce7p159jSGq"
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Change batman_adv.h
 license to MIT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--heMoBXwbTi6auouRJ3d0h0ce7p159jSGq
Content-Type: multipart/mixed; boundary="lH7sG3d9qRxm5Aqgreua7ntTw8LVmC7c4";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Andrew Lunn <andrew@lunn.ch>
Message-ID: <b081019e-e45e-0593-484b-4107f4fb05af@universe-factory.net>
Subject: Re: [PATCH 8/9] batman-adv: Change batman_adv.h license to MIT
References: <20171119140517.24329-1-sven@narfation.org>
 <20171119140517.24329-9-sven@narfation.org>
In-Reply-To: <20171119140517.24329-9-sven@narfation.org>

--lH7sG3d9qRxm5Aqgreua7ntTw8LVmC7c4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/19/2017 03:05 PM, Sven Eckelmann wrote:
> The ISC license is considered as not recommended in "Linux kernel licen=
sing
> rules". It should only be used for existing code or for importing code =
from
> a different project with that license.
>=20
> But the kernel still has the similar sounding MIT/Expat license under t=
he
> preferred licenses. Switching to this license for this relatively new f=
ile
> should therefore allow batman-adv to better follow the new licensing ru=
les.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> I would ask for Acked-by from following persons
>=20
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Matthias Schiffer <mschiffer@universe-factory.net>
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: Andrew Lunn <andrew@lunn.ch>
>=20

Acked-by: Matthias Schiffer <mschiffer@universe-factory.net>



> Please check
>=20
> * https://www.gnu.org/licenses/license-list.html
> * https://en.wikipedia.org/w/index.php?title=3DISC_license&oldid=3D7914=
86092
> * https://en.wikipedia.org/w/index.php?title=3DMIT_License&oldid=3D8092=
49689
>=20
> For more information about these licenses.
> ---
>  include/uapi/linux/batman_adv.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batma=
n_adv.h
> index fb453382..ae00c99c 100644
> --- a/include/uapi/linux/batman_adv.h
> +++ b/include/uapi/linux/batman_adv.h
> @@ -1,19 +1,25 @@
> -/* SPDX-License-Identifier: ISC */
> +/* SPDX-License-Identifier: MIT */
>  /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
>   *
>   * Matthias Schiffer
>   *
> - * Permission to use, copy, modify, and/or distribute this software fo=
r any
> - * purpose with or without fee is hereby granted, provided that the ab=
ove
> - * copyright notice and this permission notice appear in all copies.
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
>   *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRA=
NTIES
> - * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE=
 FOR
> - * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMA=
GES
> - * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN =
AN
> - * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OU=
T OF
> - * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER=

> + * DEALINGS IN THE SOFTWARE.
>   */
> =20
>  #ifndef _UAPI_LINUX_BATMAN_ADV_H_
>=20



--lH7sG3d9qRxm5Aqgreua7ntTw8LVmC7c4--

--heMoBXwbTi6auouRJ3d0h0ce7p159jSGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAloSkq0ACgkQFu8/ZMsg
HZw9OxAAqLhUEuzF3TEgT+oSLazlD9ZW1wb0NVycWZSAgwNedE+3WKCUR4GJkong
g74H2EYfLMP/h4BMj8+m7Au/zwYnO5psFYcJGrUKo8VjBZ/i6Qpw4XGNfApAHUUM
KU5lS9j1dmsr9X7eLZCQFTqq2NsRjxtxfXVuVV/Jtf+aAiWyDdYn8DDmXqrDeMBF
v2UO6zvENLi2uie3htvVxJjEkiN/mq3pNcBUfQdm6kTtF9klkPqwZuzu4e4t18dX
aDsd/XbdNu7iH4NZXeLBrHyx8DLdnRRdV3gFwZ81hnTUMg7NCihHZB5nU8Xu76jE
jL0/owwJ+2j1Z3wOB4sQDYkmcRbdB7K77TpnPh3Avzo80sbL2me6Hzdn0rpoboqx
tQ/fR8fOnaA71FRtaLwwAJzHBnw3k+1LuEI6Nfhnvjnwr0dhQN+hjJVChBZk2OQz
29GrWHBrDHhLYAreb0mUqS7bJgbe9WqAuRouACyldjGlUZC3lZ64NfozevUss9yq
zAydiKG/OqhL/X4Odfux3lJrsE0hdo644jGrLyjkfrKNY8zg4tturUQ5gad00Koq
WYjqqunREHgCQLC6LansZHwzmhEY8fvFfWB8PfukRecsGF5rgMjQh9UUYnARaEsC
Msj779ga+8GHUArE/jinRTvf6sT4swjEXSFFBvM8Cal8yW03uDg=
=cPwA
-----END PGP SIGNATURE-----

--heMoBXwbTi6auouRJ3d0h0ce7p159jSGq--
