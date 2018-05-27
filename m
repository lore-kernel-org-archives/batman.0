Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Sat, 26 May 2018 19:43:03 -0600
Message-ID: <CAA_JP8XmfiYWFe71iavwSRT40MkaXcrz=k-cvvQQxD-7JLRb-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] where is batman-adv on multicast? specifically IPTV
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

you may have seen my other posts about wISP service for batman-adv.
I'm looking at how batman-adv can handle multicast

the design is batman-adv running over PtP wireless links and then PtMP
access radios bridged in.

I'm looking at the multicast-optimizations page but I'm unclear on something.

I see that if there is just one listener, then it basically becomes a
unicast stream.  But what if I have multiple sites (lets say 10) and
at 2 sites there are 1 listener each.

does this mean that all 10 sites will get the broadcast? or that just
the 2 sites that have listeners will get the broadcast?

I'm not sure how old that page is or if anything has evolved.

The goal here would be to only send a stream to a site if there were
at least 1 listener.

I could also potentially have a device at each site handling PIM for
multicast, but I haven't dived into how that would work on batman-adv
or if I'd have to run a separaet VLAN between each PIM router outside
of batman-adv.
