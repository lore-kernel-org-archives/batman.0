Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Sep 2018 20:05:33 +0800
Message-ID: <1682247.b6jU6xIGrp@rousseau>
In-Reply-To: <20180812190445.28013-6-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
 <20180812190445.28013-6-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1880879.RqXORIIlTR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Prevent duplicated tvlv
 handler
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

--nextPart1880879.RqXORIIlTR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 13 August 2018 03:04:45 HKT Sven Eckelmann wrote:
> The function batadv_tvlv_handler_register is responsible for adding new
> tvlv_handler to the handler_list. It first checks whether the entry
> already is in the list or not. If it is, then the creation of a new entry
> is aborted.
> 
> But the lock for the list is only held when the list is really modified.
> This could lead to duplicated entries because another context could create
> an entry with the same key between the check and the list manipulation.
> 
> The check and the manipulation of the list must therefore be in the same
> locked code section.
> 
> Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>


Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek


--nextPart1880879.RqXORIIlTR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluRGA0ACgkQU1VOj+62
HMCqpwf4lvMUMzL5mQb9yN5lvRPG0gj6Kc1MO9phs3lcStHYusm09APxsdzngKkB
ZZu9eWKZZaMMxPHs6xFQPtxnuBh6ZyLiRrR8wG57MYOU6Ly4A+taMY7Pm635/wff
07Ld2zP/5obMNFtbjMET7fEc1qZicyiVDh1p/ZohvEdgl9SaX510+oYwq1vdnPK6
VqIBPR8aXgi7gdMzhbAX37XRHnbiRbv9vQuvpN+k/1TmZG8xNMB7Jz7vGrLsvIKk
szL+6HxoyKs/H7TmaBvJbqdvH479Ja2HPSYekF+jC+lB8wL0MO8/JEDxXRaFAQhz
SGvR5LwEwPEDyDSL8bcPopjd21uh
=AFMi
-----END PGP SIGNATURE-----

--nextPart1880879.RqXORIIlTR--



