Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 01 Aug 2015 20:27:46 +0200
Message-ID: <2676271.FVut4a8TrS@sven-edge>
In-Reply-To: <55BCEE50.3080600@rund.freifunk.net>
References: <55BCEE50.3080600@rund.freifunk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1951084.OTXe5octcV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] old batman-adv within 15.05 brunch?
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


--nextPart1951084.OTXe5octcV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 01 August 2015 18:05:36 Ufo wrote:
> is there a reason for staying with batman-adv 2014 for openwrt 15.05?
> 
> our current freifunk leipzig running batman-adv 2015.0 and it seems to work
> 
> https://github.com/openwrt-routing/packages/tree/master/batman-adv
> 
> vs.
> 
> https://github.com/openwrt-routing/packages/tree/for-15.05/batman-adv

I would even say that it should switch to 2015.1 (not yet released) because it 
fixes some nasty problems:

batman-adv 2015.1

 * support latest kernels (2.6.29 - 4.2)
 * cleanup of coding style
 * cleanup of the compatibility layer
 * convert to the Linux source directory structure
 * adjust default configuration
   - disable network coding
   - enable bridge loop avoidance
 * bugs squashed:
   - avoid DAT to mess up local LAN state
   - fix race conditions in DAT/NC/TT/MCAST TVLV handlers
   - fix build system POSIX compatibility
   - fix gateway selection in fast connection (1) gw_mode
   - fix initialization of detected gateway
   - fix race conditions in the translation table
   - fix kernel crash due to missing NULL checks in vlan handlers
   - fix potentially broken header access by multicast optimization
   - fix broadcast packets cleanup for purged outgoing interface

 -- XXX, XX Aug 2015 XX:XX:XX +0200

batman-adv 2015.0

 * support latest kernels (2.6.29 - 4.1)
 * cleanup of coding style and add kerneldoc
 * bugs squashed:
   - fix incorrect lockdep warning in network coding
   - fix condition when bonding should be used
   - fix support of bridged batman-adv devices with kernel < 2.6.39

 -- Tue, 28 Apr 2015 20:20:02 +0200
--nextPart1951084.OTXe5octcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVvQ+mAAoJEF2HCgfBJntGn7QQAJRw9GMVcwx6tP1hydEnyNuu
IH4tOzMYxvPK9KAV319adhzj35awG1zW7LwH50taEUwME1syZOwMRPwAcRhTW5PG
AuCN+TaYhWAeBPTLZ7rCw7tAcUomVEFdQ/9WTOxt8tCY9Jml32OVR3IisQb0F/8k
t00NI16qZtMbKhmz+zHRlnJ+sf6fs4x66Jtz/OyaFX7NPqs7RfA+4MjD4Ttmf5Is
dSVpH/dN5dxiK2sBNGbTwaE+hYAdVhDEzyQsecbxkHiW6ke2J1J+erYrs6HVrws3
4iJoQOEkR05PZATv/YP9UOFhYeejqPwwn7k8L7poXe2xasr7XxhzJELp6LY4QJqu
urzot3K+Aok9NO5gZdnikvzOVlgXTpOwkIwnh40hryaex+wZUcqKIDPDi95VgbDb
31BKywGWkNm5YMGxQuD2PpyyqkbjbQQWj1gfapwWrf9tHv5v3yAXIR0CGR56/JdQ
y8mUd87diOqbinWoyzW6hSp8dYwIFJniM6n2MH+nijsorlZTrY6ibthTxgDW+NZ9
PMhSbLH9ywguXAh03QaSwkPDGsupRvIiw79l7V9lfxl7kW+wIIfdU7itX/vyags1
ys2WD5Z78cv3yHki1LnACt4joPwtnBt+m6z1Mlxm5Q32Z2i8yeye2YkpyKBmFjQ3
ThhgYLAyZ4u0gZXa8dCm
=ZQ29
-----END PGP SIGNATURE-----

--nextPart1951084.OTXe5octcV--

