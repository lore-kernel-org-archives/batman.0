Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 21:03:05 +0100
Message-ID: <9817609.KyospJ5FZq@sven-edge>
In-Reply-To: <20161006064142.20003-4-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1941646.LCFYlQl5yN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
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

--nextPart1941646.LCFYlQl5yN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:40 CET Linus L=FCssing wrote:
> +       void *ctx =3D batadv_tvlv_ogm_pack_ctx(orig_node);
> +       const struct ethhdr *ethhdr =3D eth_hdr(skb);
> +       unsigned int tvlv_offset =3D sizeof(*ogm2);

Haven't checked the complete code yet but isn't an increase of the
reference counter for orig_node missing here? Things like
batadv_gw_tvlv_ogm_handler would then have to take care of dropping
the reference.

Kind regards,
	Sven
--nextPart1941646.LCFYlQl5yN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRpXkACgkQXYcKB8Em
e0Y0sxAAqHcM8plHvnJKcBinKkWJgaZQtiTV4SEp5Uexg0vKjjTmEO3EnYgzIzU5
nnauz5UMGcyG7gc4vbZiBq1MuSKXotAidwSpogVpDxfg29hnFPEJsNgXqH8SsgYk
3ao9iJOURcEAscNaguk+pOhOgbS92dVYKo8HHxuoYrD/BgYRdoPTbXcUWQwuPSaa
Prv43XqOuyp1c2q8ZmyJYCOFdDbZeNAiEZ4DsgDWToaKPqSDU9sMNOAM3yuHaWjl
dheVXdASfmG6cr7QWp7NL145/W8vcrMKCVSecqv8v9/6v3UDaOxvhsMh0kYICGMN
Ml/kZsH7id5TZgFt3gfEuXDDbRwWmsYkiYcUOmzoO19Jom0kLyPBPxlRUYDzh7NY
nvyJQW9lawqLfmjXd+EjQs6Ppoza8maueD9yztyQNq6QqrQgyBgKt11ugH1GnvgP
i2adCCLXjYet1byp5sRmVUeK/2XFP8ZLraEt+BsJLgiI7l9K/YwHCX5ABlmdhmp6
JIQJZA+vw6GChw1sSYcCMtrIl/CbgPX9updVdFTX4JMSIvIomnxjfjTqlWaIeHKk
RfLPiKyfbowh2bHoy7wlGt/9HuxZHkDE7XpX7iK8GBIWyohpL6/q0fsrlkcy3G2i
KxdsgTnHcPAHzFKDxhDXl6Q2zAYAkY3qIAURTJVkTlPYkSljibs=
=k8RD
-----END PGP SIGNATURE-----

--nextPart1941646.LCFYlQl5yN--

