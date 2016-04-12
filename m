Return-Path: <andrew@lunn.ch>
Date: Tue, 12 Apr 2016 22:42:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160412204259.GK29895@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] skb->priority and fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Folks

Does anybody remember the history for the follow and can explain why
the code is as it is?

The soft interface transmit function, batadv_interface_tx() calls
batadv_skb_set_priority(skb, 0) to set the skb->priority based on the
TOS bits or 801.p.

If the packet needs to be fragmented because of MTU issues,
batadv_frag_create() is used to create the fragments. It overwrites
the skb->priority in the original skb to TC_PRIO_CONTROL, and leaves
the fragment skb with the default priority.

This seems a bit odd to me. I would of expected the priority to of
been copied from the original into the fragment.

Thanks
	Andrew
