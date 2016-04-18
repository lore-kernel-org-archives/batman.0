Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 18 Apr 2016 16:50:26 +0200
Message-ID: <3565172.dz0c0eMaPu@prime>
In-Reply-To: <cover.1458231707.git.mschiffer@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3522240.7J4bfdqEH0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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

--nextPart3522240.7J4bfdqEH0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 17 March 2016 17:45:30 Matthias Schiffer wrote:
> Hi,
> this is the second take of my netlink API patches. As mentioned before, the
> netlink API is superior to the current debugfs API in many aspects:
> 
> * debugfs is broken (see PATCH 1 for details)
> * Netlink is namespace-aware, and can be used in unprivileged containers
>   without problems
> * Netlink packets are more machine-readable than text files, and can be
>   easily extended without potentially breaking userspace
> * On older kernels, seq_file can't fall back to vmalloc if kmalloc fails,
>   which often leads to OOM when reading "originators" in large meshes, as
>   the whole file must fit into a single buffer
> 
> Of course, are also a few downsides; when the data is too big to fit into
> a single netlink packet, the provided data may be inconsistent (entries may
> be missing or duplicated.) This will happen in large meshes only, and be
> improbable in any case.
> 
> The patches have been developed on top of the netns patchset, but should
> be applicable independently (maybe with minor changes.)
> 
> All netlink queries returning lists of any kind can only be used with
> NLM_F_DUMP queries, so that arbitrarity large responses are possible (split
> across multiple packets if necessary.)
> 
> At the moment, the following debugfs files have corresponding netlink APIs:
> 
> * routing_algos
> * neighbors
> * originators
> * transtable_global
> * transtable_local
> * (hardinterfaces for a softif can be queried)
> 
> The following files are still missing:
> 
> * gateways
> * bla_claim_table
> * bla_backbone_table
> * dat_cache
> * nc_nodes
> 
> Obviously, documentation is also a TODO. Comments about the API design are
> very welcome...
> 
> Regards,
> Matthias

Hi Matthias,

thanks for reposting this and sorry for the long silence. Since we have the 
namespace work from Andrew now which would require netlink support, I think 
its a good time to integrate this. :)

I'll try to look into your patchset this week into more detail and give 
feedback. In the meantime, just a few question:

 * Would you like to add netlink support for the missing files as well? 
(gateways, bla, dat, nc) 
 * Would you also like to do the batctl support? I guess we can have batctl 
behave "compatible" by trying netlink first and fall back to debugfs for the 
next few years
 * Also open is the icmp socket stuff, which we could postpone and implement 
later.

Just wanted to check with your availability first, but we would like to 
support the netlink adoption. :)

Thanks!
     Simon
--nextPart3522240.7J4bfdqEH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFPQyAAoJEKEr45hCkp6hyQEQALB9U2jgR3qPwHJ34aBDO6Nx
FI5UQiQwSvSVTbUBi1MeX2G2ZPOi+JAt0+ck+O5k8w5Zz11ujt+zPHw1kUJaNE13
zsvE8RZhb2kBPOmQyhY7HeNWUe923qnRGTM3GhhK2Cb3Vag5TmcNjqkW+5ZKnapJ
4xDvWgesCv7VCbQ32JeWtTntgpRKdlvrGM/mJnPL0CTNWM9xAT3pd3fZdZ5m6YHa
G8EGrHv7eY6U9xo7nNKezLA0X6QnLeqyYJHXeuZn1DVCvW9p3KHUimM4a6HybO7H
oNDhxAnT8+jTyt9B91nKdsB95OpXTBQoNM6pCbxI5d3JAIfLPq4B3PLLUnyH3ysB
4XEU/1tVvGqctVkfCJRVGbmssiT3yzhmcJ1qtWTACqakUKkBXETQF3xscMA7/t2M
EsQdI0B+pwS6drgySDHMPjhTl072U81DUMLdnBhLGm1FkLW/eA+bVoCOUueKG9hu
6aYY8iGTjiiEXsJZcFfx8KgtCvvx9wOcH619WLnP1zf9EMIdPQFUh8YKZqHjDGqv
gnDGcyTH/I9m+AF5a+P+XOFzSkLx2ZU0bw+bHYuD1c8eu94m6JVlj18p8Z2ef+63
AxcEjRSvqtsoBr/fKixyqiwlvd+EUpQZBZnrHJknCgaqUcmV2FIg3UVH9s2WPEef
7qBY6eOvDHaRHCgcnH89
=K4YZ
-----END PGP SIGNATURE-----

--nextPart3522240.7J4bfdqEH0--

