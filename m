Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Apr 2018 11:20:06 +0200
Message-ID: <6325045.lEza1471pb@sven-edge>
In-Reply-To: <af29c3fe-d25e-51d2-7ca1-47738f25ab7a@unstable.cc>
References: <20180413181618.24144-1-sven@narfation.org>
 <1658833.3ZLkxubxK8@sven-edge>
 <af29c3fe-d25e-51d2-7ca1-47738f25ab7a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7156158.9y9tYxycar";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andre Kasper <Andre.Kasper@gmx.de>, linus.luessing@c0d3.blue

--nextPart7156158.9y9tYxycar
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 14. April 2018 10:11:28 CEST Antonio Quartulli wrote:
> An error message like like "returned invalid all-zero mac address" (or
> "multicast address") might help to distinguish similar "ambiguities" in
> the future. No?

The current interface for the translation is "give me a string and I return 
NULL or a mac address". The resolving of the IPs for hostnames and the check 
of the neighbor table are done on an "I take what I get first" approach. Your 
suggestion would involve a change of this interface and parsing of additional 
information and tracking of states to make sure that the "best" result is 
returned (or a special error state). This is nothing which I will implement 
now.

Should I drop the patch for now?

Kind regards,
	Sven
--nextPart7156158.9y9tYxycar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrRx8YACgkQXYcKB8Em
e0ZX/A//WAGGsAi9R4QjTpUPNHrkyKtDuut8g+roJPYyqdn27CDl7SvPwVMmo1uR
WV41FxLYlHb179W28Lqb5SKwkd+40acbsJB8DEKDDcutoXm/3ZtXiCR8UqMkac20
Xn4yKJL3LBM9R1nY09td97rrUPHjXLnbt3MiYkoQJd9hEzhDTD7M91UHUk0CN4Vo
OG/q4bDYzOLzDtCFLKrnrZynzyqxq2BQHY85ry+pDevg/clTIz4vz6ieuFt6q4eQ
G+yi1zHE5Fh8TFvHTUAimS3+Id6y34baIZsfweOppknrtNaRcfLlBLXWnGe2dPgh
H6MLQuIwRsa1/pbx/0R6KKGZfQrovZtTD240jSFPWBTtIT517onr/VSuOkvRTg62
uvzzMNMrYOc4PhZ/dJQkitPld11Absms5EgMEkWF4Z1Rrf67gRqWkgFSlGN6Bl52
qaTzqNwI5S0fqDrKhdC+AlCslAX74CI1bvJ2BAosbU1TFXu3K4IVhw6WPFF/LOgp
LUnLHMXn2fYtAR6PSNfEdoKome/UwZi/hZUUkNRsBc3XA1u9AG3e1H4TaBPjbjHE
f5VMXPaYiiO8E+8WsmXkQHR2fhYH6OqVyXpzpscejtPm9qixj+rNX/NqxI3u6c9L
mYkz8bdFZ3dpJYuf7gyH7kHFQyCLIDFqNXuut4eWesYnduZ5N4c=
=3vz1
-----END PGP SIGNATURE-----

--nextPart7156158.9y9tYxycar--



