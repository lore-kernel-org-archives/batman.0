Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri,  2 Aug 2013 14:44:54 +0200
Message-Id: <1375447495-31820-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] (no subject)
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

Hi,

This second version adds a few more cases I could spot which look like trouble.

Secondly, instead of copying the destination mac on the stack it simply uses
eth_hdr().


Why do we need no skb_reset_mac_header() or skb_set_mac_header()? Because
batadv_skb_head_push() calls skb_headers_offset_update() after the reallocation
(via skb_cow_head()->__skb_cow()->pskb_expand_head()->
skb_headers_offset_update().

I also checked that the ether header in the newly allocated buffer is not going
to end up being fragmented. But looks like pskb_expand_head() actually reserves
enough space for both the old ethernet header plus the newly requested head
space.

So if the mac header was set correctly before, then eth_hdr() will point us
to the right one already.


This patch is maybe not so straight forward, you need to read quite skb
code. At least not as straight forward as the previous version of this patch.
So I leave it up to you to decide whether this is suitable for next or whether
you think there's a potential for unseen pitfalls, therefore making it
suitable for master only :).


This patch fixed the kernel panic I was reproduceably getting just as well. 
(Which was while sending multicast packets through the unicast functions
while having a bridge on top of bat0)


Cheers, Linus

