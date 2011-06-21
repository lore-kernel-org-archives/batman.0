Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: Max IP <ipmax2011@hotmail.com>
Date: Tue, 21 Jun 2011 12:51:56 +0000 (UTC)
Message-ID: <loom.20110621T143855-684@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] iperf in 3 node batman-adv network
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

Hi all,

I am implementing the 3 node batman-adv network.

A <---> B <---> C

B is the relay point for communication between A and C.

I have setup the batman-adv 2011.1.0 in all nodes and succesfully I can
communicate and also use avahi between all nodes.

Now I want to calculate bandwidth, jitter and throughput patterns.

To calculate bandwidth, I used 
iperf -s on machine A.

On machine B, I used
iperf -C <ip address of A>
This gave me a bandwidth of 89.1 Mbits/sec

On machine C, I used
iperf -c <ip address of A>
This gave me a bandwith of 89.0 Mbits/sec

Since, there is relay through B to reach C, I was expecting the bandwith from A
to C to be less around half (say 50 Mbits/sec). Is my understanding correct?

Please help me.

Max

