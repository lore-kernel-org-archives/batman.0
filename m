Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 04 Jan 2017 00:29:52 +0100
Message-ID: <1945492.g1BokJd1ll@prime>
In-Reply-To: <20161227075117.5802-1-sven@narfation.org>
References: <20161227075117.5802-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7850345.hQxiDjQzrJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [[PATCH maint]] batman-adv: Decrease hardif
	refcnt on fragmentation send error
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

--nextPart7850345.hQxiDjQzrJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 27, 2016 8:51:17 AM CET Sven Eckelmann wrote:
> An error before the hardif is found has to free the skb. But every error
> after that has to free the skb + put the hard interface.
> 
> Fixes: 8b4132b1447a ("batman-adv: Consume skb in batadv_frag_send_packet")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 205dc838.

Thanks,
     Simon
--nextPart7850345.hQxiDjQzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlhsM/AACgkQoSvjmEKS
nqG5rA//fMv9/db8VuBjeQky5+/21jp10/Qs5zsGPEYc1bo7iiXZd1PHnBhJXKsv
cGzNR2Ixipp4hffbspwHYz0AuqQ3NXhr8QFbHWv1nvMKPJ6uSVkOUxFarE540k9d
xdNTMrRIRYJMni0Thy7ABZWqjPuzhz9nbBmwaJMQyxreYddZCB0o8zxdgHyR0NgC
hES1YR6fmzIOkgg2sHpV23ddYra2siGpKdUzzS0e9fMwM5ErFK75PBA69qiV5xok
5qwR7Jmuv5policeYdupCNtmlAE4oKwKl+J1GsO695FQBwcjTKIUgJnnesIRJwbY
UsDveASzzMeeMJs3CU61NuNzVwFetnM6mvIDibnFaVHjQv241Om7fjW2xYWloWv/
nTochREiFVz+M2FoCsot8Vuiq1z7S9zAxupBVIIF/aOb8379xNKF1bpPxoSxmxzn
+/sw9d9+gOP7jxlh4NWSKVXX1B42a1CEHIqY9aGWXBz9jTTAWhqg/KtOR5XjKjv5
+ZL/TOFw+QcC4rO511I2xeq/p99wIeLzeRm65dmuvTZO/CMzZRl1OLku+NpsINOY
s9w5KScOTfOExQtnq98K+aYPi0ALTeRWYh0ZUH3KBVY+64jfigZP4HkvS1cSF0m4
UVzn+Ot0VgE1gWH6yNudrejkhQYhiqoVP9lZ5k6frDApY2wDZk0=
=fVkn
-----END PGP SIGNATURE-----

--nextPart7850345.hQxiDjQzrJ--

