Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/2] batman-adv: Prepare infrastructure for newlink settings
Date: Sun, 11 Oct 2020 11:48:41 +0200
Message-ID: <5766158.W2Ztyaally@sven-edge>
In-Reply-To: <20201011093909.297580-1-sven@narfation.org>
References: <20201011093909.297580-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart178047619.hTMiTNJcI3"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Annika Wickert <annika.wickert@exaring.de>

 
--nextPart178047619.hTMiTNJcI3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

just noticed a build problem with some older kernels.

On Sunday, 11 October 2020 11:39:08 CEST Sven Eckelmann wrote:
> +#define batadv_softif_validate(__tb, __data, __extack) \
> +       batadv_softif_validate(__tb, __data)
> +
> +#define batadv_softif_newlink(__src_net, __dev, __tb, __data, __extack) \
> +       batadv_softif_newlink(__src_net, __dev, __tb, __data)
> +

Seems like the compat code has to be changed slightly because the __extack was 
not introduced at the same time for all callbacks. These both must not be 
handled in the compat code for 4.13 and newer.

Kind regards,
	Sven
--nextPart178047619.hTMiTNJcI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl+C1PkACgkQXYcKB8Em
e0bSxg/+MaEP8MskCrOfKxldRxl16u2tKvjY+E+1kICzVNDuLd4HvcFZowpBwAj9
MyMkABp1B9PBJyATw0Sskv53mYepwgXQgHLP/7I0YAEyQ4LnQ1YeWU4sjzYGuSKG
ieDgaPbJvYBdCWuNShN4cfHRytXYbBPjlGuz/0vbH9Rvgof3wDrygbBeBl3120v9
UncUfWQb2NsE/unS7Q8deu42+WWwSLE8+2VL+GAXLYvLwWCAypegolqQV6x8GSPn
BH6oA7Ek/YG0SThX5uS+TAJ3AmQUjPV0UQg5NmpRH0fDxc7za6c4aqO11UFGOR73
bBUSivd+0iLFvNIP/HxPJI9y7+p3yhBasJiHcSrFz8oOEMdp7oNxD0vrBju9ADkG
dMOVUyF7RE+lB9PpojABp5f6KKEpfWwbj4XMiQsZe1kX8Ln5/OWi6GjOnnR3MXB1
Jw2wZlmNIrRD8TH8+1twaOjAzSprjkZT3F9hB923XBV2j7UPhMzsdpYoltBpxoXw
jrQSyZ4ZqmPp7VYV4UFIFhjV+/yPDyyLjuEMZmaOSXqPToSqOS5odmMUTcdiyy2N
WB1Jbf840f4OlV7Yw7S8lrwm1SWTWzRxtMsn2Irfst5caikC8p8ArdczYL/tpwY+
F1F8PuizRWBGBMqFfd8KU6ScuFUCUMsL4CMg0Y9N1WtyMZ0GQgg=
=6y5k
-----END PGP SIGNATURE-----

--nextPart178047619.hTMiTNJcI3--


