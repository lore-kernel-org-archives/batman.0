Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 27 Sep 2013 16:32:23 +0800
Message-ID: <2446824.BO6cEXVXT6@diderot>
In-Reply-To: <52453E3F.6080300@universe-factory.net>
References: <de510a1e7cb175c854734fa07c347f18ac697446.1380181735.git.mschiffer@universe-factory.net>
 <1412297.LnmMWnToDl@diderot> <52453E3F.6080300@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2339350.RRyCzWJdCk";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: set network coding
	packet handlers in batadv_recv_handler_init()
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2339350.RRyCzWJdCk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 27 September 2013 10:13:51 Matthias Schiffer wrote:
> No problem. Any idea for a good name for the new function? Currently,
> the init functions are named a bit inconsistently, there is
> batadv_iv_init, which is called in batadv_init, and many other
> batadv_*_init called in batadv_mesh_init. I'd prefer renaming all those
> to batadv_*_mesh_init, but that seems like lots of avoidable changes for
> a net/stable patch.
> 
> Maybe the maint patch could stay like it is, and I'll add another patch
> on top for master that cleans things up?

Yes, you could come up with a naming convention you introduce with the maint 
patch for nc_init() / nc_free().  Other renamings could go into next or 
master.

Cheers,
Marek

--nextPart2339350.RRyCzWJdCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSRUKaAAoJEFNVTo/uthzAtegH/RcKAMMTH1xoTRapO0mXV7H7
Tr3Q3dh91ryaYm748ntbeEQ/OrpaEMgRezw2Ar8LHIImIGmfyiMck78M8kjFAfwq
VdFtVcIDEM7Xwwyr0N5Y0/lNi4aXcGDATfONrqOUbyGVnguer7a/u3Ptf+qseOwW
BWOkZDN87PK9fnqMhhU+Ww+F4zGxNH5u3JeA6ZVOSEmr8eft6MBpQelDLnWdThH7
5th4hsjXe0oY8rAwpcioajb0UrOINf0juFkv2pgKQuJavCLchHGi6zr0VMVeu0Bl
m79w/pQsyTTRDUv5ERWCUGyzk7bJykX8DWSB8xWWfb0N10mU/llZL8DJtImM8+k=
=/P10
-----END PGP SIGNATURE-----

--nextPart2339350.RRyCzWJdCk--

