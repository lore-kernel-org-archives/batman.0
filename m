Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 9 Oct 2016 04:07:10 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161009020710.GC5216@otheros>
References: <20160915135249.1925-1-sven@narfation.org>
 <20160915135249.1925-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160915135249.1925-3-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 3/3] batman-adv: make netlink
 attributes const
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

On Thu, Sep 15, 2016 at 03:52:49PM +0200, Sven Eckelmann wrote:
> +sed -i \
> +	-e 's/^static const struct genl_multicast_group batadv_netlink_mcgrps/static struct genl_multicast_group batadv_netlink_mcgrps/' \
> +	-e 's/^static const struct nla_policy batadv_netlink_policy/static const struct nla_policy batadv_netlink_policy/' \

For the second thing: Replacing the string with itself?


Just wondering... I simply tried casting the const away and that
seems to compile without a warning:

-----
static inline int
 batadv_genl_register_family_with_ops_grps(struct genl_family *family,
                                          struct genl_ops *ops, size_t n_ops,
-                                         struct genl_multicast_group *mcgrps,
+                                         const struct genl_multicast_group *mcgrps,
                                          size_t n_mcgrps)
 {
        family->ops = ops;
        family->n_ops = n_ops;
-       family->mcgrps = mcgrps;
+       family->mcgrps = (struct genl_multicast_group *)mcgrps;
        family->n_mcgrps = n_mcgrps;
        family->module = THIS_MODULE;
-----

Or does this lead to some dangerous behaviour on the compiler side?
