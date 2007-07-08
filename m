Message-ID: <2bda28cd0707080231g763465b3la57e0dbbf1d966ab@mail.gmail.com>
Date: Sun, 8 Jul 2007 11:31:47 +0200
From: "Stefano Scipioni" <stefano@one-b.it>
Sender: scipio.it@gmail.com
Subject: Re: [B.A.T.M.A.N.] originator timeout
In-Reply-To: <200707081043.31142.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
	<200707081043.31142.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Sorry, net scheme without wrap is:

 node1           node2
 10.0.1.1 ---| 10.0.1.3 |       node3         node4
                 | 10.1.1.1 |--- 10.1.1.10 --- 10.1.1.13
                              \    \          \              \
                               \    \--------  \ --------10.1.1.20    node5
                                \
                                 \--10.1.1.33 node6


2007/7/8, Axel Neumann <axel@open-mesh.net>:
> Hi Stefano
>
> one observation according to your log files:
> node2 (interface 10.1.1.1) never gets any of its own originator messages back
> (rebroadcasted) from node6. Despite node2 receives OGMs from node6. I assume
> that node6 simply can not hear node2 (and maybe also others) and therefore
> node6 can not rebroadcast OGMs from node2 (which is necessary for the
> bidirectional link check). One reason for that might be, that the netmask and
> broadcast address of the (alias) interfaces batman is using on node2 and
> node6 are not identical. can you check that?

node2:
  eth0.0  inet addr:10.0.1.3  Bcast:10.0.1.255  Mask:255.255.255.0
  wl0 inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0

node6:
  wl0 inet addr:10.1.1.33  Bcast:10.1.1.255  Mask:255.255.255.0

node2 and node6 speak very well in wireless channel
