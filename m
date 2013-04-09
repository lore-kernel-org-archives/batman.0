Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
Date: Tue, 9 Apr 2013 13:47:52 +0300
Message-ID: <CAP5XTDPvnsM_4Vd+y6DMSgLPEoRWGymi4drQKVeOyPuuVqU2gQ@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] DAT - possible bug at incoming ARP request
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

In the file distributed-arp-table.c, function
batadv_dat_snoop_incoming_arp_request, after creation of ARP reply
(skb_new = arp_create(...)) and testing if the creation was
successful, shouldn't exist a call to skb_reset_mac_header(skb_new),
just like in batadv_dat_snoop_outgoing_arp_request?

I've done something similar for NDP and I think that this is the line
that might generate a kernel panic (not sure yet, I might have to do
more testing).

As I said, I'm not sure yet, and maybe my code might generate it. But
my question is why isn't here a skb_reset_mac_header as it is in the
first function.

Thanks,
Mihail
