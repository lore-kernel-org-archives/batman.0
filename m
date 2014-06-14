Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Jun 2014 09:54:50 +0800
Message-ID: <1795448.yfdzlp1HKX@diderot>
In-Reply-To: <1402590823-3605-1-git-send-email-sven@narfation.org>
References: <1402590823-3605-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1977350.tp0znIuYis";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Force \0 termination of string
	in bisect_iv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1977350.tp0znIuYis
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 12 June 2014 18:33:43 Sven Eckelmann wrote:
> This is a part of patch 4faf653307789150f1d40383e95c85a086630378 ("batctl:
> Force null termination of string after strncpy") but was forgotten before it
> was submitted to the maintainers.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bisect_iv.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision c861e47.

Thanks,
Marek

--nextPart1977350.tp0znIuYis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTm6tqAAoJEFNVTo/uthzAo2cH/3uK7UbRgt3RSxBYvD5xXe4M
p4+pStjPSbB3BpvPZFy8qbL5Wuj/SaowrEb5bM0eFcxr1jpi0BsNtsKifZfsESiU
7B7y5ZwS9WGa3kiw3aLr/IEaAEa1sHhcGRQG2yfWG5PpBjBjXa7UYJ76uulz1ZxD
bYTLWMkDkbylj0E5WxhYBFPYLnzTvLX3Cj+9bUVLNWxsmNIIc6vbV2Ie+SAZA31B
lsBT/b2hCXNJ4l/d1M67UeNZtjbsT34FaB0A907gYZXDmIiql3GXjynkUnvTppbJ
RWqoctHJqg06Pnx9kqlngRylWD1UdMXjW+3afJvFLRtiXv+zb7z+YtaDokfqiyk=
=JnTg
-----END PGP SIGNATURE-----

--nextPart1977350.tp0znIuYis--

