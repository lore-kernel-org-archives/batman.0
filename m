Subject: Re: [B.A.T.M.A.N.] Problem with gateway-dhcp
Content-Disposition: inline
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 14 Oct 2008 17:14:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200810141714.47396.lindner_marek@yahoo.de>
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

> For example (can't remember the exact messages but this was about their
> content):
> Message on Gateway, Debugmode3:
> "Gateway assigned IP adress 169.254.0.1 to client 192.168.100.2"
> Message on Client, Debugmode3:
> "Got IP adress 169.254.0.1 from Gateway 192.168.100.1"

so far, everything as expected. 


> According to the batman manual the gateway should act as "a tiny DHCP
> server" but as I always get these 169. adresses I assume it isn't
> running properly. I did not touch the firewall or the iptables because I
> don't know anything about it. There might be some entries which would
> solve the problem, but I could not find those in the manual or the
> mailing-list archive.

Batman has its internal DHCP server for the gateway tunneling via the gate0 
interfaces. This address space was chosen to avoid configuration as it should 
not be in use. 

You could try to ping the gateway via the virtual address (169.254.0.0) to 
check whether the tunnel connection works or not. If you run into a timeout 
you should disable the firewall on the gateway. Ping again to feel the 
difference.  ;-)

May be you are lacking the the masquerading rules on gate0. Issue:
iptables -t nat -I POSTROUTING -o gate0 -j MASQUERADE
on the client and on the gateway.

Regards,
Marek


