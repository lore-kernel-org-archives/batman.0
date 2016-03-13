Return-Path: <andrew@lunn.ch>
Date: Sun, 13 Mar 2016 16:42:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160313154222.GD9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-5-git-send-email-andrew@lunn.ch>
 <56DD8E53.3010904@universe-factory.net>
 <9919433.c4WuAskJuF@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9919433.c4WuAskJuF@sven-edge>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Mar 13, 2016 at 10:12:07AM +0100, Sven Eckelmann wrote:
> On Monday 07 March 2016 15:21:07 Matthias Schiffer wrote:
> [...]
> > By the way, the netns support is another good reason to switch from the
> > debugfs interfaces to a netlink-based interface (as the netlink interface
> > wouldn't need userspace applications like batctl to be aware of the
> > namespaces). I guess I should finally finish the patches I started writing
> > for that...
> 
> So what is your suggestion here? Should the namespace support for namespaces 
> be rejected and you send in your netlink implementation patches? Or should 
> this patch be merged and be removed (together with the rest of the debugfs 
> stuff) when your netlink support is integrated?

Hi Sven

I would expect the debugfs code to stay around for a while, so people
have a chance to upgrade their batctl and alfred to the new API. We
probably need one release with both?

	 Andrew
