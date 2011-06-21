Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <loom.20110621T143855-684@post.gmane.org>
References: <loom.20110621T143855-684@post.gmane.org>
Date: Tue, 21 Jun 2011 17:48:09 +0200
Message-ID: <BANLkTikvGt5ADb7fjJQVvTd8xNU7wtBRQg@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] iperf in 3 node batman-adv network
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

2011/6/21 Max IP <ipmax2011@hotmail.com>:
> Hi all,
>
> I am implementing the 3 node batman-adv network.
>
> A <---> B <---> C
>
> B is the relay point for communication between A and C.
>
The connection is 802.11 or ethernet? Does B have two separate interfaces
to comunicate with A and B and partecipating to the mesh?

> I have setup the batman-adv 2011.1.0 in all nodes and succesfully I can
> communicate and also use avahi between all nodes.
>
> Now I want to calculate bandwidth, jitter and throughput patterns.
>
> To calculate bandwidth, I used
> iperf -s on machine A.
>
> On machine B, I used
> iperf -C <ip address of A>
> This gave me a bandwidth of 89.1 Mbits/sec
>
> On machine C, I used
> iperf -c <ip address of A>
> This gave me a bandwith of 89.0 Mbits/sec
>
> Since, there is relay through B to reach C, I was expecting the bandwith from A
> to C to be less around half (say 50 Mbits/sec). Is my understanding correct?

From what you are saying I deduce that you are using ethernet cables.
So 89 Mb/s is a perfectly valid result since ethernet is full duplex, this
mean that node B can receive and send packet at the same time (this is
not possible in wireless network).

>
> Please help me.
>
> Max
>
>



-- 
Daniele Furlan
