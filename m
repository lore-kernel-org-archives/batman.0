Message-ID: <48F449AA.9020707@irt.de>
Date: Tue, 14 Oct 2008 09:26:34 +0200
From: Tobias Gieseke <gieseke@irt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Problem with gateway-dhcp
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

Hi there,

I'm using batmand 0.3 rv1057 on six Buffalo WHR-HP-G54 with WhiteRussian 
0.9 Open-WRT. The mesh works fine, even the vis-server does its job. But 
I'm having some Problems with the Gateway:

One of the routers is connected to a LAN with internet access via 
WAN-Port and should act as a gateway for the mesh. When the 
Gateway-Router is started interface gate0 is up and runnig but always 
has the Adress 169.254.0.0. The clients recognize the gateway (entry in 
debugmode 2) but can't get a connection to the internet or the standard 
gateway of the LAN. Clients get IP-adress 169.254.0.x (x starting at 1) 
for their gate0 interface and the gateway is aware of that.

For example (can't remember the exact messages but this was about their 
content):
Message on Gateway, Debugmode3:
"Gateway assigned IP adress 169.254.0.1 to client 192.168.100.2"
Message on Client, Debugmode3:
"Got IP adress 169.254.0.1 from Gateway 192.168.100.1"

According to the batman manual the gateway should act as "a tiny DHCP 
server" but as I always get these 169. adresses I assume it isn't 
running properly. I did not touch the firewall or the iptables because I 
don't know anything about it. There might be some entries which would 
solve the problem, but I could not find those in the manual or the 
mailing-list archive.

As I've found a lot of Debug outputs where the Gateway-DHCP was running, 
I'm sure someone can help me out with that little problem.


wireless greetings,

Tobi


