Return-Path: <ipmax2011@googlemail.com>
MIME-Version: 1.0
Date: Mon, 4 Jul 2011 14:45:57 +0200
Message-ID: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
From: Max Ip <ipmax2011@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

I have three nodes (connected through wifi) running batman-adv,

node_1 ------ node_2 ------node_3

They have ip address ipv4 10.42.43.1 , 2  , 3 respectively.

Now, all the nodes are connected to each other.

To see the bandwidth and jitter patterns through relaying, I decided
to disconnect node_1 and node_3.

In node_1 ,

sudo iptables -A INPUT -s 10.42.43.3 -j DROP

When, I now run batman-adv protocol, node_1 still finds node_3 without
node_2 being involved.

Though they cannot ping and avahi doesn't run, batman-adv shows them
as 1 hop neighbors.

How can I disconnect node_1 from node_3 so that I can see the 2 hop patterns.

Thankyou in advance.

Max
