Return-Path: <mag@magwas.rulez.org>
Message-ID: <4CA23D45.60306@magwas.rulez.org>
Date: Tue, 28 Sep 2010 21:08:53 +0200
From: =?UTF-8?B?TWFnb3PDoW55aSDDgXJww6Fk?= <mag@magwas.rulez.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Mesh with access from wifi and lan. Which is the
	Only True Way?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

  Hi!

I am struggling with setting up a mesh network. It should be available 
for users without batmand both on the lan interfaces and wan interfaces.

Surely I do have some misconceptions in my setup, but don't know where.
The nodes are wistron ca8 ones, with official OpenWrt Backfire 
10.03.1-rc3 r22796 atheros.

I try to set up the following network topology:
- there is a /c subnet for batman nodes, 10.42.0.N/24
- there is a /c subnet on each node for non-batman users, 10.42.N.1/24 
(dhcp runs there in force mode)
- there is a /c subnet on each node for lan (non-batman) 10.43.N.1/24 
(dhcp runs there)

with only two nodes I have managed to handle all the traffic with the 
following rules in firewall.user:
iptables -A forwarding_rule -s 10.42.N.0/24 -i ath0 -j ACCEPT
iptables -A forwarding_rule -d 10.42.N.0/24 -o ath0 -j ACCEPT

But with three nodes in a linear topology user-A-B-C, the reject 
firewall chain (basically the FORWARD chain) eats up the packets user->A
This is the same rule which rejects batman packets A->C which go through 
B, and there are the gate interface which I do not understand, so while 
the following rules seem to solve the problem at least for three nodes, 
I have a feeling that I am not on the right path, and maybe on a way to 
cause packet storms.
iptables -A forwarding_rule -d 10.42.0.0/24 ! -s 10.42.0.0/24 -i ath0 -o 
ath0 -j ACCEPT
iptables -A forwarding_rule -s 10.42.0.0/24 ! -d 10.42.0.0/24 -o ath0 -i 
ath0 -j ACCEPT

Can someone tell me what I have missed (or is it the right solution indeed?)

