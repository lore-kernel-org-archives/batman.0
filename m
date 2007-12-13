From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Some issues in ahdemo and intra-mesh traffic (slow)
Date: Thu, 13 Dec 2007 18:24:52 +0100
References: <001d01c83cdc$a15dcd50$e41967f0$@com>
In-Reply-To: <001d01c83cdc$a15dcd50$e41967f0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712131824.52450.axel@open-mesh.net>
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
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

On Mittwoch 12 Dezember 2007, Predrag Balorda wrote:
> I'm running 5 nodes in 11b ahdemo + vap configuration, everything unbridged
> and on separate subnets, 
the attached dot file is a good idea. It really helps to imaging part of your 
setup - but not all of it :-(

I am not sure which of the annouced HNAs are interfaces and which not. Is each 
batmand running only on one interface? 

If not, do you open multiple vap ahdemo interfaces per node? That might not 
work and I am not sure if it makes sense.

When you say different subnets - what netmasks are used for:
105.0.4.4 105.0.4.5 105.0.3.3 105.0.0.1 105.0.3.2

> After a minute, for example node 5 would stop responding to pings from node
> 3, or node 1 from 4 etc, so basically two-hop nodes, direct neighbours
> always seem ok. 
so I guess 5 is 105.0.4.5 and 3 is 105.0.3.3 ?
Confusing because according to your dot file these two are in fact neighbors, 
maybe via 105.0.2.5 <-> 105.0.2.3

But that might mean, that batman on node *.3 is running on FOUR interfaces : 
*.3.3, *.0.3, *.1.3, *.2.3
And is *.1 running on THREE interfaces *.0.1, *.1.1, *.2.1
So these two nodes are potential neighbors via 3 links ????

If you are meshing via wlan interface and the nodes have only one wlan 
interface then batman should operate only one one interface (vap or not).


> But the funny thing is that hosts on the internet, i.e. 
> traffic that goes to the tunnel always respond to pings. I have tried
> experimenting with one-way tunnel mode but I have been unsuccessfull. Tried
> "--one-way-tunnel 1 --two-way-tunnel 0" on both gw and client batman nodes
> but nothing happens, batmand -c -d 2 always shows 2WT capability for the
> gateway.

Hmm, should work. You are using the same revision on all nodes? Which one?
Note, you can not change one/tow-way-tunnel parameter on the fly. You must 
restart the daemons to change them.
Also note that it takes a while (Duplicate Address Detection) until a 
restarted node is accepted by its neighbors. Afterwards the client node 
should show the 1WT with -d2. Example:

on the GW-node:
~# killall bmxd
~# bmxd -g 5000 --one-way-tunnel 1 --two-way-tunnel 0 eth1:bmx 

Then on the GW-client node ( which is already runnging as
bmxd -r 3 --one-way-tunnel 1 --two-way-tunnel 0 ath0:bmx  )

bmxd -cd3
[   3512899] Drop packet: DAD alert! OGM from 103.131.83.5 via NB 103.131.83.5 
with out of range seqno! rcvd sqno 22828, last valid seqno: 39757 at 3489200!
              Maybe two nodes are using this IP!? Waiting 51 more seconds 
before reinitialization...

...wait 51 more seconds and you'll see...

[   3564050] Drop packet: DAD alert! OGM from 103.131.83.5 via NB 103.131.83.5 
with out of range seqno! rcvd sqno 22862, last valid seqno: 39757 at 3489200!
              Maybe two nodes are using this IP!? Waiting 0 more seconds 
before reinitialization...
[   3565740] Gateway class of originator 103.131.41.5 changed from 0 to 49, 
addr 103.131.41.5, new supported tunnel types -, OWT
[   3566200] Adding default route to 103.131.41.5 (gw_flags: 49, packet_count: 
1, gw_product: 0)
[   3566210] Gateway client - client_to_gw_tun()
[   3566210] Trying to name tunnel to bat0 ... [   3566230] success!
[   3566240] Adding default route via bat0 0.0.0.0 (table 148)

root@ng1e:~# /tmp/bmxd --neta -cbd 2
WARNING: You are using BatMan-eXp 0.3-alpha rv867 (compatibility version 13) !
  Originator         bestNextHop (#/ 50)
=> 103.131.41.5       103.131.83.5 ( 50), gw_class 49 - 4MBit/1024KBit, 
reliability: 0, supported tunnel types -, 1WT
root@ng1e:~# 


> I have tried --dups-ttl 2 --re-brc-delay 15 --window-size 100 (reading from
> bmx tutorial pdf) and it has helped somewhat, but not completely. The
> problem is still there but to a lesser extent.

--dups-ttl 2  --window-size 100 is default since a while.

Since revision 788 (when frame aggregation became default) the --re-brc-delay 
has become irrelevant because the generated frames are delayed anyway.
Sorry, I have to update the document to reflect that.

>
> I don't know whether this is down to ahdemo (maybe Antonio can help here
> with his experience) or down to batman. Any ideas?
>
> Also, is my throughput ok compared to yours? The most I ever got was around
> 450KB/s (roughly 5.5mbits data rate, distance 100m outside with 9dbi omni
> antennas and atheros 5112 - buffalo whr-hp-ag108 at both ends) but the
> 11Mbits evades me - even on a -55 signal and 40 rssi! It really is heart
> breaking, especially seeing such a good signal. Two nodes roughly 300m
> apart get 240KB/s at most. I know better is possible because in ap mode
> with that signal I used to get 1MB/s transfers (that was before I started
> using batman and ahdemo).
I dont know why but ahdemo (or ad-hoc mode in general) is usually less 
performat than managed mode. IMO the ad-hoc implementations never experience 
as much devotion as developers spent in the managed mode. 

ciao,
axel

>
> Best regards,
>
> Pele
>
> P.S.
> digraph topology
> {
> "105.0.4.4" -> "105.0.4.5"[label="1.15"]
> "105.0.4.4" -> "105.0.3.3"[label="1.05"]
> "105.0.4.4" -> "10.0.4.0/255.255.255.0"[label="HNA"]
> "105.0.4.4" -> "10.1.4.0/255.255.255.0"[label="HNA"]
> "105.0.4.4" -> "105.0.2.4/255.255.255.255"[label="HNA"]
> "105.0.3.3" -> "105.0.0.1"[label="1.16"]
> "105.0.3.3" -> "105.0.4.4"[label="1.19"]
> "105.0.3.3" -> "105.0.3.2"[label="1.05"]
> "105.0.3.3" -> "105.0.4.5"[label="1.12"]
> "105.0.3.3" -> "10.0.3.0/255.255.255.0"[label="HNA"]
> "105.0.3.3" -> "10.1.3.0/255.255.255.0"[label="HNA"]
> "105.0.3.3" -> "105.0.0.3/255.255.255.255"[label="HNA"]
> "105.0.3.3" -> "105.0.2.3/255.255.255.255"[label="HNA"]
> "105.0.3.3" -> "105.0.1.3/255.255.255.255"[label="HNA"]
> "105.0.4.5" -> "105.0.4.4"[label="1.27"]
> "105.0.4.5" -> "105.0.3.3"[label="1.03"]
> "105.0.4.5" -> "10.0.5.0/255.255.255.0"[label="HNA"]
> "105.0.4.5" -> "105.0.2.5/255.255.255.255"[label="HNA"]
> "105.0.3.2" -> "105.0.0.1"[label="1.03"]
> "105.0.3.2" -> "105.0.3.3"[label="1.03"]
> "105.0.3.2" -> "10.0.2.0/255.255.255.0"[label="HNA"]
> "105.0.3.2" -> "10.1.2.0/255.255.255.0"[label="HNA"]
> "105.0.3.2" -> "105.0.0.2/255.255.255.255"[label="HNA"]
> "105.0.3.2" -> "105.0.2.2/255.255.255.255"[label="HNA"]
> "105.0.3.2" -> "105.0.1.2/255.255.255.255"[label="HNA"]
> "105.0.0.1" -> "105.0.3.3"[label="1.03"]
> "105.0.0.1" -> "105.0.3.2"[label="1.01"]
> "105.0.0.1" -> "10.0.1.0/255.255.255.0"[label="HNA"]
> "105.0.0.1" -> "10.1.1.0/255.255.255.0"[label="HNA"]
> "105.0.0.1" -> "105.0.2.1/255.255.255.255"[label="HNA"]
> "105.0.0.1" -> "105.0.1.1/255.255.255.255"[label="HNA"]
> "105.0.0.1" -> "0.0.0.0/0.0.0.0"[label="HNA"]
> }
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


