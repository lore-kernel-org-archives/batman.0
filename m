Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Apr 2016 12:59:19 +0200
Message-ID: <6039335.OQnogqN804@bentobox>
In-Reply-To: <56EBEC41.4090404@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <4945319.BvQuBs3oU8@sven-edge> <56EBEC41.4090404@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5257553.lklAv0SSTU";
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
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart5257553.lklAv0SSTU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 18 March 2016 12:53:37 Matthias Schiffer wrote:
[...]
> Thanks for the build testing, I haven't put too much thought into the
> compat issues yet. The genl_register_family_with_ops error should be easy
> to fix, the struct netlink_skb_parms differences might be more problematic.

The genl_register_family_with_ops error can most likely be solved by

https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/tree/backport/backport-include/net/genetlink.h?id=a91a3e6e3a6ed6cdbbe942bafe05ae5fcdf41ce9

The netlink_skb_parms most likely can be fixed by redefining NETLINK_CB to
something which casts to a structure with the name portid for the field
pid for Linux < 3.7.

    struct netlink_skb_parms_compat {
            struct scm_creds        creds;
             __u32                   portid;  /* was renamed in 3.7 from "pid" */
             __u32                   dst_group;    
             __u32                   flags;
             struct sock             *sk;
    };

Kind regards,
	Sven
--nextPart5257553.lklAv0SSTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFL4HAAoJEF2HCgfBJntGIBsQAJXuKTaDRYP7qkyEbab7qAqD
8VdOMRxhI+PK6k5VCzjGPAzlrkaO9Z9o6Ys8bur/htYHztElV5DqconMiOAS8ABJ
F4wsZn79YvkbhhP7buxkldWRCfxO/Aow8ZmvY1u2ozslJPyDqpXviIa3oXvm8zbj
BYdBCmVEb4dGWELbEwXmMyfl8Ny5yjKbdnQ9xJ/EoRghVbU5I1XCK6p5hVAibAOG
b1BxI8G2NkNuXnelQfrIWLz6RTCQnwwOEP/RSpYQWNVnxIJuUmk1ylQWWBz5wnly
Da/i798FnNTcofurYZT2CuUEfCqB1o21U+QCrhUJ/FDEX6cpmUUYRT8ucyMZeFbw
mM7E1BFVTGnCH3W2eTMI03nwLWcH92khjSlAk8ZOh2kuxFo14Y99HwfKu2iLU4uh
q2M8dGmZtH/aos5jd6ilFaMY6cRrIUIVSfwypl0EnalD8X/NrUwyjZ+aC/EwbH7H
N6f3xMO55F28kVx5k781IN3jwc3y6Px5sBKlc2XXn2GwjasyqeuloELzWZwtlSou
AJtUucrQbOuiWN/JYaRb1wzsQhI+3O/NWT71Jt6ESfmxfZy0Ylf/GDjRJtR0cH1U
cFFj0iOZTZMblbr5zLWapAj4gsCNYMfLGgo9jfLZH6+JzcYxjzhGr2UEvNVU1L6g
XJdH9E7dFbWqdfKjjqwM
=5ir4
-----END PGP SIGNATURE-----

--nextPart5257553.lklAv0SSTU--

