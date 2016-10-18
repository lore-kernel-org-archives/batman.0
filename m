Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:48:04 +0200
Message-ID: <2335223.4Edfx8Zmej@bentobox>
In-Reply-To: <20160901082512.16160-1-sven@narfation.org>
References: <20160901082512.16160-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3518392.OFHr3S15PN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v2] batman-adv: Use octal permissions instead
	of macros
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

--nextPart3518392.OFHr3S15PN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 1. September 2016 10:25:12 CEST Sven Eckelmann wrote:
> Linus prefers to have octal permission numbers instead of combinations of
> macro names ("random line noise"). Also old existing "bad symbolic
> permission bit macro use" should be converted to octal numbers.
> (http://lkml.kernel.org/r/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMG
> Q@mail.gmail.com)
> 
> Also remove the S_IFREG bit from the octal representation because it is
> filtered out by debugfs_create.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - fix error in patch subject
> ---
>  net/batman-adv/icmp_socket.c    | 4 ++--
>  net/batman-adv/log.c            | 3 +--
>  net/batman-adv/network-coding.c | 7 +++----
>  3 files changed, 6 insertions(+), 8 deletions(-)

Applied in dec65f2333cb18c2cc28aa41709a7c35c89d1531 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/dec65f2333cb18c2cc28aa41709a7c35c89d1531

--nextPart3518392.OFHr3S15PN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhoEAAoJEF2HCgfBJntGGkkQAIrl+4GZ28Lzos2BgrBoll68
Xw5MobshUjkwrG9bdcStAdDKxcqZXj+0XLIjZ2pNxWrmtoMSj1WzzdwgLvmblmWW
1Bw6D8X64V2ujBqhSkBZdxH/NvxLvKjhR2NKuTdWqGv0qpoyNSkWbCIZgrL4858Z
Qnz4+ua4D47huFkyYzHEIeGXkHeKeQoeP2gAp8hQAqcsJEOzx1QMEFY/Qkx+p2Tb
ESHKQDiS3/FmmFDTO2oFCxTvFAT1o4kX+EYVI8czcnfwouFJqKzZOBjgWs8bDAuL
wchF2zWWg5bQIqWuYmu2sTpyFIYrjWHvfIqjDFpaWEQgPifBpXL2+tvwmgqospt4
YGv69uBB9UOVOGjLX/00ykg+56ntZSP63VOVdMSVngwUg96lso+9s8kgM9PSjO15
IAOStJ84hMMLS/uAiWPWYlLKLijMJFLs77wQLv5KOqHxq02OhaDmBrDm3tbzvpMR
ZLiI3H3dpMt6AwjSeK5oIPDxvLPifgp2vZejI0N+669Dd/sEMiuGHnPEBpNhVIKe
zjMzbuhc5HVieWZDpWajehCay0zgonqT9C9fe4nZhY9bJoXs5I16ZtHudqi/zRqM
FwBfHT+kh7u7dfPosE85qNA097tFNyBRakgTD/9LX16mO9OEz6/3WL5Fdf6/6Jil
liiTz3Y4ppnm5yNr6oPQ
=JSc+
-----END PGP SIGNATURE-----

--nextPart3518392.OFHr3S15PN--

