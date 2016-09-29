Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:05:29 +0200
Message-ID: <3001776.TrYjlrxxJQ@sven-edge>
In-Reply-To: <20160920121245.593-3-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7574504.Tvyr2yHEE3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Introduce packet type
	independent TVLV handler API
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

--nextPart7574504.Tvyr2yHEE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:44 CEST Linus L=FCssing wrote:
[...]
> +/**
> + * batadv_tvlv_ogm_unpack_ctx - unpack context received with a TVLV hand=
ler call
> + * @orig_node: An orig_node to pack
> + *
> + * This unpacks the context received within an OGM TVLV handler, here the
> + * orig_node the packet came from.
> + *
> + * Return: The orig_node the packet came from.
> + */
> +struct batadv_orig_node *batadv_tvlv_ogm_unpack_ctx(void *ctx)
> +{
> +	return (struct batadv_orig_node *)ctx;
> +}

The function doesn't have a parameter orig_node but it is documented in the
kernel-doc block. Instead the ctx should be documented.

[...]
>  /**
> + * batadv_tvlv_handler_unregister2 - unregister a tvlv handler
> + * @bat_priv: the bat priv with all the soft interface information
> + * @tvlv_type: packet type to unregistered for
> + * @tvlv_type: tvlv handler type to be unregistered

tvlv_type is documented twice - and differently.


Kind regards,
	Sven


--nextPart7574504.Tvyr2yHEE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TvJAAoJEF2HCgfBJntGVGsP/iIQGF5FVp9nr/+hgM5mxnHO
Z4JMYHfpk5wfjAqSVf06J42oH69wJg/XEy2aEW+ubniU1/Qk/18n+YLelP+xKj2T
eib7FPUDO9MkKu++dnfhQgXcL3wowYgWBgSxaVTiPRN/9tpIsWKWk9Kf0yriuiyN
FbLGmYDjShaXQK3aFY9xw5ycBFBLFBtYh8DqYGb/4CdXN1vilNtWE8rITD2THpRc
9P8BjxTrrNsyLQOWjNxiO4skIGMLHoZdPYQ20/FlInagr5OL4Ham6hDTyyjAmdnk
ARUmum5DVz1qol+ZsFUl0EPzxEQIe4kQwaxpxycIU+FeiHL9NQOJ4PdbK8uBWvsF
R5rgAOlXJVy0W5Aiu1W00iNPRli7/EAGZIs2qNdJQTtQKAjeYgUhLZ6WvidVV2xl
UgRHszc4Ke6JXho/U+H7dzzbSPhRQLbcZMy2WL8qNEMiS4dFS9+F+ubQfEqGPNdY
LT/gCRiFdRU9OUjf2vsS/dAh2DYg+3dkaeAVoBN/OiUUZjap6u10zGdIwwF8bhCK
nRSZ0hJV8fryFMusj9tdHjmgRiH/OjyWRUbP7JpGLqD3mNzNMWotlGxr3YAPN5Yw
hOVD/Q9BcWEXjfOfUkaQ8d2dnzr1xUkUhBbL1sNb1c/RQE2p6x9S2Q8Sszz6A/kU
qVqdaYpk7BE6brJnBy5j
=WuDd
-----END PGP SIGNATURE-----

--nextPart7574504.Tvyr2yHEE3--

