Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:28:08 +0800
Message-ID: <6776625.hHL0P2fD0I@diderot>
In-Reply-To: <1415815109-17111-5-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
 <1415815109-17111-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6131322.GMQJSn8aTB";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batctl: Only parse big enough TVLV
	TTv1
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


--nextPart6131322.GMQJSn8aTB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 November 2014 18:58:29 Sven Eckelmann wrote:
> A TTv1 has a constant header part and two variable parts. One is the defined
> by the number of VLANs and the rest are the changes. The TVLV can only be
> parsed when there is enough room for the constant header. Also the number
> of VLANs must be validated. Otherwise the TVLV parser can read invalid data
> outside of the buffer.
> 
> This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
> ("batctl: tcpdump - parse TVLV containers").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tcpdump.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied in revision 5fda4d5.

Thanks,
Marek

--nextPart6131322.GMQJSn8aTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDXoAAoJEFNVTo/uthzAvocH/j6SWbSvwMPaAIud34rlNSWt
C0mtCkgsP1zn9JHDxZZKE05OdWG+cxsd2IPwC3fwQBQoJj/rO+Bkvap4KVUlVaE3
GaxdtO8WRkaxoen/tgk1LY3isIKFAJ1iYZn5atjjKpfskb2US+gp8CShM6t9D2i1
/kCzw6INHunsLzJpr7yhbTN/UQbFqTlWBKegzLt7C8NNNVugTX050o+/+M2mM7Qt
VTQdvMe4gD5V+5ovhxxMOT9kkKd0hZsHnUSTXT08R08+KLE9a5kdztoLHoC6NjiM
A8BAAzNWC4vr75gzbn6XblRe5v3tkQTvxQnwFBwrw0QKcz19Ty5TJu2ECeg7rZ8=
=2IhW
-----END PGP SIGNATURE-----

--nextPart6131322.GMQJSn8aTB--

