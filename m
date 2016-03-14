Return-Path: <andrew@lunn.ch>
Date: Mon, 14 Mar 2016 15:06:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160314140624.GA5636@lunn.ch>
References: <3465881.llCNFeNLl4@sven-edge>
 <1457895034-13823-6-git-send-email-sven@narfation.org>
 <15512323.RRrA1BdBoh@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15512323.RRrA1BdBoh@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/6] batman-adv: debugfs: Add netns
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> Matthias is against applying [1] patch 6 because it would require that
> batman-adv supports this interface for a long(tm) time. He proposes to use
> netlink instead.
> 
> Andrew, do you want to change patch 6 to avoid creating the debugfs stuff in
> non-init_net netns?

I'm not sure how well that is going to work, from the user space side
of things.

In the kernel, we know if we are in init_net, or some other netns.

In user space, it is not so simple. Ideally, when in some other netns
than the default, we need all reads/writes to debugfs to fail. What we
don't want is it seeing the default name spaces files, because it is
going to get very confusing. These files refer to something which does
not exist in the current netns.

The problem is, how do we find out if we are in a different netns than
default?

	Andrew
