Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Tue, 25 Jun 2019 16:26:32 +0800
Message-ID: <2561263.F3lYGfnSHf@rousseau>
In-Reply-To: <CALYz8yoj0E1MDoh7ztThK_q_ew0EHa=2vbuwxQFNwUfDvsEGiA@mail.gmail.com>
References: <20190609101922.2366-1-treffer@measite.de>
 <3147211.nMDzSnZuI7@rousseau>
 <CALYz8yoj0E1MDoh7ztThK_q_ew0EHa=2vbuwxQFNwUfDvsEGiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6284923.q8cz3GkGWU";
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

--nextPart6284923.q8cz3GkGWU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 13 June 2019 04:50:44 HKT =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=
 =D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD wrote:
> So here is the algorithm. It has a structure we call matryoshka.
> ET - Expected_throughput.
>=20
> 1) ET =3D TX_bitrate * Transmit_probability * Overhead_coefficient
> Transmit_probability is always less than 1 so Expected throughput
> can't be equal to the TX_bitrate. Overhead_coefficient is also should
> be less than 1
>=20
> 2) Transmit_probability =3D 1 - Retry_probability - Error_probability
>=20
> 3) Retry_probability =3D TX_retries / TX_packets
>=20
> 4) Error_probability =3D TX_errors / TX_packets
>=20
> 5) Overhead_coefficient for 802.11 is fair enough to be 0.65, but can
> be changed after additional testing.
>=20
>=20
> ET =3D TX_bitrate * (1 - (TX_retries + TX_errors) / TX_packets) * 0.65
> Such technique has very large hysteresis which is good to avoid
> flapping between different nodes.
> In my MESH lab this formula works quite well.

This looks like an interesting approach. Which chips / environments did you=
=20
test this formula with and how did the result compare to the actual TCP=20
throughput ?

Thanks,
Marek


--nextPart6284923.q8cz3GkGWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl0R2rgACgkQU1VOj+62
HMCBpAgAmVLStNzASYBVy5GluiHgYWziImCZx0fOWzH7yYcY5j2HwJ3QSyjL87F0
84ADyazp2J7bm4ckrpyN+bdYPqn365e/hmch6+7Do4apgiXBM3nmZ6+2QTpx+wEJ
6GI8yYmceAedYR+OXQ5zv0Vgpi5oQkWMB4SjOyQg6rlPNk9MCdKsgSUtlC7/0rze
J72cKCvGX0Mxd+WwQQ4U8bJtEvnHwH/0Zuqjp18PwdMJ1ZFmwWOiZa0v4YFAkwPs
u3JWFq/hxxaYVweQpUEKmlezXIq+FoGDJ8rro1ZJzRGq7Gzda9YWHsS0QnW5vLwa
MsVd0wYLkkEbZ6nwdCkTRX08yBegOA==
=6k+X
-----END PGP SIGNATURE-----

--nextPart6284923.q8cz3GkGWU--



