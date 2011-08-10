Return-Path: <ipmax2011@googlemail.com>
MIME-Version: 1.0
Date: Wed, 10 Aug 2011 12:43:58 +0200
Message-ID: <CAJA-1LiiLCJ4D2s9ubXFRmyu_TvgiK51PAzaOHNMwP3M-KeeEg@mail.gmail.com>
From: Max Ip <ipmax2011@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Batman CPU usage
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

Hi folks,

I am checking the efficiency of my batman-adv network in terms of CPU
usage. My system consists of batman-adv 2011.1.0 enabled 3 laptops.

A-----B------C

There is no direct contact between A and C. So, node B is the relaying
node. The systems cpu configuration in all nodes are:

In A : cpu MHz = 2000
In B : cpu MHz = 1000
In C : cpu MHz = 800

When I checked the CPU usage at different nodes (using netperf), I
found the following results.


TCP CPU utilization send local from C to B = 5.84%
TCP CPU utilzation send local from B to A = 2.37%
TCP CPU utilization from C to A (2-hop environment) = 9.19%

UDP CPU utilization send local from C to B = 0.75%
UDP CPU utilization send local from B to A = 3.85%
UDP CPU utilization send local from C to A (2-hop environment)  = 4.31%

My questions are why is the CPU utilization so less for UDP case?  In
case of TCP cpu utilization, isn't 9.19% a very high value for a
system consisting of just 3 nodes?

Since, B is acting as a relaying node to relay the network from C to
A, what is its impact on total CPU usage?

Thanks

Max
