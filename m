Return-Path: <andrew@lunn.ch>
Date: Wed, 20 Apr 2016 04:36:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160420023640.GB13247@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <9919433.c4WuAskJuF@sven-edge> <20160313154222.GD9674@lunn.ch>
 <1812177.9NXi5yCt0r@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1812177.9NXi5yCt0r@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> we had a phone discussion with Antonio, Marek, Sven and myself how to move 
> forward with netlink and namespace support.
> 
> We concluded that having proper netlink support would be the more future proof 
> option. We would then keep debugfs but slowly phase it out in the next coming 
> years. New features would also be adopted in the netlink implementation.
> 
> It was also our impression that having the namespace support within netlink 
> would be the cleaner approach, although it takes more work because it requires 
> the netlink and appropriate userspace changes.
> 
> Andrew, what do you think? Would you like to check and rebase on Matthias' 
> patchset?

I agree about debugfs. As i already said, i've played with netlink and
netns. I changed my debugfs patch, so that it only creates files for
the default netns. For all other netns, debugfs operations become a
NOP, and you need to use netns.

     Andrew

