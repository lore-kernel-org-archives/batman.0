Message-ID: <48F5EF69.3080100@irt.de>
Date: Wed, 15 Oct 2008 15:26:01 +0200
From: Tobias Gieseke <gieseke@irt.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Problem with gateway-dhcp
References: <200810141714.47396.lindner_marek@yahoo.de>
In-Reply-To: <200810141714.47396.lindner_marek@yahoo.de>
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

Hi,

thanks for the quick answer. But the iptable command didn't make any 
difference.

I'm able to ping the Gateway (169.254.0.0) from the Client (169.254.0.1) 
but I can not ping any futher i.e. to the LAN. Which leads me to the 
assumption that it is a kind of routing problem in my gateway router.
Here are some facts

-    I'm able to get a connection to the internet (from the client) 
without batman by having an ad-hoc connection        to       the gateway.
-    With batman running I can reach the WAN-Interface (192.168.208.x) 
of the gateway from the client.
-    I can not reach the default-gateway of the LAN (192.168.208.251) 
from the client, but of course from the           gateway.
-    I left the default-gateways in the X-WRT webif of the client (WiFi 
and LAN) blank.

I'll try illustrating the network

LAN                        GW                                  Client   
.208.251----ETH---.208.x
                                .222.1-----WLAN-------222.2
                       169.254.0.0--------TUN------169.254.0.1

I'll have to mention that the LAN is quite big. I had to change the IPs 
for the mesh because someone told the 192.168.100.0 net already exists 
in the LAN (whops!).

Here are some question which will help you start your answer to this 
post ;-)

-Do I have to start the batmand with the WAN-Interface (vlan1)? Meaning: 
batmand -g 10mbit eth1 vlan1
-Do I have to announce the 192.168.208.0/24 net  with batman? (I guess not)
-Do I have to set the DNS-Server manualy or is the gateway acting as DNS

I'm sorry this turns out to be more a routing problem than a batman/mesh 
problem. Hope you help me anyway.

Regards,

Tobi

