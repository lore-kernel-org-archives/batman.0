Message-ID: <2bda28cd0707080503l202ce059j335115cfd2fcc52e@mail.gmail.com>
Date: Sun, 8 Jul 2007 14:03:38 +0200
From: "Stefano Scipioni" <stefano@one-b.it>
Sender: scipio.it@gmail.com
Subject: Re: [B.A.T.M.A.N.] originator timeout
In-Reply-To: <200707081237.14412.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
	<200707081043.31142.axel@open-mesh.net>
	<2bda28cd0707080231g763465b3la57e0dbbf1d966ab@mail.gmail.com>
	<200707081237.14412.axel@open-mesh.net>
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

> according to the log file node2 behaves correct (despite the thing that node2
> generates a route to node6 within the first two seconds). At some point in
> time node2 purges node6 from its routing table because it could never
> validate the link between interface 10.1.1.1 and 10.1.1.33 as a bidirectional
> link. Can you generate another set of log files at node2 and node6
> simultaneously? So that we can identify whether node2 simply does not hear or
> node6 never re-broadcasts any originator messages (OGMs) send by node2.

They are in http://wifi.one-b.it/download/

> Hmm... actually another thing but:
> I see that on node2 the netmask and broadcast addresses for the two interfaces
> used by batman are different. I've never tried nor considered it that way -
> might work - but it is (imho) not the intended setup. With batman you
> can/should use the same netmask (and broadcast addresses) for all interfaces
> participating in the batman mesh. Otherwise you can get topology
> fractionation with which the protocol can not deal with automatically.
> Perhaps you can try to give ALL interfaces a 255.255.255.0 netmask and a
> 10.255.255.255 broadcast address?

I have disabled eth0.0 (batman only on interface wl0) on node2 and
same behavior: after a while route to node6 disappear.

I make another test with only 3 nodes: node2 with one interface (wl0),
node6 and node3



node2 (10.1.1.1) ------ node6 (10.1.1.33)
          \
           \--- node3 (10.1.1.10)

After 2 minutes with "batmand -g 0 -r 2 -d 1 wl0" on all 3 nodes:

node2
10.1.1.10             10.1.1.10 ( 67):       10.1.1.10 ( 67)
10.1.1.33             10.1.1.33 ( 21):       10.1.1.33 ( 21)

node6
10.1.1.10              10.1.1.1 ( 66):        10.1.1.1 ( 66)
10.1.1.1               10.1.1.1 (120):        10.1.1.1 (120)

node3
10.1.1.33              10.1.1.1 ( 20):        10.1.1.1 ( 20)
10.1.1.1               10.1.1.1 (121):        10.1.1.1 (121)

I suspect that batman does not hear some packets, maybe for wireless problems?
