Return-Path: <andrew@lunn.ch>
Date: Sun, 13 Mar 2016 23:40:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160313224047.GA14976@lunn.ch>
References: <3465881.llCNFeNLl4@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3465881.llCNFeNLl4@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/6] batman-adv: Add network name
	space support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> v3:
> 
>  - Added new system to add patches to the build (in case the build against an
>    older kernel is not possible otherwise)
>  - Rearranged the retrieval of the link netns
>  - Rearranged the retrieval netns id for debugfs
>  - Fix header includes
>  - Add compat-include for linux/ns_common.h
>  - Add compat-patch for netdev->rtnl_link_ops->get_link_net
>  - Add compat-patch for net->ns.inum
>  - Fix alignment errors

Hi Sven

This all looks good. Thanks.

Which old kernels does this support? Has it forced some old ones to
be dropped from the supported list?

   Andrew
