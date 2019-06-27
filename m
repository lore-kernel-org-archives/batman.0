Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Thu, 27 Jun 2019 18:57:48 +0800
Message-ID: <7822200.cGPG6thHbD@rousseau>
In-Reply-To: <CALYz8ypn2fQYCxbFDCbUmAgYHcHaxzPgGWkQPAhz2qxy3Qu-RA@mail.gmail.com>
References: <20190609101922.2366-1-treffer@measite.de>
 <2561263.F3lYGfnSHf@rousseau>
 <CALYz8ypn2fQYCxbFDCbUmAgYHcHaxzPgGWkQPAhz2qxy3Qu-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1581939.E3j6QKcEcE";
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
To: =?utf-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= <klukonin@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1581939.E3j6QKcEcE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 27 June 2019 18:41:54 HKT =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=
 =D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD wrote:
> Mostly QCA988x was tested.
> Sorry, I lost my test results so I need to do it again.
> I have UBNT AC MESH, UBNT AP AC Lite and TP-Link RE450 in my lab.

It'd be great to see those numbers.=20


> Also, as I think, it's better to test UDP throughput, But I can test
> both TCP and UDP.
> This formula always show a result that close to UDP throughput. So,
> may be we can think about additional parameters/coefficients that
> depend on protocols or something else.

Why is UDP better ? The thinking behind comparing to TCP throughput is that=
=20
most applications use TCP and not UDP.=20

Cheers,
Marek

--nextPart1581939.E3j6QKcEcE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl0UoSwACgkQU1VOj+62
HMCVDggAuLWjSRi8K/Gx/uDEG4cBnW9ODt7qJqSemaoUvJClb0naT/fVYxGvlxzf
egMH0pzJwOVG4ymHkxHdDMF0afNAS14UIhipUvZZkam3xmhZJD8gpGWAv+gkNFfn
wbEaNyD5a1ZCN4XPjWaCBKMPnr19KcviQE/otRmC+OkqqSoA6F7VYHBP//Mr9+yr
zR5xKg3HpSoQejf5MoEljZoCoFz1mCMzz06rXYZO7O0aLb1by86UbsCa+QqjN9RU
zsoWwuIxnZW82xrTHtddG6AifFIIw2z+55G0cjooRFg6lNA24ScjN4eJ/EvWgHDp
heIHpmoU0VYut1Kncz6EYKzm6yHQ2g==
=fZ07
-----END PGP SIGNATURE-----

--nextPart1581939.E3j6QKcEcE--



