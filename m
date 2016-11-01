Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 08:30:34 +0100
Message-ID: <10484382.jDe0LnMza3@bentobox>
In-Reply-To: <20161029080328.26584-3-sven@narfation.org>
References: <20161029080328.26584-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6513165.tz98PTrof6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [3/3] batman-adv: genetlink: mark families as
	__ro_after_init
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

--nextPart6513165.tz98PTrof6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 29. Oktober 2016 10:03:28 CET Sven Eckelmann wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now genl_register_family() is the only thing (other than the
> users themselves, perhaps, but I didn't find any doing that)
> writing to the family struct.
> 
> In all families that I found, genl_register_family() is only
> called from __init functions (some indirectly, in which case
> I've add __init annotations to clarifly things), so all can
> actually be marked __ro_after_init.
> 
> This protects the data structure from accidental corruption.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: Add compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Patch already in net-next
> 
>  compat-include/linux/cache.h | 35 +++++++++++++++++++++++++++++++++++
>  net/batman-adv/netlink.c     |  2 +-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 compat-include/linux/cache.h

Applied in c776b4a071d82f8ad0e35d1b9472758ecf69a75e [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/c776b4a071d82f8ad0e35d1b9472758ecf69a75e
--nextPart6513165.tz98PTrof6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGESaAAoJEF2HCgfBJntGYSAP/Rn5gzbOBFyH1cbcuVWiQe/Y
wLVLopPSBSY9OAXhwrGRaLjjzFQMyfTwXw3C9wBPx8FiJdA7I7f4QffIbj2Inl0y
K1poUnMKG7HB9dTANJHwuiDXVQoXChW8IO21/HC0JO8l6XjP2f/i3nPCv0Som/JN
Sw7fu4ZZMCtupVLyxBmbGWQ2VWBbpdj8xzgsT7jSuKhUTEz3hz7g39/9o/5qTzLU
pZJ0IlRs2RdgXe/p7JfpEt5cdsyTV0CRu9m4dsrPXjuFa5Ev6AUom80sRmpjQf90
PDr+qlHpYt34lQyzoS++ReqgVJVV9LK2iKOmTMl19mUfWWIOlQGaCBxVqZgDE0cS
iCAt9nqdFE4VPORv3fveuqsjncPQZF3S8Owjm/yBxhDGFc7stneo0Bj+bdZvsK8t
WV+GX+AWGUQ4PD4s7JBX+LCmOE8dqlFe9UzbFNU9TfX2QA0F5C1KxOPuCkZTh2VU
WpUjS/HPbNUdf4kAONY0ni1/pTI+HyiRNXFumIUa+PSMYRCG0McZ9BGMHbdLTr5n
KRqfP2hNUroCkbu36jnIKTjdRDqYLiczLZtTdOnoWumq872IRurVArpv+soO5uhz
+4hqWXCUCM/NHVCkFupCRQjg8Zvk76yeTzLLyhGlQC9rvIGUtvEtiPsHFS6Mjnbr
ltAAlQDxgKU1WR8Zo3TR
=81Fr
-----END PGP SIGNATURE-----

--nextPart6513165.tz98PTrof6--

