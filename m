Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 15:49:48 +0800
Message-ID: <41801220.Rv582bcDWY@voltaire>
In-Reply-To: <1462947407-25493-1-git-send-email-sven@narfation.org>
References: <1462947407-25493-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4560049.qvg8WTiKkX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused include
	atomic.h
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

--nextPart4560049.qvg8WTiKkX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 11, 2016 08:16:47 Sven Eckelmann wrote:
> The only atomic_* function was removed in the bat_v.c and thus the include
> should also be removed.
> 
> Fixes: 71e957cd30a0 ("batman-adv: init ELP tweaking options only once")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_v.c | 1 -
>  1 file changed, 1 deletion(-)

Applied in revision 84f8635.

Thanks,
Marek

--nextPart4560049.qvg8WTiKkX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMuQcAAoJEFNVTo/uthzAhv8H/25m0mMiO9ffM9pXdIa0P7HT
4EvUB+mibGxXRTMKXxv5CkihbDP6tyGobJykBtmM/dLY8v0hyZRh7z/LDKdfQxTX
yEfGbtNQMfkLxxbcowoQVdPv1J7IoLzZteWc/1/jBA2rJeYgOaIuOT5cpFS5nHn7
tPgyZYZycDU4AgG0UAO3ffHLhtTRE3v8KcFMoA0eI+hV43KV/SccwWTjWgPkuTwL
grzKvBjxB8TlGZTXN1r/Bu/gLJE64rB+3HDx/8Py2yadlEYeTkizFl3ANmX6ppu9
jw2SScZjGV14w9LDtujJpRZBNY3DvGfjVm7QBKpJMC7JDRkS92Gif7YSaZ6DLJQ=
=Bdpn
-----END PGP SIGNATURE-----

--nextPart4560049.qvg8WTiKkX--

