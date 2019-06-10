Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v4 1/2] batman-adv: mcast: detect,
 distribute and maintain multicast router presence
Date: Mon, 10 Jun 2019 09:24:26 +0200
Message-ID: <1984348.Q8u5oXqQmF@sven-edge>
In-Reply-To: <20190610004535.13725-2-linus.luessing@c0d3.blue>
References: <20190610004535.13725-1-linus.luessing@c0d3.blue>
 <20190610004535.13725-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart74294872.IPmbU8ciul";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart74294872.IPmbU8ciul
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 10 June 2019 02:45:34 CEST Linus L=FCssing wrote:
> @@ -107,12 +107,20 @@ enum batadv_icmp_packettype {
>   * @BATADV_MCAST_WANT_ALL_UNSNOOPABLES: we want all packets destined for
>   *  224.0.0.0/24 or ff02::1
>   * @BATADV_MCAST_WANT_ALL_IPV4: we want all IPv4 multicast packets
> + *  (both link-local and routeable ones)
>   * @BATADV_MCAST_WANT_ALL_IPV6: we want all IPv6 multicast packets
> + *  (both link-local and routable ones)
> + * @BATADV_MCAST_WANT_NO_RTR4: we have no IPv4 multicast router and ther=
efore
> + * only need routeable IPv4 multicast packets we signed up for explicitly
> + * @BATADV_MCAST_WANT_NO_RTR6: we have no IPv6 multicast router and ther=
efore
> + * only need routeable IPv6 multicast packets we signed up for explicitly
>   */
>  enum batadv_mcast_flags {
>         BATADV_MCAST_WANT_ALL_UNSNOOPABLES      =3D 1UL << 0,
>         BATADV_MCAST_WANT_ALL_IPV4              =3D 1UL << 1,
>         BATADV_MCAST_WANT_ALL_IPV6              =3D 1UL << 2,
> +       BATADV_MCAST_WANT_NO_RTR4               =3D 1UL << 3,
> +       BATADV_MCAST_WANT_NO_RTR6               =3D 1UL << 4,
>  };

I wonder what a good interpretation of 0x1f would be (all bits set). The co=
de=20
doesn't seem to be able to handle this but an interpretation would be:

* get all unsnoopable
* get all link-local but not rtr

Would this make any sense? Or is there a different/better interpretation?

Kind regards,
	Sven

--nextPart74294872.IPmbU8ciul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlz+BaoACgkQXYcKB8Em
e0ZZpA/+N92S3gkqDi3568cbj7V4l3ucjrJuo0kv5/vMR0YA/1s7XMwCe7uDVDko
yvj0CQ18MspHgFMdULCpI8r7J0QbAQJyA3gSh49T6xnj50P0O/O5kBb/dNE/YWSr
l0fmZZJEAoauHZbrN3e8jYDd5o+O7vlPBDSXmFUAc+YBMr9Ytba/Qq8OXE0L33Af
ZHrnae5/zB0LGZur+69+LXfI/UqQG+h9mj0BhsB6gaHvH/nnKBu14jXR8NjPNxr1
u+IMYXUBCss23mJPlgLMb+zMRjwpY3HgmKuwnm2uMiFlZqCa6IdwUv9o9ETHCSJP
fbuU5ffos9o8jkyBKaOv8atT74komiKbVMMuhDfGk6IJrgssjl4dJlVv0wWh2Iva
Mmpvrs0vyjzIqwRtmEDlCTK9jv6TuVPK0UXIIBYHuXFS2GwZ61HjFoNiU3lzqUkd
LdekvSkggmhko6wtEZfQKQJx6cIE0CuE53QXlRf1KbNWjtnZAK3r2hX7JgXR3N8N
1CrDjAFFZsUAU0PyOq77iDg1V8ilgPo46bIOfbKNq/3K3ne1c3DOIF6X2+HU0DpL
gi1Y54mPUQ6lkxJj27R0w3oGCZqWQnF8zjjgz0nPRuo0fOqNfHA0OZ2b4CULSiq3
fDR0RTd8lFfVu7EkIWskvSjMocIOpOg7B1ySvN77jIE5VvjkkKs=
=ChB0
-----END PGP SIGNATURE-----

--nextPart74294872.IPmbU8ciul--



