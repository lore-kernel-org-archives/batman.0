Return-Path: <krzysu@interia.pl>
Message-ID: <4C058626.4060108@interia.pl>
Date: Wed, 02 Jun 2010 00:13:58 +0200
From: Krzysztof Urbas <krzysu@interia.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] building testbed for batman-adv and expected
	performance/throughput
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

Hello,
I am writing my master thesis about performance of BATMAN routing 
protocol and so I build a simple testbed consisting of 4 nodes and 
configured them to run batman-adv. But results of my tests are quite 
strange and I don't really know what should I expected.

 From the beginning:
I have one LaFonera+ and three Asus WL-500g with Atheros interface 
(changed thanks to miniPCI). I have installed Backfire on them and also 
newest kmod-batman-adv-kernelland package. I configured interfaces to 
run batman and all works fine. I configured Fonera as my MeshGateway 
(bridging bat0 with lan and connecting wan port to Internet) and all 
Asus routers as MeshPortals (by bridging bat0 with wan). All 
configuration works fine, each PC connected to MeshPortal (by cable) has 
access to Internet (by MeshGateway). Still the problem is to make this 
network multi hop and make opportunity for a protocol to change routes.
As I can use only 4 nodes (my University provided me only with 3 and 
Fonera is mine) my testbed looks like:

Fonera--------Asus1-------
     \          /          \
      -------Asus2---------Asus3

So there are two two-hop routes from Asus3 to Fonera. I can send you 
images made with vis server.
I tried to lower the txpower (I don't think that it really works) and 
remove the outside antenna but the only one possibility is to put nodes 
away from each other. So Asus3 is in other room. But this complicates 
the measurements. I also have no central place of running tests and 
collecting data so I need to move from one place to another to start 
tests and this is really annoying and there is also dull work to collect 
after all data.
In tests I use ping, iperf and wireshark to record all packets on iperf 
client and server station.

First I test throughput (by iperf) between two direct nodes. TCP results 
was about 9Mb/s-11Mb/s.
Then I used UDP. By trail and error:

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 26000K
[1920] Server Report:
[1920]  0.0-60.2 sec   144 MBytes  20.1 Mbits/sec  13.693 ms 
29775/132678 (22%)
[1920] Sent 132678 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 20000K
[1920] Server Report:
[1920]  0.0-60.0 sec   111 MBytes  15.5 Mbits/sec  1.237 ms 23063/101914 
(23%)
[1920]  0.0-60.0 sec  3 datagrams received out-of-order
[1920] Sent 101914 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 10000K
[1920] Server Report:
[1920]  0.0-60.0 sec  62.0 MBytes  8.66 Mbits/sec  2.840 ms 6823/51023 (13%)
[1920] Sent 51023 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 8000K
[1920] Server Report:
[1920]  0.0-60.1 sec  52.1 MBytes  7.28 Mbits/sec  3.045 ms 3644/40818 
(8.9%)
[1920] Sent 40818 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 5000K
[1920] Server Report:
[1920]  0.0-60.0 sec  33.6 MBytes  4.70 Mbits/sec  0.966 ms 1519/25512 (6%)
[1920]  0.0-60.0 sec  1 datagrams received out-of-order
[1920] Sent 25512 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 4000K
[1920] Server Report:
[1920]  0.0-66.9 sec  23.8 MBytes  2.98 Mbits/sec  1.484 ms   42/17009 
(0.25%)
[1920]  0.0-66.9 sec  3 datagrams received out-of-order
[1920] Sent 17009 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 3000K
[1920] Server Report:
[1920]  0.0-60.1 sec  21.4 MBytes  2.98 Mbits/sec  5.359 ms   69/15308 
(0.45%)
[1920] Sent 15308 datagrams

iperf -c 192.168.20.240 -i 10 -t 60 -u -b 1000K
[1920] Server Report:
[1920]  0.0-60.0 sec  7.11 MBytes   995 Kbits/sec  1.839 ms   29/ 5104 
(0.57%)
[1920] Sent 5104 datagrams

So can I assume that real throughput is about 3Mb/s??
Of course I made a lot of more tests and good rate (about 1%) of packet 
looses was with throughput max 3Mb/s.
So there are differences between TCP and UDP. I know that they work in 
different way but in fact difference in measured throughput is big.
Another thing is that I expected about 20Mb/s as I am using 802.11g.
And this is only one-hop throughput. When I was trying to do two-hop 
tests it occurred that throughput was about 100Kb/s but I think it may 
be because of too much distance to last node (Asus3). But in fact few 
hours earlier I downloaded 20MB file from Internet to pc connected to 
Asus3, the download speed was about 40KB/s as I remember.
All nodes work on channel 1 and the next used channel in neighborhood is 
5. (I use one station with atheros in monitor mode and airodump-ng to 
watch the neighborhood of the lab).


So my questions are:
1. Do you have any suggestions how to build multi-hop testbed in 
laboratory environment (in one room)?
2. How to make testing proces more automatic (some kind of central 
server to run tests and collect data)?
3. How do you do tests of BATMAN? I.e. at BattleMesh? What do you 
measure and how?
4. What throughput should I expect on one-hop and two-hop routes using 
batman-adv and how it looks using layer3 batmand? I assume that it 
should be worse than in layer2..
5. Do you have any other 
suggestions/observations/conclusions/example_data from your tests?
6. Maybe you could give me some other ideas?

Regards
Krzysztof Urbas


----------------------------------------------------------------------
Wakacyjna przygoda czeka! Zgarnij nagrody za 18 000zl!
Sprawdz >>> http://linkint.pl/f2721

