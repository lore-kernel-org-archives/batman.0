Return-Path: <mschiffer@universe-factory.net>
Message-ID: <528D81CA.8000106@universe-factory.net>
Date: Thu, 21 Nov 2013 04:45:14 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F3kC9vrmg2rQO0Ax5wuq1FPhwW3mRn4oK"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F3kC9vrmg2rQO0Ax5wuq1FPhwW3mRn4oK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/19/2013 08:26 AM, Antonio Quartulli wrote:
> kstrtou32() does not exist before 2.6.39. Convert it to
> strict_strtoul() in that case.
>=20
> Used-by: e29249b4483b91d7a590a16e9b5ffe9412ce7fde
> ("batman-adv: add isolation_mark sysfs attribute")
>=20
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/compat.h b/compat.h
> index 01984b8..334dc5c 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -152,6 +152,8 @@ static inline int batadv_param_set_copystring(const=
 char *val,
> =20
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
> =20
> +/* cast last argument of strict_strtoul() because we have a uint32_t *=
/
> +#define kstrtou32(cp, base, v) strict_strtoul(cp, base, (unsigned long=
 *)v)
>  #define kstrtoul strict_strtoul
>  #define kstrtol  strict_strtol
> =20
>=20

You are casting a u32 * to unsigned long *? Won't this break horribly
when sizeof(u32) !=3D sizeof(unsigned long)?


--F3kC9vrmg2rQO0Ax5wuq1FPhwW3mRn4oK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKNgcsACgkQq3qIxbiQM9gdEQCgudVL0oKZ+hYj3LqxnSuc/g2u
zm0An2iqSbwKR1t+hYl8Md0WQtiUAayk
=8lRH
-----END PGP SIGNATURE-----

--F3kC9vrmg2rQO0Ax5wuq1FPhwW3mRn4oK--
