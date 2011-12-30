Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 30 Dec 2011 11:38:42 +0100
Message-ID: <2483190.X2363psPDG@sven-laptop.home.narfation.org>
In-Reply-To: <1444782.kOCQeuloQi@mytilus>
References: <201112281811.58622.clemens-john@gmx.de>
	<4423425.OCX3qX6ovA@mytilus> <1444782.kOCQeuloQi@mytilus>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1625535.yMFh5RKytZ";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1625535.yMFh5RKytZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Sorry for the late reply, but nearly all batman-adv developers are currently 
without internet access (I've just gone alone to a place with free wifi access 
to answer you).

I am happy that you didn't gave up and are still trying to get it working. We 
hope that we can react a lot faster again in one week.

On Thursday 29 December 2011 23:21:39 Bjoern Franke wrote:
> > Am Mittwoch, 28. Dezember 2011, 18:11:48 schrieb Clemens John:
> > > Maybe you can take a look at it and find our mistake?
> > 
> > We got it built now, but it has some unknown symbols:
> > 
> > batman_adv: Unknown symbol free_rcu_tt_local_entry
> > batman_adv: Unknown symbol free_rcu_gw_node
> > batman_adv: Unknown symbol free_rcu_backbone_gw
> > batman_adv: Unknown symbol free_rcu_neigh_node
> > 
> > What did we miss?
> 
> Fixed, batman-adv-y += compat.o was missing in Makefile.kbuild.

It is not really missing. The build "framework" including the configuration 
stuff was rewritten and doesn't use Makefile.kbuild directly. You use the new 
branch and therefore also fetched the makefile patchset. This change will 
propably be part of 2012.1.0... so a little bit too far in the future to 
change the standard openwrt package to support it.

The batman-adv-devel package [1] already supports the new configuration 
mechanism. You can just use try to use it (keep in mind that you have to 
change the patch/commit ids. Marek and Simon also had many other suggestion to 
allow interested people to test new features. We will try to create a wiki 
page in the next year that explains different approaches and some suggestions 
when they should be used.

Kind regards,
	Sven

[1] http://downloads.open-mesh.org/svn/openwrt-feed/
--nextPart1625535.yMFh5RKytZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO/ZSyAAoJEF2HCgfBJntGrMwQAMO3iuwv0Xq1QO33PJA9Wyct
WEWBzvEaFl4RnZI6Ej/+HgTkt+33tuXXqUeDiC372OqktbtrxeMWjPtNN8POjyCZ
6KDMABX9JVFLrTJ6NiwXbVF1jjL6qbWymO07PmyX4TyY65WcpMa3nfXwrVStQKCQ
fH7ARLX9X304/oCJCOppx68n7HSFzR82wVSKLBfTBrL9U7qhFzOKICIvtjAhtNOe
W9mfveCkuGd5j7BMhQ5olnZXOzzaKkJWWgUn86UNd0K2wHpo7l/QXOdIYjJKr/Qg
Vph9b5mmRfKbm41e3E5HyyOt1iu8uB6DNhkIuNKQXHvPY8QcGwA4Nmih9pMDVkr+
zvHLjW7myLxciN7zAQaKRSwLg2g0Gxdsr3gCKLg/PsA4pKmoOqLaXG2JlPHt5q5U
If/BVSy4OA3Ksnep4mXxMgGe5vN3cKAbKGW9grgr7IuF7izQ6ZnDrqHUGXvGKh2E
8z/pIgEbt/cD4a2fa6Yb7jV4As2qxrZqQXD6XQYmi49t5KekZWd9mpJhjlBNwwd4
3Ygvnn8Gv75XXe7Ys0/Vt2vRjJ9kJgJ6EqSZpv3GWupeaaFcUeT/3Fr8loUt2rOc
1VIzRFCV0ufc/wDmDa0uBYjHLZlXodcxNZfmoiSDPXOIq5S8oqX+d4OSCYJEQVSW
IHV7mUX8EQmpJ8pFkRrp
=/tq9
-----END PGP SIGNATURE-----

--nextPart1625535.yMFh5RKytZ--

