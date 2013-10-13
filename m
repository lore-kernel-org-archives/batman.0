Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <525B11F2.5030605@altermundi.net>
Date: Sun, 13 Oct 2013 23:34:42 +0200
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] mad mad batman ...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

While I'm still in Europe I've observed that the network in Quintana has
started performing very poorly today. It was working perfectly fine
until yesterday.

The logs on every router have started showing entries like these:

Oct 13 18:09:43 frigorifico kern.warn kernel: [12018.150000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.040000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.040000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.550000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.550000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.570000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.580000] br-lan:
received packet on bat0 with own address as source address
Oct 13 18:09:46 frigorifico kern.warn kernel: [12021.040000] br-lan:
received packet on bat0 with own address as source address

As you can see there are many per second.


I've pasted a bit of batctl ll batman; batctl log here:

http://pastebin.com/HX1LBPK4


...it's only showing the "originator packet from myself" lines and one
line before. (the sample is less than 5 secs of logs)

Every node I checked is showing the same.


Last time this happened it was due to a router that had been affected by
a nearby lightning bolt. The switch went crazy.
It took a while to detect it and the network was 15 nodes big. Now it's
40 and we are quite far away :)


If anyone has an idea of how to better test where the problem is
originated, I'll be glad to hear it. Also if any batman devel wishes to
log in to the net to check first hand, just let me know.


Cheers!
Nico


PS: batman version is 2012.4
