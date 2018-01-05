Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 05 Jan 2018 09:30:27 +0100
Message-ID: <1726572.H7yRIExqUN@sven-edge>
In-Reply-To: <609290bb4d6430ba6261347d43d53809a495afb9.1461267645.git.joe@perches.com>
References: <609290bb4d6430ba6261347d43d53809a495afb9.1461267645.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2118981.8yq2m74chs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] checkpatch: Add test for keywords not starting
 on tabstops
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

--nextPart2118981.8yq2m74chs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 21. April 2016 12:41:37 CET Joe Perches wrote:
> It's somewhat common and in general a defect for c90 keywords to
> not start on a tabstop.
> 
> Add a test for this condition and warn when it occurs.

This seems to create some new false positives:

    WARNING: Statements should start on a tabstop
    #919: FILE: ./net/batman-adv/sysfs.c:919:
    +                                     char ifname[IFNAMSIZ])
    
    total: 0 errors, 1 warnings, 0 checks, 1251 lines checked

The code at this position is:

    /**
     * batadv_store_mesh_iface_finish() - store new hardif mesh_iface state
     * @net_dev: netdevice to add/remove to/from batman-adv soft-interface
     * @ifname: name of soft-interface to modify
     *
     * Changes the parts of the hard+soft interface which can not be modified under
     * sysfs lock (to prevent deadlock situations).
     *
     * Return: 0 on success, 0 < on failure
     */
    static int batadv_store_mesh_iface_finish(struct net_device *net_dev,
    					  char ifname[IFNAMSIZ])
    {
    	struct net *net = dev_net(net_dev);


I know, my mail client is most likely mangling the tabs - so better check
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/net/batman-adv/sysfs.c?id=72deacce011bde7475c90e6ee7d4c7d28c384873#n918

Problem seems to be the [IFNAMSIZ]

Kind regards,
	Sven

--nextPart2118981.8yq2m74chs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpPN6MACgkQXYcKB8Em
e0awwRAAnV7oWu69DmfLhTun2AQ1PUCf7KKNuYPKwj0qUIuBYFPrOs3QjFEDBHwP
HKxqsOcphzOqw2spTlRARrFIkR0toOvbgN+2xpw48+zp7dlvazrHZzMhqj+Upo0R
NWAvesY5MJSTz70sqp7MtK3sPxuK7ZI/JwwdUPYS5bukKBQuTA2VRxR65wfjPgXM
x9yEOHmIgsA9vLfzhXlSPk688UQ4UYpKCHxZlwDmzd8lp5kpB/2TnoniDM0xbFKi
Pp5FBw1A7M2yKVJ0A7TH9gMVRfaNMSyyyeAiE6+uQkuY+Udk40yl2Xz8CDeAc/2o
7YkaCwzxo8b4R5ELYH5Xu8Q3Sv1IstmWPDsKTBw9w8AjBnJ/4uNQ1m7B6K/6fk4C
f635UdoUr5aMufQq2P3tq7qUu1FAeZnOMwobEmEfKbMW4m0tUHEbLVlGWSYEVP1F
SSUs9SdYd/AC2zPTGL8p0PdlV1/OerUrMMsNogCyG9ZD5+VpVpuwZl3NcuaGIQoa
5uda7BiLVHtl33qRajo+io0RHcjqfj+dI9qUgkr1GrcwGEhbBcB9GMq+Bo8s5lKU
UTmVyiwEQExr9rFfS+5Br4OYj+CSxSsHNCmdq1hyHDP7gm5wiGuFIcZNh+vdKmi8
z30e9jEcLHZCsHnCJVH4TYuDQALkByNYGIdXQ5HQCJUl5oe7TyE=
=f7xb
-----END PGP SIGNATURE-----

--nextPart2118981.8yq2m74chs--

