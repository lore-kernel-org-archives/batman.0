Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jul 2017 10:00:07 +0200
Message-ID: <2288411.YZ5uf0ZlKO@sven-edge>
In-Reply-To: <20170618081230.31596-1-sven@narfation.org>
References: <20170618081230.31596-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18312027.cyoZNUpmJJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove too short %pM printk
 field width
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

--nextPart18312027.cyoZNUpmJJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 18. Juni 2017 10:12:30 CEST Sven Eckelmann wrote:
> The string representation for a mac address produced by %pM is 16
> characters long. Left-aligning the output in a 15 character wide field with
> %-15pM is therefore misleading and unnecessary.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied as 2bfa77d941c4b20af879cf85730b103766b5a709 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/2bfa77d941c4b20af879cf85730b103766b5a709
--nextPart18312027.cyoZNUpmJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAll8QIcACgkQXYcKB8Em
e0Y8pg/+Jte9lJsNHYvQzeat6StD5/lQTa+21A8DbZwUCHeY2dW7g2+Qsm8dHi21
+MdAQO9Lusdrtmo2rmqjoEPLYBc3yCOxJKdH2fn/cNu02+oRSu8AZcw/n9jO+hTH
gIGvgeLtGmtsSOBQ9jWrV4s/YNaC/hIPl4XWDAqV5cTksWq/c2lqlwwr9cc5tN9B
VZlHSY1u47fzTdlHuFzuLp792yLBwKpAAmwIDwTHYvY86I/inNOl9NG3/2Nfd6qA
cql6WQOCwejOmEo9iwWq5GPJbtJ8epo9M3ojQ8YRuMGSxIlAx74UuXiB1vHk6Xm9
7voQ7yaq/Jx0zrx3WhVK0OKz9F9H7FW+I5LA+X8q8a0sP5NfCPIvcXKxIsQIaLBD
5/3csVK0aLnA/ONQ4XavZtwIHvbgEJSQICSWLytWK36GJQwL2DTRXJ8EEV3vu6yM
yglZxzRMgz6bHpVhAbhB45cn2pi8ccJtTC3b36m7ZzCi9ccu69ZOWkBKB9Zy5mcW
lpBJ1YniPrp6pZEbj8BcF1RpkWFU4jkMIS5LfBrk+Hu0MTiV9Spwz1BmY8kFLmeb
+1knR5XdZ7Nrpgp1NTukaHRPepZmbIkSCbn5eAHflwrox7IELTOG9fOfW8ap0Pr8
2IpP/CcNMoK6MWlK+EiT0DxzPKp6slwRDPy+jrIOtYHuDmsNfJc=
=CKa9
-----END PGP SIGNATURE-----

--nextPart18312027.cyoZNUpmJJ--

