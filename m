Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:53:21 +0800
Message-ID: <1690916.HdFE0f7G5K@diderot>
In-Reply-To: <1400933804-9661-4-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
 <1400933804-9661-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2719089.hTt80JF1yL";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batctl: Return success only with
	valid line_ptr in read_file
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


--nextPart2719089.hTt80JF1yL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 14:16:42 Sven Eckelmann wrote:
> The read_file function is rather complex and cluttered with different
> functionality. One of it is to provide a line_ptr of a single line to the
> caller. The caller trusts the return code for a SUCCESS of this function
> and tries to access the line_ptr. But a failed getline may lead to an
> NULL-line_ptr. The caller tries to dereference this NULL pointer and
> causes an segfault.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 51b3e92.

Thanks,
Marek

--nextPart2719089.hTt80JF1yL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlxvhAAoJEFNVTo/uthzAqDoH/iq0yYAORSN/6lBX15RtjX+Y
+Jl5G796hNL7zk+VN09aO5ToRKrr2j4HI9ci6Tn+6EXloWag3J/FOaTXXacSeR9f
OOs4zb/THYTT2R55UVsBno1//Trry/WpSQ364CjomSBd0ym1XJKOYVn71HyFYWVA
16CnYui4kkjYtwsqwjRfuoxC3phfJ9MZ4Z40CpFEEEEMVLp5xAExGqzLpFnYpR6V
Lp1Y8TQLJ4FFvCF6j7Eb6Yo2otJ1DZZkXB/UTFc5SWt2x9tWymwAlsj3otTDggJm
W5F7w0Cq879kEcMkxmZ//Fay+GZDmcfGP6c6eiesGEeKnksT7pBZik1X34aert8=
=KR2N
-----END PGP SIGNATURE-----

--nextPart2719089.hTt80JF1yL--

