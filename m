Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Wed, 8 Feb 2017 16:40:38 -0700
Message-ID: <CAA_JP8VHB3amFyjwfTtJdc-2E1DgDU5q4NdmVJ6HGVL5g97cZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] bat0 trunk vlans?
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

Assuming MTU is great enough (1528 right? 1500+24 batman-adv+4 VLAN),
can the bat0 interface act as trunk for VLANs?

2 Nodes:
bat0:
eth1

bridge0:
eth0|bat0



device connected to node1-eth0 tags vlan20, does that traverse the
bat0 mesh and come out node2-eth0 with tag in-tact?  Does it traverse
node1-eth0 at all?

I have another post on how to manage PtP radios in-line a batman-adv
link, wondering if I can configure them to a management VLAN
bat0-eth0 native vlan
bat1-eth0.10 <- radio interface vlan10 ...

and if so, how does that effect the possibility of trunking VLANs across bat0.

in theory, bat0 fully encapsulates packets entering node1-eth0 so the
VLAN is invisible 'outside' batman-adv encapsulation so bat-eth0.10
should work, but I just don't know how batman-adv handles VLANs...

thanks
