Return-Path: <antonio@meshcoding.com>
Message-ID: <52DD3BC9.4070603@meshcoding.com>
Date: Mon, 20 Jan 2014 16:07:53 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390212404-9726-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390212404-9726-1-git-send-email-linus.luessing@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QSGG5GHvvWoB3qWkV2lJBQX4abvKTcIs7"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint] batman-adv: fix potential kernel
 paging error for unicast transmissions
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QSGG5GHvvWoB3qWkV2lJBQX4abvKTcIs7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20/01/14 11:06, Linus L=C3=BCssing wrote:
> batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> data. If it does then our ethhdr pointer is not valid anymore in
> batadv_send_skb_unicast(), resulting in a kernel paging error.
>=20
> Fixing this by refetching the ethhdr pointer after the potential
> reallocation.
>=20
> Introduced by b46c60b9e1ee7a1909c542413a85875a750955d6
> ("batman-adv: improve unicast packet (re)routing")
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

> ---
> Changes v4:
> * "s/Introduced-by:/Introduced by/" to make checkpatch happy
>=20
>  send.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/send.c b/send.c
> index b0a3d76..50df184 100644
> --- a/send.c
> +++ b/send.c
> @@ -281,6 +281,10 @@ static int batadv_send_skb_unicast(struct batadv_p=
riv *bat_priv,
>  		goto out;
>  	}
> =20
> +	/* skb->data might have been reallocated by
> +	 * batadv_send_skb_prepare_unicast*
> +	 */
> +	ethhdr =3D eth_hdr(skb);
>  	unicast_packet =3D (struct batadv_unicast_packet *)skb->data;
> =20
>  	/* inform the destination node that we are still missing a correct ro=
ute
>=20


--=20
Antonio Quartulli


--QSGG5GHvvWoB3qWkV2lJBQX4abvKTcIs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3TvNAAoJEEKTMo6mOh1VTs8QAIoBeeHhJ7G9qkZNOpjp/dNM
5rE0O0x1LFFl7wd1f0FfkAELIE27+saL+Mxk7hSffMINKUWcSSfA63zvkUBTLiOY
GzcxDABrFR6Elar+YnBeJG74FFG5g5bcZvvjYmzLTBCtTLKtZEpXWPoIm95NY2xO
c7tA2ZsnyCtuKZEEp/jWcF5ywoxsHZwTERTGu2vdcjFMlUe2Fsrk4LbZit/GgSBF
igBfbb3zr7kmITgNZD2uB4RzMFMfTF1d+ZX0HCr8Z1Hik7k8dLoWI+n/F/P5qpjO
6OAbhVoJMFOvu83zdUdv994RRim6tQCmYWVAz5gcjpeK7wweyY4sMuwI33Ht80ES
jSwWjujfC2I6JUuerAiara1T7n200INIWwcmr/z2jqEbflHOQAN2xjWJkfodWEHy
fOQCS4OwA5D/h049r8PCc8Cnchpzf8W+wqzjWgxF8bEHcvkNR2JUP1YWGMOO6gdM
NsdOTeA4PsojvjlYW4IQe5XuvWOKsWPtD9BsHW0qNJt6RZwe5pfB1rYDEK9Yhk2g
fTeS0E+mSkl03b6cs2MQ9GIUt3bpqR2k2TydedenJEjRy5jCCFAUgDk1S2w0QdbA
6FMAzvrJTQ5AlJtr2Ap+Y3PBEYkL+1I8oKsMga305ODT1UhPa/KpxKwtc1n6aRIP
C5A8jlFET2TxFQK/YwTv
=he3i
-----END PGP SIGNATURE-----

--QSGG5GHvvWoB3qWkV2lJBQX4abvKTcIs7--
