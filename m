Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 27 Jan 2014 10:48:30 +0100
Message-Id: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Basic Multicast Optimizations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

This is the twelfth revision of the basic multicast optimization patches.

Changes in v12 include (thanks for the feedback again, Marek and Simon):

* added three reserved bytes to the mcast TVLV container to have a four bytes
  alignment (thanks Simon)
* Return value description in kernel docs for batadv_mcast_mla_tvlv_update
  added (thanks Marek)
* Using eth_hdr() instead of skb->data in various places (thanks Marek)
* Switched order of function parameters bat_priv and skb in various places
  for style consistency reasons (thanks Marek)
* renamed one occurence of "BATMAN_IV" to "BATMAN" (thanks Marek)
* kerneldoc for multicast_mode added (thanks Marek)
* rebased on top of master
* now that batadv_tt_local_add() has a potential failure case, a check for
  its return value was added

For Marek's question on gateway code interoperability, I reread that part
and couldn't find any issues with it either. Moreover, any additional
dhcp_rcp variable check seemed redundant to me, so I left that part as is.

Cheers, Linus

