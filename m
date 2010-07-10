Return-Path: <post@tiwoc.de>
Message-ID: <4C37C205.3030003@tiwoc.de>
Date: Sat, 10 Jul 2010 02:42:45 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>	<201007061736.14006.sven.eckelmann@gmx.de>	<20100706161737.GA16045@kroah.com>
	<201007100107.57451.sven.eckelmann@gmx.de>
In-Reply-To: <201007100107.57451.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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

Am 10.07.2010 01:07, Sven Eckelmann wrote:
> batman-adv works quite well for us - but that doesn't mean that it is good in 
> context of the current kernel development. And who should know it better than 
> the netdev guys.

Hagen Paul Pfeifer suggested in his message "a generalized architecture
and a user space implementation of the protocol". What came to my mind
when I read this again was a division of control plane and
data/forwarding plane as known from traditional routing.

The whole forwarding stuff would stay in the kernel, using a simple
routing table (for destination X, send to node Y on interface Z). The
processing of routing messages (OGMs) and creation/update of the routing
table based on the full originator table could be moved to a user space
daemon. Relative to packets of regular data transmissions, routing
messages are not sent and received that often such that processing them
in user space should not hurt performance (very much), especially when
compared to the original implementation of batman-adv in the user space.

Firstly, this approach would improve the architecture by separation of
concerns, which makes it easier to understand, debug and maintain the
code. Secondly, it would get easier to play with / improve the routing
protocol and the metrics if the latter parts were implemented in user
space. And maybe it is indeed possible to make the kernel part of the
code agnostic to the used protocol implementation, which would lead to
the generalized architecture that Hagen envisioned.

- Daniel
