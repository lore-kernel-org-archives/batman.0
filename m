Return-Path: <fabio.carvalho545@gmail.com>
MIME-Version: 1.0
From: =?UTF-8?Q?F=C3=A1bio_Carvalho?= <fabio.carvalho545@gmail.com>
Date: Thu, 7 Apr 2016 00:47:43 +0100
Message-ID: <CAAz6EDdLudcU10Uc2=u8_8zgvCuLMRoYHd3+kf77Q5_gzTkuVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [B.A.T.M.A.N] simulate multihop
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

Hi all,

I have a network with three nodes and i wanted simulate multihop with
batman-adv protocol.

node 1 <-> node 2 <-> node3

For this, i have to block mac address of node 3 on node 1 and mac
address of node 1 on node 3. Thus, they only communicate via node2.

I can not use iptables (iptables -A INPUT -m mac --mac-source $MAC -j
DROP) because the protocol works on layer 2 and iptables works on
layer 3, so, when the packet arrive at the node is handled by protocol
before being blocked by iptables.

After read some post, another solution is using ebtables, but ebtables
only works with interfaces in mode bridge. If i execute these rules on
nodes it does not work.

node 1:
ebtables -I INPUT -s <MAC_node3> -j DROP

node3:
ebtables -I INPUT -s <MAC_node1> -j DROP

Anyone have another solution or i am doing something wrong? I think
that ebtables does not work because my interface (wireless) is not on
bridge mode, i cannot set it for bridge mode because i need create a
mesh network (the wireless interface have to be in ad hoc mode).

Cumprimentos,
F=C3=A1bio Carvalho
