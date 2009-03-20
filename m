Message-ID: <49C40762.3050109@java-system.com>
Date: Fri, 20 Mar 2009 22:15:14 +0100
From: marco tozzini <lists@java-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] What do you think of this result?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

This is my typical view, of my batman fonera stations, from my batman 
laptop (with atheros wifi pcmcia)

  Originator  (#/255)         Nexthop [outgoingIF]:   Potential nexthops 
... [B.A.T.M.A.N. 0.3, MainIF/IP: wlan1/192.168.2.65, UT: 0d 0h36m]
192.168.2.200   (245)   192.168.2.200 [     wlan1]:   192.168.2.200 
(245)   192.168.2.203 (211)   192.168.2.201 (244)
192.168.2.201   (253)   192.168.2.201 [     wlan1]:   192.168.2.201 
(253)   192.168.2.200 (234)   192.168.2.203 (209)
192.168.2.203   (233)   192.168.2.200 [     wlan1]:   192.168.2.203 
(231)   192.168.2.200 (233)   192.168.2.201 (231)

from my laptop
fping -c 1000 -g 192.168.2.200/30

and this is the results
192.168.2.200 : xmt/rcv/%loss = 1000/928/7%, min/avg/max = 1.23/2.04/92.8
192.168.2.201 : xmt/rcv/%loss = 1000/759/24%, min/avg/max = 1.28/3.11/27.5
192.168.2.203 : xmt/rcv/%loss = 1000/766/23%, min/avg/max = 1.33/3.36/38.7

I don't think it's normal, isn't it?

Ciao
Marco

