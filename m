Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 01 Jul 2016 10:00:25 +0200
Message-ID: <3538968.M8hm509Ngn@bentobox>
In-Reply-To: <1465721000-9174-2-git-send-email-sven@narfation.org>
References: <1465721000-9174-1-git-send-email-sven@narfation.org>
 <1465721000-9174-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5849216.4seV99RveF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use broadcast as
	fallback for gateway replies
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

--nextPart5849216.4seV99RveF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[....]
> Hm, I'm wondering what kind of overhead implications this could
> have in larger mesh networks.
> 
> Didn't TT support temporary entries? Could the gateway server
> inject them into its global translation table after parsing an
> incoming DHCP packet?

Right now we have the problem that DHCP requests (broadcasts by the user) are
encapsulated by the gateway code in the wrong type of packet [1,2,3]. These
are the unicast packets (non-4addr) which cannot be used to create temporary
TT entries. This should be addressed by the first patch.

The second patch is currently only my bandaid (because I cannot patch all APs)
and I would be more than happy when this patch is not required. So I would not
object when this patch is rejected because it causes noise on the network.

For example gluon already accepted the first patch [4] and thus will hopefully
not require the second patch anymore with 2016.2.0 for clients doing their
DHCP Discover as broadcast.

Btw. the non-RFC version of the patch is here:

 https://patchwork.open-mesh.org/patch/16377/

I have taken the freedom to move the reply to this patch.


Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/16376/
[2] https://git.open-mesh.org/batman-adv.git/blob/a36b7a3b08f4cc7c41103aa4db176a11e965e068:/net/batman-adv/routing.c#l914
[3] https://git.open-mesh.org/batman-adv.git/blob/a36b7a3b08f4cc7c41103aa4db176a11e965e068:/net/batman-adv/soft-interface.c#l468
[4] https://github.com/freifunk-gluon/gluon/commit/93fe275000b65a4148d6a9713a030b0d30e6a9f1

--nextPart5849216.4seV99RveF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdiMZAAoJEF2HCgfBJntGG58QAJuovsqPU7Zh1x9XT+9Wt4XF
lXMZgybbeLOO1CC7A5C7JLAGx+dRjutTFti6ueEYMCGAY+waVi08FA4OY9ZdrJLd
4JPCmUzj6Tosrmwvhi+ug/jDimWCl9BF2s6z5gyA6CqhznfUAv64t0ozvPTQ/DQ2
XyXwAAdEIivC9arrLxvzbQD59rGnjwSFbcrR+0Wx0RHjZLYYFt/zF5FdaLvIRjUs
KCDSJaNZe1dlmlQ9fhaCA+J9yutm5rQXfZ6dt1/v58fih6cqQEWJVJlRuGHV4dQq
7ZkFpDo29T1hbl2bjhSOOGFYGYNrbjEV0qzB2JfzDPqyMP5ZSot0ZEsI62k5Sz6W
VwNcKll7Q+Vfxi8M7FzpiLmKjL2Odu50eGfk+H1Kn7xhqOCi7UWYoTwVYVUkYLs8
60mtTNYB6V2Mw/X2k7UelokJi9OM2K/JIdIaUPgS0Y6IeLq0VHBX5HD9F2OsHGH7
YfDyDA8oJXXTmd2ren74k0BWTnW0uVRv+gPedysNbjIr74RTgtHALbdiRnxv5ufj
3YzHLT1cwizte6gC2g47lGp0QCKWsqdeaZBuEL5JKmPLb8/KkEx4SV6BtK4FRmED
6PtaXrmkgYMDtlCzNft8DreyTNYlP8FO+CQb27Oogp64yeUToM+J0C5rxM5le8Op
cwryyRpj0qjHvpAqvzH9
=7uST
-----END PGP SIGNATURE-----

--nextPart5849216.4seV99RveF--

