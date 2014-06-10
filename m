Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:41:11 +0800
Message-ID: <2208363.6InVyE7g70@diderot>
In-Reply-To: <1400933804-9661-2-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
 <1400933804-9661-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3334893.MFc2qAnVMp";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/6] batctl: Force null termination of
	string after strncpy
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


--nextPart3334893.MFc2qAnVMp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 14:16:40 Sven Eckelmann wrote:
> strncpy doesn't terminate the string with a '\0' character when the length
> of the destination memory location was shorter than the source string.
> Accessing it again with string related functions isn't safe after such a
> semi-failed copy and the caller has to handle it. The easiest way is to
> always set the last character in the destination buffer to '\0' after the
> strncpy was called.
> 
> Also the length provided as argument of strncpy should not be the length of
> the source buffer but the maximum number of bytes in the destination buffer.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat-hosts.c | 6 ++++--
>  bisect_iv.c | 2 ++
>  debugfs.c   | 1 +
>  functions.c | 8 ++++----
>  tcpdump.c   | 2 ++
>  5 files changed, 13 insertions(+), 6 deletions(-)

Applied with a slight modification in revision 4faf653.

Thanks,
Marek

--nextPart3334893.MFc2qAnVMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlxkIAAoJEFNVTo/uthzAhn8H/16JOmw6yHLvZPtHOucmunx/
+llXPauwiKUra5EckObpLWT2EpQgAgfC7abtO8b/rjZJRZfDbyoJSkQzMwDCZgOA
RukRLzVWEdDULUV7OTC6NSWVlf5mrsMxcQdiCujNpU6nvL0AStq8qhyiy+FK7I9Y
72Dx8sjw3/MivNe3+w9fgseb1bKjdTm3+d0GZcMwlFVDh4skwJ0SzZ+sDCV1JuvE
8ixCygMoGQM4wWYUgCBkxj+ErtYwUHt8JJaUb589BPcWLfwlypxOQ3y+PDt0E1e5
m0Zb/I4CkN0ITCnCtjFQ0xtM4YMKeK36+QSmFI7FZc3AdSfACFDH8epXDzD4rWY=
=hmMO
-----END PGP SIGNATURE-----

--nextPart3334893.MFc2qAnVMp--

