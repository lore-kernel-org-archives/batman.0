Message-ID: <48F886F6.5030603@irt.de>
Date: Fri, 17 Oct 2008 14:37:10 +0200
From: Tobias Gieseke <gieseke@irt.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Problem with gateway-dhcp
References: <200810161948.46530.lindner_marek@yahoo.de>
In-Reply-To: <200810161948.46530.lindner_marek@yahoo.de>
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

Hi again,

it is still not running :-( but I was able to specify the problem in 
more detail.
First a short summary of what the problem is:
I got one client connected to a gateway over batman-mesh. Tunnel (gate0) 
is established an has assigned correct IP-Adresses. Problem: I am able 
to ping the gateways WAN-Interface, but I am not able to ping the 
Standard-Gateway of the WAN. The ping to the WAN-Gateway is not leaving 
the WAN-Interface of the gateway (I sniffed that with Wireshark).

Strange: When I'm setting up the Network without Batman (setting a fixed 
gateway on the client) I can ping the Gateway in the WAN. As soon as I 
start the batmand with -g on the Mesh-Gateway the ping stops. Besides, 
the ping does not end up in an error-message it just doesn't answer.

In my last test I "replaced" the WAN (which was actually our 
company-LAN) with another SoHO-Router. So the WAN is now represented by 
this Router. I did this to aviod complications with already assigned 
networks.

Still a routing problem, but any kind of help would be nice.
Thanks!

Tobi






