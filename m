Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 21:57:13 +0100
Message-ID: <22125564.dpOglzWBpa@sven-edge>
In-Reply-To: <20161006064142.20003-3-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1598062.xEk4Jpn8b3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/4] batman-adv: Store and transmit
	own neighborhood hash
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

--nextPart1598062.xEk4Jpn8b3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:39 CET Linus L=FCssing wrote:
> +       nhh_data =3D (struct batadv_tvlv_nhh_data *)elp_buff;
> +       nhh_data->min_throughput =3D htonl(0);
> +       memset(nhh_data, 0, size);

Why do you set min_throughput and then use memset to overwrite it again?

Kind regards,
	Sven
--nextPart1598062.xEk4Jpn8b3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRsikACgkQXYcKB8Em
e0ZqhBAArUhgVVUPQXYdnKN2llyTxLyOqfMQu1XLtLKUXjnWvecwaIldPtND4faC
tlsDGL2YCNKRu+P2oj1quKZ8KUH9Bt5zGoUBKCgdHNAdcBg+d+x5PGpDsoXXRvwz
+fTXsmu6i3fg4qsAkWKoiX+dklV3rbcAjUg1dENBOnf3p+OBfMorohTlTbB8IsHS
F4ziIFnM2d2sv+YMSbrnS0x5i6o6zwGn84ge5K7QGslUqJu+xZXAuCmOWnwdAjf4
YicD9nCIzxx8wrGLnAABSm/mfhTXSFMoJY+pDkmlBU1SCEhS9D0IxIQrlryv4IcV
cCvI3vCeAFpIt7+v+NNPmL6sRqldu0EaR4DqD/DAtssSXYOqEu+xOPoyAjCvF4tA
uxG495RVaVdE+gUz3BBZD5JPhc9VCKeuR5vPIV7ojaGISaTvI7Yx+doQLWWZ6bMi
h2f59t/BFnbrXy106Aq1h5M7KDbUv6CWQoee6bVSAh3eE/tZON395RbKJg2tWYYu
b2kuGsnLZH+olaYHH86qZsGdu+Ffic06N+VMOKxrmuiYxmG2SoggQ7aan1e49tHY
pg4pTajCP5ekv3g+j/FM+rjjHQztEmPJh95gPl+5O5zrw425k3LhTrTrXh9isBOB
lQnme8WpCXvzCX5WywxSAs2kWoHvdBFo/LN1MyjulT4pZjC3XoU=
=qEZi
-----END PGP SIGNATURE-----

--nextPart1598062.xEk4Jpn8b3--

