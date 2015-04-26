Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Apr 2015 19:39:58 +0800
Message-ID: <4087727.bNIkVho8kq@voltaire>
In-Reply-To: <1429613108-19928-1-git-send-email-sven@narfation.org>
References: <1429613108-19928-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6531776.tMQRdJRde5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/3] batman-adv: Use kernel-like folder
	structure
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


--nextPart6531776.tMQRdJRde5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 21, 2015 12:45:06 Sven Eckelmann wrote:
> The person submitting the patches to the Networking maintainer has to take
> each patch and move files around and add some files to make it work in the
> actual kernel tree. Having all files included and already  in the correct
> kernel tree layout should make this a lot easier.
> 
> The only files not part of the kernel tree are compat-include and every
> regular file in the top level directory.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3: Rebased it on current master without the the hashtable patches
> v2:
>  * Cleaned up the Makefile
>  * Rebased on top of 9f01c16a4409e43e86629418fae9184fabb59da5
>  * Use symlink to show the Documentation/networking/batman-adv.txt as README
> in the root folder

Applied in revision eb69667.

Thanks,
Marek

--nextPart6531776.tMQRdJRde5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVPM6PAAoJEFNVTo/uthzAivgIAJp9PSfIULa8OWefGh5VA5rr
5iNiNhHR2ockUPzPvCHgFwKePELCgS7fYWZBbatFf/qDp6mRfYGkeIlAg2LXfnD9
eb6O4Cc0jZcwCIkwsXvggb4eABLUxMKxH5kN3FgkcyHthKxWSflhQzBw6K4ki5dq
pS9TgV5tVamOXTolaaBTbMleEqndsNybiqnGYhhKUQhP/tWhvlg5YmXRAkRkHZrz
0hgFzmgTyjy3xPY75UcHIhgVTrAMySFYLcDcdP+nXqA0fl5zxBMPU+2ie8dthi5+
4CnFh/lEaxn/D9sjeUK45gN8mQrmrKJx4BV17t0FayASd8vkbIk+bu/Exysz9fM=
=GMbO
-----END PGP SIGNATURE-----

--nextPart6531776.tMQRdJRde5--

