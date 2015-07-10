Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:12:29 +0800
Message-ID: <8603159.s559zyjR10@voltaire>
In-Reply-To: <1434957203-6939-1-git-send-email-sven@narfation.org>
References: <1434957203-6939-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4117359.vNPnRbI76x";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Replace gw_reselect 64
	bit div with shift
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


--nextPart4117359.vNPnRbI76x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 22, 2015 09:13:23 Sven Eckelmann wrote:
> The 64-bit gw_factor is divided by BATADV_TQ_LOCAL_WINDOW_SIZE ** 2 * 64.
> But the rest of the calculation has nothing to do with the tq window size
> end therefore the calculation is just (tmp_gw_factor / (64 ** 3)).
> 
> The problem with 64 bit div is that it doesn't work on systems without
> native 64 bit div support. It has to be emulated using do_div or div_u64.
> The change in f63c54bba31d ("batman-adv: Avoid u32 overflow during gateway
> select") only compiled on such systems because the compiler converted the
> div to a (tmp_gw_factor >> 18). Making this explicit avoids having build
> problems in the future when BATADV_TQ_LOCAL_WINDOW_SIZE is changed in such
> a way that (BATADV_TQ_LOCAL_WINDOW_SIZE ** 2 * 64) is not a power of two.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  gateway_client.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied in revision 013aab3.

Thanks,
Marek

--nextPart4117359.vNPnRbI76x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn35uAAoJEFNVTo/uthzAlzAH/3mPuoNH0yw6K/LbKLkhySoy
3aGCFs13Kb3+NxfXzdXLhlOb3jgJCUTKLBdNJli78R3M0sJ0fX9wwXhJNt7IDncr
Iy4vUaF6PcQg3cdCrgWzpeTnvQ2ppZDlWZpMcorcLZG8hkZFRXiSxjXAVKjydoyM
QigI9A46f2ypJ9v3WBOpe/vrTEYR0O1mRzg4PRI3P5FTX1L2unI1nAoiG0PZmy9t
CBOh/U03XyJYSp9/xWDse/NE11Jb0aLqmZmSvJK1MLNlipNZZwDFkSgx9LxmA+Uz
BMnzD6Ot61NS4OKT+FUNgP5v7oK46UWJvTlQcwugeG5dwoDl9fBsWrXeD5/DHd0=
=tV3B
-----END PGP SIGNATURE-----

--nextPart4117359.vNPnRbI76x--

