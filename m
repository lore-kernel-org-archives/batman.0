From: Shane Chao <schao@changind.com>
Message-ID: <30773.75.128.50.239.1210728113.squirrel@corp.changind.com>
Date: Tue, 13 May 2008 18:21:53 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Multiple radios to improve throughput
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello,

I have a 3 node mesh network with layout as follows:

   node #1       node #2        node #3
192.168.2.1   192.168.2.5    192.168.2.9

Each node has only one radio and #1 talks to #3 via #2 and vice versa.
If I want to improve the throughput between #1 and #3, logically I would
add another radio to #2 so it can communicate to both #1 and #3
simultaneously w/o having the single radio switching back and forth
between #1 and #3.

However, I ran IPERF between #1 and #3 before and after adding the
second radio to node #2 and the bandwidth didn't really improve.
In my node #2 configuration, I did not bridge the two wifi interfaces so
I have ath0 and ath1 with their own IP addresses.  All three nodes are
configured with the same channel.  My batmand command line for node #2
is:  batmand ath0 ath1.

Can anyone advise me on what I did wrong?

Thanks,
Shane
