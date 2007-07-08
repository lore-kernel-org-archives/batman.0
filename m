From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] originator timeout
Date: Sun, 8 Jul 2007 17:34:07 +0200
References: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
	<200707081237.14412.axel@open-mesh.net>
	<2bda28cd0707080503l202ce059j335115cfd2fcc52e@mail.gmail.com>
In-Reply-To: <2bda28cd0707080503l202ce059j335115cfd2fcc52e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707081734.08354.axel@open-mesh.net>
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

Hello Stefano,

On Sunday 08 July 2007 14:03, Stefano Scipioni wrote:
> > according to the log file node2 behaves correct (despite the thing that
> > node2 generates a route to node6 within the first two seconds). At some
> > point in time node2 purges node6 from its routing table because it could
> > never validate the link between interface 10.1.1.1 and 10.1.1.33 as a
> > bidirectional link. Can you generate another set of log files at node2
> > and node6 simultaneously? So that we can identify whether node2 simply
> > does not hear or node6 never re-broadcasts any originator messages (OGMs)
> > send by node2.
>
> They are in http://wifi.one-b.it/download/
The two log files from the above url say:

for node2:
[    109405] Originator list 
[    109405]   Originator           Router (#/128):    Potential routers 
[    109405] 10.1.1.20             10.1.1.20 ( 94):       10.1.1.20 ( 94)       10.1.1.10 ( 10) 
[    109406] 10.1.1.13             10.1.1.20 ( 59):       10.1.1.20 ( 59)       10.1.1.10 ( 29) 
[    109406] 10.1.1.10             10.1.1.10 (103):       10.1.1.10 (103)       10.1.1.20 (  1) 
[    109406] 10.1.1.33             10.1.1.33 ( 94):       10.1.1.33 ( 94) 
[    109406] 10.0.1.1               10.0.1.1 (110):        10.0.1.1 (110) 

and node6
[    113951] Originator list 
[    113951]   Originator           Router (#/128):    Potential routers 
[    113952] 10.1.1.20              10.1.1.1 ( 90):        10.1.1.1 ( 90) 
[    113952] 10.1.1.13              10.1.1.1 ( 61):        10.1.1.1 ( 61) 
[    113953] 10.1.1.10              10.1.1.1 ( 98):        10.1.1.1 ( 98) 
[    113953] 10.0.1.3               10.1.1.1 ( 99):        10.1.1.1 ( 99) 
[    113953] 10.0.1.1               10.1.1.1 ( 99):        10.1.1.1 ( 99) 
[    113954] 10.1.1.1               10.1.1.1 (100):        10.1.1.1 (100) 
[    113954] ---------------------------------------------- END DEBUG 

So after ca 110 seconds everything seems perfect, none of the route entries is about to be purged 
and (not like in your previous log file) node 2 received a total of 84 self-initiated 
(and re-broadcest from node6) back OGMs from node6.

> I have disabled eth0.0 (batman only on interface wl0) on node2 and
> same behavior: after a while route to node6 disappear.

Thats strange, can you specify more precisely in which sense it dissapears?
Is it just the route (route -n) or does it also dissapear from the debug level 
(batmand -c -d 1 -b)?

>
> I make another test with only 3 nodes: node2 with one interface (wl0),
> node6 and node3
>
>
>
> node2 (10.1.1.1) ------ node6 (10.1.1.33)
>           \
>            \--- node3 (10.1.1.10)
>
> After 2 minutes with "batmand -g 0 -r 2 -d 1 wl0" on all 3 nodes:
>
> node2
> 10.1.1.10             10.1.1.10 ( 67):       10.1.1.10 ( 67)
> 10.1.1.33             10.1.1.33 ( 21):       10.1.1.33 ( 21)
>
> node6
> 10.1.1.10              10.1.1.1 ( 66):        10.1.1.1 ( 66)
> 10.1.1.1               10.1.1.1 (120):        10.1.1.1 (120)
>
> node3
> 10.1.1.33              10.1.1.1 ( 20):        10.1.1.1 ( 20)
> 10.1.1.1               10.1.1.1 (121):        10.1.1.1 (121)
>

This, indeed looks like an 
almost perfect link from node2 (10.1.1.1) -> node6 (10.1.1.33) and 
a rather lossy link from node6 (10.1.1.33) -> node2 (10.1.1.1)
Perhaps the same reason as in your first log file from node 2. 
However, the lines given above do not reveal any further secrets.
If the link is bidirectional using a grep on the traced node2-leve-4-debug like:
grep "NB: 10.1.1.33, IF: wl0 10.1.1.1 (from OG: 10.1.1.1," node2
should show you the moments from node2's point of view when it 
was identified bidirectional. This should happen somhow regularly.

Also FYI, there is a quite useful pearl script which can help in analyzing 
debug-level-4 outputs available at:
https://dev.open-mesh.net/svn/batman/trunk/batman-debug4.pl

> I suspect that batman does not hear some packets, maybe for wireless
> problems? _______________________________________________

Maybe - many wlan cards have problems with the ad-hoc mode. Iam often 
experiencing problems with atheros cards which out of the sudden 
cease sending for a while. 
But then, the problem should be the same for olsr. If you want to verify that, 
you can easily run both protocols in parallel (and use alias interfaces for batman)
and then always have a way to instantly compare between the two protocols.

much luck...

ciao,
axel 



