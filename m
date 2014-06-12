Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 Jun 2014 17:30:51 +0800
Message-ID: <350643063.kDBGdMaN5Y@diderot>
In-Reply-To: <1401200612-19725-1-git-send-email-sven@narfation.org>
References: <1400939778-12886-3-git-send-email-sven@narfation.org>
 <1401200612-19725-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1590110.ELGKqOOXRY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batctl: Use memleak/error path
	free implementation of hash_resize
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


--nextPart1590110.ELGKqOOXRY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 27 May 2014 16:23:32 Sven Eckelmann wrote:
> The current implementation of hash_resize uses hash_add directly to
> initialize a new hash table. But hash_add has two possible situations when
> it returns an error and hash_resize would leak the data:
> 
>  * data already exists
>  * malloc fails
> 
> The check for the duplicated data is not really harmful (beside increasing
> the time to re-add elements) but the malloc can potentially return an
> error. This malloc is unnecessary and just takes extra time. Instead the
> bucket from the old hash table can be re-used.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * fixed commit message
> 
>  hash.c | 72
> ++++++++++++++++++++++++++++++++++++++++-------------------------- 1 file
> changed, 44 insertions(+), 28 deletions(-)

Applied in revision 6f03fcf.

Thanks,
Marek

--nextPart1590110.ELGKqOOXRY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTmXNLAAoJEFNVTo/uthzAn8kH/jPQQe61kgrgJIDMieOrh+RV
vWh0iDwnpOBK2PxDYnSp8E7lBSwAEMR3E/1fgTzVQewwDeNBiEgr2je8ZM1rwgcU
r2DBl78coyNEB9nleKMKOBXHoa/KdeGCd9yVqe5i2i0h5utP66fZ9H+eNadTU4NN
hY26GznSwWRbvz4YkeL6or/YQN638YcxpSz3kx1lHgB5SDa+JkSnOG45J0WN0KzJ
oWa8BDnvy1ummP6NirS3PVEl8Q4GWyi6vQRZR8PV2NCKdEFjJrAxG5eVpEZcsu4t
XovKpKi2x0NCeA55Qan0Nz8C4ZKacnXs3VDovMS24Ue4oSSAS7WxLUUn1lJb81U=
=Cjof
-----END PGP SIGNATURE-----

--nextPart1590110.ELGKqOOXRY--

