Message-ID: <43619.85.41.146.90.1190473783.squirrel@krisma.oltrelinux.com>
Date: Sat, 22 Sep 2007 17:09:43 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] 0.3 alpha (today revison)
Reply-To: Antonio <Anselmi@krisma.oltrelinux.com>,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

Hi,
since you use mipsel device I think these mips log could be of more help
in fixing mips/mipsel bug in 0.3 branches (alpha and experimental).

Very simple scenario:
[client 5.1.7.251]----mesh----[gateway 5.1.7.254]
all node running 0.3 apha (the today latest rv6300.3-alpha)

##### d3 level debug at client
...
1) Adding throw route to 169.254.0.0/16 via 0.0.0.0 (table 68 - eth0:1)
2) Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
3) Adding throw route to 10.7.251.128/25 via 0.0.0.0 (table 68 - ath2)
4) Adding throw route to 5.0.0.0/8 via 0.0.0.0 (table 68 - ath0)
5) Adding throw route to 10.7.251.0/25 via 0.0.0.0 (table 68 - br0)
6) Adding route to 5.1.7.254 via 0.0.0.0 (table 66 - ath0)
7) Found new gateway 5.1.7.254 -> class: 49 - 4MBit/1024KBit

# after sliding windows if filled in by validate OGMs

8) Adding default route to 5.1.7.254 (gw_flags: 49, packet_count: 64,
gw_product: 0)
9) Adding default route via tun0 (table 68)

# ...ah this is great! now trying to ping outside mesh

10) Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
11) Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired

# client can't exit off mesh

##### d3 level debug at gateway
...
1) gateway class: 49 -> propagating: 4MBit/1024KBit
2) Error - can't add route to 0.0.254.169/24 via 0.0.0.0 (table 254):
Invalid argument

# (don't know why previous error)
# ...gateway is learned about client wants ping outside mesh

3) Gateway - assigned 1.0.254.169 to client 5.1.7.251
4) Error - got packet from unknown client: 5.1.7.251 (virtual ip 1.0.254.169)

What I see:

FIRST BUG (?)
Client prepare route to 169.254.0.0/16 in table 68 (line 1-log_client)
while gateway arrange a 169.254.0.0/24 space (line 2-log_gateway): suffix
bits differs (16 bit netmask client side vs 24 bit netmask server side)

SECOND BUG
Client wants ping outside mesh and receives a *little endian formatted* IP
1.0.254.169 (line 10-log_client and line 3-log_gateway) which is out of
previous arrangement (this IP address is malformed by gateway).

Client tryes sending outgoing packet to gateway

Gateway receives client' outgoing packect but doesn't recognize IP source
address (line 4-log_gateway) expecting one in 0.0.254.169/24 space. Thus
gateway informs client about wrong IP, so client pinging fails (line
11-log_client).

Hopeing this will be usefull... I know today weekend begins :)


--
Antonio


