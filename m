Message-ID: <46B4F1CB.6020008@ddmesh.de>
Date: Sat, 04 Aug 2007 23:38:19 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
References: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
	<200708041143.37165.axel@open-mesh.net>
In-Reply-To: <200708041143.37165.axel@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1
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

> that should not be the case! You say even with the stable connection
to your
> near-by WRT that the HNA is added/deleted every 1 - 5 SECONDS ! And
even more
> often at the distant WRT (so added/deleted every SECOND ?).
> Can you describe the setup and parametrization in more detail?

I have a Linux and two wrt's using rv495. the route is added and deleted
at same time as the message is printed.

linux: batmand -g 4 -a 141.56.0.0/16 wlan0
wrt-near:  batmand -r 2 eth1
wrt-far:  batmand -r 2 eth1


wrt-far: "-d3" add/del freq differs from 5 to 60 seconds
---------------
Gateway client - got IP (169.254.0.1) from gateway: 10.12.0.1
Adding route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Deleting route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Adding route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Deleting route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Adding route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Deleting route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Adding route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Deleting route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Gateway client - releasing unused IP after timeout: 169.254.0.1
Adding default route via tun0 (table 67)
Adding route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Deleting route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Gateway client - got IP (169.254.0.1) from gateway: 10.12.0.1
Adding route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)
Deleting route to 141.56.0.0/16 via 10.12.10.17 (table 65 - eth1)

root@10-1:~# ip rule;ip route list table bat_hna
0:      from all lookup local
6599:   from all to 141.56.0.0/16 lookup bat_hna
6600:   from all to 10.0.0.0/8 lookup bat_route
6700:   from all iif lo lookup bat_default
6701:   from 127.0.0.0/8 lookup bat_default
6702:   from 192.168.1.0/24 lookup bat_default
6703:   from 192.168.178.0/24 lookup bat_default
6704:   from 172.16.0.0/16 lookup bat_default
6705:   from 172.16.0.0/16 lookup bat_default
10000:  from all to 192.168.0.0/16 lookup main
10001:  from all to 172.16.0.0/12 lookup main
10002:  from all to 10.0.0.0/8 lookup main
10002:  from all to 104.0.0.0/8 lookup main
10003:  from all lookup gateway
32766:  from all lookup main
32767:  from all lookup default
141.56.0.0/16 via 10.12.10.17 dev eth1  proto static
root@10-1:~# ip rule;ip route list table bat_hna
0:      from all lookup local
6600:   from all to 10.0.0.0/8 lookup bat_route
6700:   from all iif lo lookup bat_default
6701:   from 127.0.0.0/8 lookup bat_default
6702:   from 192.168.1.0/24 lookup bat_default
6703:   from 192.168.178.0/24 lookup bat_default
6704:   from 172.16.0.0/16 lookup bat_default
6705:   from 172.16.0.0/16 lookup bat_default
10000:  from all to 192.168.0.0/16 lookup main
10001:  from all to 172.16.0.0/12 lookup main
10002:  from all to 10.0.0.0/8 lookup main
10002:  from all to 104.0.0.0/8 lookup main
10003:  from all lookup gateway
32766:  from all lookup main
32767:  from all lookup default
root@10-1:~#
-----------------
>
> Do you really think of a human-readable ascii string that you want to
flood
> with an arbitrary length over the mesh with content like: "Hello take
a cool
> beer and see my fancy cool movie torrent-server at 105.10.bla.bub".
Iam not
> against such communication but...
>
> default OGM size: 10 bytes
> OGM + HNA size: 15 bytes
> OGM + example-TLV-ascii message: 95 bytes
>
> ... I am a bit scared about the amount of data which would be flooded
over the
> mesh (at every originator interval) with no means for stopping the
sources.
>
> Therefore i asked if anybody knows a decent forman for describing such
> services (preferably in a short and machine readable notation).
> Perhaps another approach is to just have a kind of key-to-service list
> (similar to /etc/services with a 16bit key) just roughly indicating
the type
> of offered service together with another port/ip  where further
information
> (of arbitrary length) about the indicated service can be retrieved.
> This would also allow to outsource part of the service-discovery to
another
> daemon.
>
>
> greetings,
> axel
I have read the previous thread messages that talk about dns. I'm not
firm with this. But I think that the protocol offers a good way to
optimize flooding messages and avoids any loops. The network size is
defined by ttl of the OGMs and so it makes sence to use the knowledge
of this network size to send also other messages. any external process
does not know this and would over flood the network. If you are using a
passive way, where the nodes ask a server to retrieve such messages,
then in a decentralized network at least this server or serveral server
needs to be known. For this you will need such a message flooding
solution anyway.
The protocol should be flexible and provide such a feature no matter if
anyone uses it. Any how is providing a firmware with batmand, should
know what he is doing.

Cheers
 Stephan



