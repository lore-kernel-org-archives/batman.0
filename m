Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: ELP - use wifi tx bitrate as fallback
 throughput
Date: Tue, 26 Nov 2019 10:29:43 +0800
Message-ID: <4586508.ZjQXdf9tYs@rousseau>
In-Reply-To: <20191126022738.29214-1-mareklindner@neomailbox.ch>
References: <20191126022738.29214-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9271938.pX6P5OlBZX";
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart9271938.pX6P5OlBZX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 26 November 2019 10:27:38 HKT Marek Lindner wrote:
> Some wifi drivers (e.g. ath10k) provide per-station rx/tx values but no
> estimated throughput. Setting a better estimate than the default 1 MBit
> makes these devices work well with B.A.T.M.A.N. V.

I have been testing this patch for 2-3 months in production setups and while 
the approach isn't perfect, it produced acceptable results.

Cheers,
Marek

--nextPart9271938.pX6P5OlBZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl3cjhcACgkQU1VOj+62
HMA94wgAhqqbtzaqWaR1M17CtS20V0vtaQE2s33uowouckDdFHPrWBHBiNbutiSe
GxXS9Jrwp7wbiMm532w8jTmscmy1/dV2SRr9tVTaEg83TWbzfOc9XpYbB20urA2L
g8Qzmj2aRd9IVzrZFG3T7v/0rC5M4/CvLn4ht+cCsdAB/fp+G6hpl8UoWnuWCfy0
K0divCZDmTvDLf279hQ1zFIF6mBPH9E+oeGayhDBXYXlvKiKin2/dU5aKj+wVzwd
1Agc6xIIQ89bvyskiE04xZrfSVYM3zZfnpHr4BZ8SI7YWyXsGC+6ISqztBmm6w8M
jphHnCePYaXd3AB4mXrH2dOFCuRH1Q==
=cmOV
-----END PGP SIGNATURE-----

--nextPart9271938.pX6P5OlBZX--



