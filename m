Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Mar 2016 17:02:57 +0100
Message-ID: <1694240.jq4xBCUVhK@bentobox>
In-Reply-To: <OF3D785311.F814DD90-ONC1257F69.0056D58F-C1257F69.00573B0A@phoenixcontact.com>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
 <2502138.exi8rd1dt9@bentobox>
 <OF3D785311.F814DD90-ONC1257F69.0056D58F-C1257F69.00573B0A@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1855694.SPqzDbauWe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCHv2 2/7] batman-adv: speed up
	dat by snooping received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

--nextPart1855694.SPqzDbauWe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 01 March 2016 16:52:47 Andreas Pape wrote:
[...]
> > Where is the code to check that there is enough data for the iphdr
> > (pskb_may_pull)? Same question goes to Marek for his initial change in
> > 48628bb9419f ("batman-adv: softif bridge loop avoidance") that
> introduced the
> > vhdr->vlan_ethhdr check
> >
> 
> I will leave this to the result of the discussion in [1] which you started
> and will not handle this in the next version of my patchset. Correct?

You definitely have to check the size for the IP header. The vlan ethernet
header check is a different playground and mostly unrelated to your problem.

Btw. you can skip this check when you just use skb_header_pointer to access
the IPv4 header. It will return NULL when the data cannot be accessed. It
will also take care of copying data out of the fragments in your temporary 
"buffer" when the bytes are not in the main buffer of the skb. You just have 
to prepare a large enough buffer on the stack and only use the returned 
pointer.

Kind regards,
	Sven
--nextPart1855694.SPqzDbauWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW1b0xAAoJEF2HCgfBJntGsXwQAKvZh0vVhCAWC+1PS3rp+3lB
4HiclMCUU+dFwBn5ktL1Ofcxd6IrUr/DLnk6U648vd8/2tiSMZUJlyhm/Xt3rkbZ
Td2Z893dK3C3dTxHS+Fp62jBRZJcKrvAMuQz8tyFB7kcJb9k+yngH9sPW+OFOLzb
YQYA2mo3uYGGvE5oAoqr76Von/5NWlyDXOIbweBQebkxQOQON4R0CcxobLtv7wg8
ubjqhRL3b1pFWHYEF0qGxA3vW5JhFIrPhdiMx797/ds/SsbnfcBAOwt36CosMxN8
afkA2MqqJkMVWD+ot8O6oOsXdOp+FnHss08n6LfG8mC8iZf7YOtogN4mp/F1bUNe
fixiKGxTkgxn6aIzuo4zRerm4luonhrd5p1OqHFP7W+HEs/IWX0siekQpd5ilNZx
XsR0kCfbiAaQ0fmanOte0DuVHjuZj8rZ7zsYg7zpoMU0D0/TrrBYu7302oKpnjTS
sFZFVAbcHO7/Wjoo8K1be+nUZKumzHKeabo0SrciUlUs7iENS2K+nbbwsx38EEey
owLPMdAT8mjRSfJF+IiriWxyYFQxGfsDjsT9jrh2GV3zH8WHuK/H3trsjJC0tWoy
38VRXPALy9RuPp6xJUK8y91c57gd3BMFXjLSvSaLERS3GIQQEGAD+bZxVFjERimx
WqKibcm5DCBPHkYLjj94
=vRW+
-----END PGP SIGNATURE-----

--nextPart1855694.SPqzDbauWe--

