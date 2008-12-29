Message-ID: <4958C917.7060803@reglue.org>
Date: Mon, 29 Dec 2008 06:56:55 -0600
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Some questions to BATMAN
References: <1396672497@web.de>
In-Reply-To: <1396672497@web.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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


> 1)
> I will build a mesh network.. One of my router is connected to my server with the IP 129.211.186.12. I can't make 
> a traceroute through my router to this server. If I try to make "traceroute 129.211.186.12" from an another router I get the message:
> "PING 129.211.186.12 (129.211.186.12): 56 data bytes
> ping: sendto: Network is unreachable


router 				Server (129.211.186.12)
(batman eth0) <------------------> (batman some wireless device)

On the router, which firmware are you running with Batman?


When you type batmand -c -d 1 on the router /server what do you see?

What does batmand -v show on the router / server?


> I can send ping requests from my server to the router and from the router to the server, but as I said, I can't make a traceroute to the server
> from an another router. My question is, how can I do this ? 
> 
> In OLSR it was not a problem to trace the server through the router. Should I change something in HNA messages ? 
> 
> 2)
> I read the HowTO from Freifunk Leipzig about the configuration of BATMAN, look here http://wiki.leipzig.freifunk.net/BATMAN. How is the configuration
> If I want to run BATMAN in Ubuntu Intrepid? How can I configure the IPTABLES ?
> 

For newer batman and experimental you'll want to open up ports 4305-4307:

iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT




