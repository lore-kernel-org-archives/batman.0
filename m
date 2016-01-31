Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 Jan 2016 14:26:27 +0100
Message-ID: <3255100.5LmjYr8IdZ@sven-edge>
In-Reply-To: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1799337.EOLtxPcqXM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/4] batman-adv: Add network name space
	support
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1799337.EOLtxPcqXM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 January 2016 18:48:26 Andrew Lunn wrote:
[...]
> Andrew Lunn (4):
>   batman-adv: NETIF_F_NETNS_LOCAL feature to prevent netns moves
>   batman-adv: Create batman soft interfaces within correct netns.
>   batman-adv: Handle parent interfaces in a different netns
>   batman-adv: debugfs: Add netns support
> 
>  net/batman-adv/debugfs.c           | 118
> ++++++++++++++++++++++++++++++++++++- net/batman-adv/hard-interface.c    | 
> 49 +++++++++++++--
>  net/batman-adv/hard-interface.h    |   2 +-
>  net/batman-adv/soft-interface.c    |   9 ++-
>  net/batman-adv/soft-interface.h    |   2 +-
>  net/batman-adv/sysfs.c             |   3 +-
>  net/batman-adv/translation-table.c |   3 +-
>  7 files changed, 172 insertions(+), 14 deletions(-)

Just to let everybody know: This patchset will break batman-adv compatibility
for kernels older than 4.0 (see d37512a277dfb2cef8a578e25a3246f61399a55a):

hard-interface.c:105:55: error: no member 'get_link_net' in struct rtnl_link_ops
    hard-interface.c:106:54: error: no member 'get_link_net' in struct rtnl_link_ops
    hard-interface.c:107:55: error: no member 'get_link_net' in struct rtnl_link_ops
    hard-interface.c:108:54: error: no member 'get_link_net' in struct rtnl_link_ops
    hard-interface.c:148:61: error: no member 'get_link_net' in struct rtnl_link_ops
    hard-interface.c:149:52: error: no member 'get_link_net' in struct rtnl_link_ops
    hard-interface.c: In function 'batadv_mutual_parents':
    hard-interface.c:105:48: error: 'const struct rtnl_link_ops' has no member named 'get_link_net'
      if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
                                                    ^
    hard-interface.c:106:40: error: 'const struct rtnl_link_ops' has no member named 'get_link_net'
       dev1_parent_net = dev1->rtnl_link_ops->get_link_net(dev1);
                                            ^
    hard-interface.c:107:48: error: 'const struct rtnl_link_ops' has no member named 'get_link_net'
      if (dev2->rtnl_link_ops && dev2->rtnl_link_ops->get_link_net)
                                                    ^
    hard-interface.c:108:40: error: 'const struct rtnl_link_ops' has no member named 'get_link_net'
       dev2_parent_net = dev2->rtnl_link_ops->get_link_net(dev2);
                                            ^
    hard-interface.c: In function 'batadv_is_on_batman_iface':
    hard-interface.c:148:54: error: 'const struct rtnl_link_ops' has no member named 'get_link_net'
      if (net_dev->rtnl_link_ops && net_dev->rtnl_link_ops->get_link_net)
                                                          ^
    hard-interface.c:149:38: error: 'const struct rtnl_link_ops' has no member named 'get_link_net'
       parent_net = net_dev->rtnl_link_ops->get_link_net(net_dev);
                                          ^
    make[2]: *** [hard-interface.o] Error 1
    make[1]: *** [_module_] Error 2
    make: *** [all] Error 2

(build stopped here and there may be a lot more problems)

And with 3.18 you will only get until (see
435d5f4bb2ccba3b791d9ef61d2590e30b8e806e):

    debugfs.c:87:40: error: no member 'ns' in struct net
    debugfs.c:547:37: error: no member 'ns' in struct net
    debugfs.c: In function 'batadv_debugfs_ns_get':
    debugfs.c:87:26: error: 'struct net' has no member named 'ns'
       sprintf(name, "%u", net->ns.inum);
                              ^
    debugfs.c: In function 'batadv_debugfs_init':
    debugfs.c:547:30: error: 'struct net' has no member named 'ns'
      sprintf(name, "%u", init_net.ns.inum);
                                  ^
    make[2]: *** [debugfs.o] Error 1
    make[1]: *** [_module_] Error 2
    make: *** [all] Error 2


Kind regards,
	Sven
--nextPart1799337.EOLtxPcqXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWrguDAAoJEF2HCgfBJntG8iYQAJYLYzx5BjOccErrSQeY9meV
2K6isd7XNq56fJ04H0cI5Yk3T9qb3rFmtzin6jKp2DHLVH+9tuYPqMtHIVrrmCXe
LkylHF0j73cG6eCr3XLR78E9ef9j4E5umHZQMrxQhQwy6yw+HY+4Zjo5+z0c+MJh
DXXzsxt8nPAKsq9XtGTzSCb14+Ftr2uW6KmaBCQ3tSZypKTO2ePN+5C5L4Nkwf0G
rBZMY4TUMUcJHFNO4HFcvo0JYlOEsUxVia7KzwFIQNZGod+Kx6VySSNqpsJEhPJz
rXQ1BN8SIe/ltd/90gWkqpePYQajGuUO9yfLF46PfOW3y9m2Pdb5GynMrJtLrD+A
fKQBg8yESDC5AmMbYfOAue5rYxsRhvfw9KLjaKozHU0ivl6+wbEky6WThRQuSQk4
2LkIJRmdTINDsP1EKccuvacL1RLqEClL4echrtKyJEp8ycTgyBhJ2GFeUcSaUErG
1Ef+CavlyrjnbTZKTYHTY79cm6JjaKRXQV406o1ziilDcZobj0CPDnTprueiSmkZ
eVes5g7AsQhVuhbUBo/cCGpTGG7Xz4+OYdp07dzZ48qfHYtxuMDqYSh5r938GAsi
VWvp2L/VCCBFKw9wGZlPl6ly+ecXVCu2OT+rPiO9AJsuPHGcTr+gxn/W6CPKDF35
GE6sDHWJxoMCNvlxrGVM
=yd6Y
-----END PGP SIGNATURE-----

--nextPart1799337.EOLtxPcqXM--

