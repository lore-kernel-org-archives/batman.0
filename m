Return-Path: <mschiffer@universe-factory.net>
References: <3010820.LJPqpTImjv@sven-edge>
 <1467621378-13452-1-git-send-email-sven@narfation.org>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <8217f7e5-f599-7e12-e4ba-4cfd05994ade@universe-factory.net>
Date: Mon, 4 Jul 2016 11:46:10 +0200
MIME-Version: 1.0
In-Reply-To: <1467621378-13452-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RQuFwdchkLxddtoVsJ2RK5IxwdVMqiCds"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Switch netlink uapi header
	copyright to ISC
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RQuFwdchkLxddtoVsJ2RK5IxwdVMqiCds
Content-Type: multipart/mixed; boundary="B7sEUoSCqiLfNbLdRII2HnixuBJPRpQk6"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <8217f7e5-f599-7e12-e4ba-4cfd05994ade@universe-factory.net>
Subject: Re: [RFC] batman-adv: Switch netlink uapi header copyright to ISC
References: <3010820.LJPqpTImjv@sven-edge>
 <1467621378-13452-1-git-send-email-sven@narfation.org>
In-Reply-To: <1467621378-13452-1-git-send-email-sven@narfation.org>

--B7sEUoSCqiLfNbLdRII2HnixuBJPRpQk6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/04/2016 10:36 AM, Sven Eckelmann wrote:
> The batman_adv.h netlink header is used by userspace programs to use th=
e
> genl interface of batman-adv. These programs may not use the GPL-2 lice=
nse.
> The header should therefore state clearly that it can be used freely an=
d
> the license of the program which uses this header is not affected.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: Matthias Schiffer <mschiffer@universe-factory.net>
Acked-by: Matthias Schiffer <mschiffer@universe-factory.net>

> ---
>  include/uapi/linux/batman_adv.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batma=
n_adv.h
> index acb72f8..0fbf6fd 100644
> --- a/include/uapi/linux/batman_adv.h
> +++ b/include/uapi/linux/batman_adv.h
> @@ -2,17 +2,17 @@
>   *
>   * Matthias Schiffer
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> + * Permission to use, copy, modify, and/or distribute this software fo=
r any
> + * purpose with or without fee is hereby granted, provided that the ab=
ove
> + * copyright notice and this permission notice appear in all copies.
>   *
> - * This program is distributed in the hope that it will be useful, but=

> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
> + * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRA=
NTIES
> + * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE=
 FOR
> + * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMA=
GES
> + * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN =
AN
> + * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OU=
T OF
> + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>   */
> =20
>  #ifndef _UAPI_LINUX_BATMAN_ADV_H_
>=20



--B7sEUoSCqiLfNbLdRII2HnixuBJPRpQk6--

--RQuFwdchkLxddtoVsJ2RK5IxwdVMqiCds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXejBiAAoJEBbvP2TLIB2c/DgP/2gb2/w3cMCH9F5ym9k1REFp
J+m5JHY6hWoiU9v4qhiwZmOcwgXuIO88Kkc6cdnD06uFhzXxAc39Q8vqC3ZPDJ+w
/JCt4Ds1qoA2ADCRLoZj7C2MXOULW9sPmY0/trBRYJl6yPTGLK7V+zNOfmzOIV/7
QvII1fI+HlXWIRxOkPwgDBItirJ5Xfe+j1q2cEMCnCc+0Vb26FfLzCargxAfaOr+
qyxUHAxTHFAazZ36C8mm1Xn7bWb5qUZRRwxd/o3e5Er7SLj8h0/JP9ZAD5NI2498
ujKU3ZYw18D0JbOU2Dxttwz1iz4bR+4lv35Qfw89XqXYkv5ADFqLwDkXsiNJ6v4O
4Bt6ngj2zsP1dms+E1KBDjh8B0bZBdf18l1ti+vAlLcwSJDb4zvIOFOLVyHhRi0E
BkQLrlWRkmGTFxqKWjK5M6VC/zhQTGp+b7ygXG+vlKl8cRNLfIqPbNi//jSCrE9d
N0d1TVx8KQJ29+mOrpw5ruzyGDgqOiL46BOX2APz2rBQB5PX3EkoZGrgN28MO7PV
UYQI3DQuhEsr8IYewPqXM5R3mmfGFae6dp3HhUqXDtB6TwOQZlwwO27pqFdt4N7x
dhdgLM0lEcK54d4nHXcQz/Xbd4ATbLGEV39OFUbTN/Bh9ZKL3oFtsyRUaon0qPwa
qOqmmFl7jGjZyDUrcQin
=X+n+
-----END PGP SIGNATURE-----

--RQuFwdchkLxddtoVsJ2RK5IxwdVMqiCds--
