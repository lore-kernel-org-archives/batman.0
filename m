Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Dec 2017 12:22:40 +0100
Message-ID: <2125507.fp24uxoQA2@prime>
In-Reply-To: <20171123122142.2968-1-sven.eckelmann@openmesh.com>
References: <20171123122142.2968-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2972513.hgaS1l41DB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Handle failure during hash
 iterator allocation
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

--nextPart2972513.hgaS1l41DB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, November 23, 2017 1:21:42 PM CET Sven Eckelmann wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The hash_iterate functions should not try to start the iteration when the
> iterator could not be allocated.
> 

Applied in 4ea6bec

Thank you,
     Simon
--nextPart2972513.hgaS1l41DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlohO4AACgkQoSvjmEKS
nqE3qRAArrmbZ7dmFUfNL8PUetB8ftCmoF89Dv1gVf2sUq3GrLvYJcxVDarrWi2Y
oKlMR+QIdI7Wf0xJ8DikNd4W2xFGUv1NQ6UAEP+M2PcWKoEMrUO3wgBVv5bVIg3R
PznLmje4yP5S0fz8XQRuJRIbRQ82Pk8x58/wZNom6uzYBWsOU7qacJqul32ewyaD
yFfyMqzBnvtks+FASS0LozvlgcdExc2oNY0awje60Xz366qvNW8sUNkmh+lXAIVq
1kyDVirpwDAPMwfKk3AxcpexKseqWw0kaMzlBo2fbV50NumkPwtInx2UBMprq9Xm
x7jRPFWoircbVgEskTW/Ngq8Q5uvE8KVA87ZdLJqzU458NZMTHcemHISTk1ntyOx
5A0ZX7AJAV9nXvpmd2OUT7qNSOs2dqoJQ6KSoqjeyLknRLIj8dyIG7i7BflmQ1aI
dFlMR2ERzqme2us8ad4JJbbdBNryCMLHyHoLcZubN83e/gi95JGVeAYgvQzdEqmg
LjN/4CjParJU0D9Lz0kaqPYa7Sr4gHU7U7NGOsAS04xjy9HAIrRIUUK7LscnJ2Bc
hPn8BNyhr1qyXOLoSCR5BPxyj9nJzkZ4B32qnqjsPPMD0reZPi7BAJoEqKuDeiNN
Y8b6/AfeQzx+pgc1wJ58g6S/G8/nmv/pVQ0txQVhwLCbuToqYjM=
=/aBR
-----END PGP SIGNATURE-----

--nextPart2972513.hgaS1l41DB--

