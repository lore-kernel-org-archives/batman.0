From: Axel Neumann <axel@open-mesh.net>
Date: Tue, 12 Jun 2007 14:45:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706121445.40692.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N.-Release-Party
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

B.A.T.M.A.N.-Release-Party Wednesday 20. june at the C-Base in Berlin.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The B.A.T.M.A.N.-developer team would be happy to celebrate with YOU the 0.2 
release of B.A.T.M.A.N. at the C-Base (in Berlin). FYI, there will also be a 
free barrel of cool beer waiting to be flushed.
Version 0.2 can reasonably be called stable now. It works quite performant, 
supports multiple interfaces, has a low CPU-load, a robustly working 
algorithm underneath, and autonomously negotiates UDP-Tunnels to GWs  which 
ultimately enables long-term and stable internet connections.
A number of users reported quite excitedly about the amazing experiences they 
made with this protocol. Well, we want to stay neutral so join in to hear 
them and try batman for yourself.

Currently B.A.T.M.A.N is available for Linux only. The ports for Mac OS-X and 
BSD have fallen asleep and are waiting for a diligent bee ... Maybe there 
will once also exist a windows port.

Many thanks to all the people who helped to realize this in such a short 
amount of time. 

Merchandizing
^^^^^^^^^^^^^^^^^^^

We are thinking about printing further T-shirts with the B.A.T.M.A.N.-Logo (as 
you can see on http://open-mesh.net/batman ) and sell them at the cost of 
expenses. Unfortunately the price is not clear by now but will be about or 
less than 15 Euro. If you are interested please send a mail with your size 
and the limit you are willing to pay.


Considerations for the parallel operation of OLSR and B.A.T.M.A.N.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In Berlin we are now facing a phase in which both routing protocols will
be used in parallel. Currently we are aware of one issue where this can cause 
problems. This is in case of OLSR-Internet traffic passing a dual-stack (OLSR 
and B.A.T.M.A.N.) node where the B.A.T.M.A.N daemon is configured for 
tunneled GW selection. Then each OLSR-towards-internet packet will be 
magically caught and warped to the currently selected (and maybe several hops 
away) B.A.T.M.A.N. GW. where the packets pop-up again and follow their usual 
path through the internet to their final destination. This has caused 
confusion since also programs like traceroute do not show the intermediate 
hops which the packet has passed (tunnelled)  between the related 
B.A.T.M.A.N. node and the GW.

This is because such a dual-stack mesh node (where the B.A.T.M.A.N daemon is 
configured for tunneled GW selection) consequently has two default routes. 
One due to OLSR and another due to B.A.T.M.A.N.. The thing is, that both are 
ending up in the same routing table and one of them (the latter) has a higher 
priority than the other. So every packet passing along with a destination 
address matching only the default entry of the routing table will end up in 
the tunnel to the currently selected B.A.T.M.A.N. GW. 

The Internet-GW selection mode of B.A.T.M.A.N. is optional and should be 
disabled or used with care especially on nodes with a dedicated RF-postion 
(and such used by many others as an intermediate hop) like churches and other 
high buildings. Enduser using Notebooks or PDAs should be able to use this 
feature without causing trouble.

 
Outlook
^^^^^^^^^^^

In order to make the parallel deployment of both protocols even more smoothly, 
a number of new features have found their way into 0.3. Then it will also be 
possible to maintain and use a the OLSR and the B.A.T.M.A.N. default route in 
parallel.

Therefore we will also release the first version of the upcoming B.A.T.M.A.N. 
generation (0.3 alpha).

At the same time we already began working on the next generation of 
B.A.T.M.A.N. which will be called B.A.T.M.A.N. Advanced. It works on Layer 2 
and creates a virtual network switch of all nodes participating. It offers a 
bunch of new possibilities and features which wait for you to be explored. To 
offer you a stable plattform you can experiment with we will release 0.1 
alpha. We will also provide a set of tools (the B.A.T.M.A.N. toolchain - 
battool) to bring you in the position to observe the magic and to debug your 
setup or our daemon.  ;-)

see you june 20th,
the B.A.T.M.A.N. development team
