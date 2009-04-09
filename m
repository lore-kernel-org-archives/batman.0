From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 9 Apr 2009 18:00:13 +0800
References: <6.2.5.6.2.20090409001324.0390cd00@gmail.com>
In-Reply-To: <6.2.5.6.2.20090409001324.0390cd00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904091800.21893.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] default routes not set
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


Hi,

> Gateway client - got IP (169.254.0.1) from gateway: 192.168.100.2
> Adding default route via gate0 (table 68)

> When I run route -n on the ar430w, there's no default route set.  I
> manually ran:
> route add default gw 169.254.0.1

so far everything is correct but the deprecated "route -n" command shows you 
only one routing table. As the log indicates the default route went into table 
68. You can see it using:

ip route ls table 68

More information regarding the routing tables can be found here:
http://www.open-mesh.net/wiki/RoutingVodoo


> Next I tried to ping the outside world on the ar430w but it gets no
> where.  Any ideas?

You need to NAT on your gateways (wrt54gl) internet interface. 
iptables -t nat -I POSTROUTING -o $your_wan_if -j MASQUERADE

Depending on the batman version you use it might be required to NAT on the 
gate0 interface on the client side in a similar fashion. With batman version 
0.3.2 its not necessary anymore.

Regards,
Marek

