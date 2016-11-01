Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 08:29:20 +0100
Message-ID: <2744303.nAfXxiz0o3@bentobox>
In-Reply-To: <20161029080328.26584-1-sven@narfation.org>
References: <20161029080328.26584-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18026427.FDxRvdgmKO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [1/3] batman-adv: genetlink: no longer support
	using static family IDs
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

--nextPart18026427.FDxRvdgmKO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 29. Oktober 2016 10:03:26 CET Sven Eckelmann wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Static family IDs have never really been used, the only
> use case was the workaround I introduced for those users
> that assumed their family ID was also their multicast
> group ID.
> 
> Additionally, because static family IDs would never be
> reserved by the generic netlink code, using a relatively
> low ID would only work for built-in families that can be
> registered immediately after generic netlink is started,
> which is basically only the control family (apart from
> the workaround code, which I also had to add code for so
> it would reserve those IDs)
> 
> Thus, anything other than GENL_ID_GENERATE is flawed and
> luckily not used except in the cases I mentioned. Move
> those workarounds into a few lines of code, and then get
> rid of GENL_ID_GENERATE entirely, making it more robust.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Patch already in net-next
> 
>  net/batman-adv/netlink.c | 1 -
>  1 file changed, 1 deletion(-)

Applied in 83e3cb32617d07a33fb43faa0957b91b3ac622c5 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/83e3cb32617d07a33fb43faa0957b91b3ac622c5

--nextPart18026427.FDxRvdgmKO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGERQAAoJEF2HCgfBJntGB0MP/3PbhWu5DAVzQWtnEjMl0MkY
csCClxPdxK2G2qHNG7OSEJ3dZ5B3r67H3ck2ukOnp3FsasTjLxr6cUr0uxb+BcBd
+qyrY9C5kdlGUvasaBMAx0DfpHw3XU6uiSXM4hEkyhABG8hfRuTVmBSZL1rnNOHy
bzH6FieTFoBSCITO2iwtuh7wc/pHCLxrVZlNGJY6RVpTHQzI+8ePZD1As835yfYS
FOFPRyT61vNzJ2zHk/HQRHNhO7B2TPyEh5OmUoj6+MeDSGwvh0fzOWpcbAEva4Y7
05UzjRwrg299swsbiYV7IbFSLs/OtdytIaI3KE/Oa32TVDSdYhzVQTI/D2sATZGd
ZjU7X9OY9PG/9FfuPi6inO+e5HbF32dpq8XbOJycd4o301OFc4uGJzFIEiGYxhKB
C9Ygtec3RglgDDC9mdoxcpN7nuq7TIw/jqrfg/vpAUiIrffzNRQs4wBBx96Zk6TE
rpFIiXPmUGQY9S2c6E5JUdDQENFjKtMzhCr8EoQb2Bl+6Tq1yUaX5AOlezdQlGe5
MxArJa7pKro4UNwwzqcsdMfmyOYrzIlJ/UePbGlj5eqbTrFJYz6NUJUKM3Ufb9zh
NH+TUrq7AB7iidm9+hhgP7xTipNuXEL2JWtPeZU51QCNA6CJS6u+pnEFqdsysMka
PR+XBW2nVNUg28Ol1Bnr
=TMxe
-----END PGP SIGNATURE-----

--nextPart18026427.FDxRvdgmKO--

