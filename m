Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Nov 2016 17:21:31 +0100
Message-ID: <2171693.eEIDLaHTPd@prime>
In-Reply-To: <20161106093738.17010-1-sven@narfation.org>
References: <20161106093738.17010-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7664880.cprTU8go2C";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7] alfred: Check batadv interfaces via
	netlink
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

--nextPart7664880.cprTU8go2C
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, November 6, 2016 10:37:38 AM CET Sven Eckelmann wrote:
> From: Jean-Jacques Sarton <jj.sarton@t-online.de>
> 
> alfred is checking the status of the mesh interface before it starts. The
> mesh interface has to have accessible debugfs files "transtable_global" and
> "originators" before alfred will accept it.
> 
> batman-adv will not create debugfs entries for network namespaces. Thus
> this check has to be modified to first check via netlink if the interface
> is providing the same information without debugfs. If it does then no check
> for the debugfs files is necessary anymore.
> 
> Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
> [sven@narfation.org: fixed commit message, mark debugfs function static,
>  fix whitespaces, fix unused init of variable, only fallback to debugfs on
>  EOPNOTSUPP, rewritten batadv_interface_check_netlink, fix return of
>  batadv_interface_check]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 2310c47.

Thanks!
     Simon
--nextPart7664880.cprTU8go2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYIfuLAAoJEKEr45hCkp6h5OYP/1DgXrprtNoVX53UMDf1NK+9
zyn/X5J/nYu/Aq6OtHEC4hfq5gelT8+63qYTZEzaeS0/JFoqYHXZlO4kLd6/wgds
1u9vJd1LKq8vN5ttCaClYQTkCaCkV9mwC/ceQUrXlv/G+V1DhVPoleLPMlbovs6+
8WI1ihOQ8l5+uhEaFocYrlmnH5kWA4s2gCkQXvcmIetEZXRR5JiSU3CpI/9YEDpN
bSRXgatv9V43Go2APWRDtP9CXoeF2rljG2bYEPWUJYRnM23LXigUYsJFC8G/YEJ9
iCHoVNJt7eQj6gxPrpVN9iv9PTzuVMA5cyxoRjWDwEmL312+hhKIDF10v+y/ntWY
9pGXSDmpY28MSI0TQr70ugjCkG0SpgR264v8mt2ZnqhGNK5vBJo1nw1e+0K5KsI5
5eCHtxpqYZBrXnZ3Rc0jMnfKG6KOdsNHNaH3SADN5uIRGfTPzU96gIZhwpgimi4j
XBF9imBlFnp/HhM/gr4LhjrXsxnPao8cE3vvRDkkDJihnPlnIVs+a1aY2E4yZS8N
jsfQGiI/tNlOeQI4bJin+yWwgnjLDxm5BLRetmFIvrH/uSzEW6G74mJ8WqwxNJqa
bnx98k53h1KQ8DzMV4ps3wXXC96K/e6K/pJOhBf8a75STiZDQiIA33bNzVCerUbi
zpCJR7hhdh4gVmpQRSL2
=rv7f
-----END PGP SIGNATURE-----

--nextPart7664880.cprTU8go2C--

