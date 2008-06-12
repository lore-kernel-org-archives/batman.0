From: Shane Chao <schao@changind.com>
Message-ID: <30352.75.128.50.239.1213242809.squirrel@corp.changind.com>
In-Reply-To: <48448358.4070505@changind.com>
References: <48448358.4070505@changind.com>
Date: Wed, 11 Jun 2008 20:53:29 -0700 (PDT)
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

Hi all,

I ran another iperf test with the following scenario below:

node 1          node 2          node 3
------          ------          ------
  ath0 <--ch 1--> ath0
                  ath1 <--ch 11-> ath0

Both nodes 1 and 3 are still using WRAP board w/ 266MHz cpu with single
radio inside but this time I replaced node 2 with a desktop PC w/ 1GHz cpu
and 2 radios.  The PC is running Ubuntu Linux and Madwifi drivers.  The
result of iperf from node 1 to 3 isn't any better than when node 2 was
using WRAP w/ 2 radios.  I was expecting higher throughput from node 1 to
3 due to a faster cpu on node 2 to forward packets between the 2 radios
inside but I am now confused.

I am currently not running Batman and instead manually creating the route
table in trying to isolate the throughput problem.

Maybe there is some configuration parameters that need to be set on node
2?  Any advice would be appreciated.

Thanks,
Shane
