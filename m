Return-Path: <mschiffer@universe-factory.net>
References: <20180318121201.29052-1-sven@narfation.org>
 <b50d17c8-e55f-6a05-88db-acdcc4c35732@universe-factory.net>
 <6825317.Bh3rAZBzc7@bentobox>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <9d6e6557-b697-0a4c-10da-fa3339dc2ade@universe-factory.net>
Date: Mon, 19 Mar 2018 14:19:58 +0100
MIME-Version: 1.0
In-Reply-To: <6825317.Bh3rAZBzc7@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nC84LmkWjGt6Za9GXaZFjXAr2evAF6HU8"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix skbuff rcsum on packet
 reroute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nC84LmkWjGt6Za9GXaZFjXAr2evAF6HU8
Content-Type: multipart/mixed; boundary="Vru63uOWhsDUZGIn2d5mSa5CSnNX5dxaM";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <9d6e6557-b697-0a4c-10da-fa3339dc2ade@universe-factory.net>
Subject: Re: [PATCH] batman-adv: Fix skbuff rcsum on packet reroute
References: <20180318121201.29052-1-sven@narfation.org>
 <b50d17c8-e55f-6a05-88db-acdcc4c35732@universe-factory.net>
 <6825317.Bh3rAZBzc7@bentobox>
In-Reply-To: <6825317.Bh3rAZBzc7@bentobox>

--Vru63uOWhsDUZGIn2d5mSa5CSnNX5dxaM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/19/2018 02:14 PM, Sven Eckelmann wrote:
> On Montag, 19. M=C3=A4rz 2018 14:02:43 CET Matthias Schiffer wrote:
>> Using skb_postpull_rcsum here is incorrect: As the name indicates, it =
is
>> supposed to be used after pulling, and will thus subtract the checksum=
 of
>> the header *before* skb->data, while we are interested in the
>> sizeof(*unicast_packet) bytes *after* skb->data.
>=20
> Can you please explain this a little bit further. You give skb_postpull=
_rcsum=20
> the start and length via parameter and it is writing the resulting csum=
 in the
> skb. It is not checking or accessing the position of skb->data [1]
>=20
>     /**
>      *	skb_postpull_rcsum - update checksum for received skb after pull=

>      *	@skb: buffer to update
>      *	@start: start of data before pull
>      *	@len: length of data pulled
>      *
>      *	After doing a pull on a received packet, you need to call this t=
o
>      *	update the CHECKSUM_COMPLETE checksum, or set ip_summed to
>      *	CHECKSUM_NONE so that it can be recomputed from scratch.
>      */
>=20
> See also __skb_postpull_rcsum [2]:
>=20
> 		skb->csum =3D csum_block_sub(skb->csum,
> 					   csum_partial(start, len, 0), off);
>=20
> What about the examples I gave in my patch - for example the easy-to-re=
ad=20
> set_eth_addr [3]?
>=20
> Kind regards,
> 	Sven
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/include/linux/skbuff.h?id=3Dc698ca5278934c0ae32297a8725ced2e27585d7f=
#n3070
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/include/linux/skbuff.h?id=3Dc698ca5278934c0ae32297a8725ced2e27585d7f=
#n3058
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/net/openvswitch/actions.c?id=3Dc698ca5278934c0ae32297a8725ced2e27585=
d7f#n319
>=20

Ah, you are right, I got confused. In that case, the patchs looks correct=

to me.

Matthias


--Vru63uOWhsDUZGIn2d5mSa5CSnNX5dxaM--

--nC84LmkWjGt6Za9GXaZFjXAr2evAF6HU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlqvuP4ACgkQFu8/ZMsg
HZyUpA/9Gtsk1ajgmQkfU9y1fLgBP3P+9J/N4SvAy4pq2o8ZtBjADloP5oKiXGQ+
VsJzKOljVDG6XeiLIychibkK0yjVTbc1l12hdpBMCWLRNRprWplM5lVwFma+k8t6
IJXYBnoClx9dCe/D3T1P3ZUfCP3q3lYUyad7EFSzivGgyJ+YK3l/j37DfA5hYhNj
Qh7wY9qgHeXO5KlbwkzxX8vjE+5iD9OBY3YglNNv7ddNaP0ZIwPst8EM44D4CABb
WzkkIofcI85koDGxonJVhPaWYz67C/xlBAZr8Y3/laO6sVCKxy7ot+6bIQDhoGfJ
yAYt2n3ZGZ20Flqj+sE7dkQvYxYzkYxT3EXTaaZyolcOcDlACUXqu48TUk4VUASr
Y333po9126OcFJV3RnMvJT50s+xOpymFRfMOQWux397hBWAWV7Fm4At+LlH4+/zn
eZq0XEoJhSeEahkC2UjA9gSrSE8YZdzOKm6gT6I6pPRa7/ZhZcokqjZ+bCGVSqqA
a1ZZH4V6ys270wvwo6kTqumvySN3liKMMyhSBJzYIL6iriWY+R1DXfWW+v/Ua+zY
xrZyWEZDQd2QS3wdas56Sr4jB2vBllNWwQqMdFV6pQ+5FlFnVJcXBWAgLMp2buZR
xcdabL7hKetHZxrLtxlXWpzCChcQGKwRxI1eQWnte3gM5yx32F8=
=Mngu
-----END PGP SIGNATURE-----

--nC84LmkWjGt6Za9GXaZFjXAr2evAF6HU8--
