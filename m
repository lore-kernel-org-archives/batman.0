Subject: Re: [B.A.T.M.A.N.] Problem with gateway-dhcp
Content-Disposition: inline
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Oct 2008 19:48:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200810161948.46530.lindner_marek@yahoo.de>
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

On Wednesday 15 October 2008 21:26:01 Tobias Gieseke wrote:
> -Do I have to start the batmand with the WAN-Interface (vlan1)? Meaning:
> batmand -g 10mbit eth1 vlan1

No, that is unnecessary. Whenever the batman gateway receives packets for the 
internet it simply adds them to the routing queue. The kernel itself will 
handle further routing.


> -Do I have to announce the 192.168.208.0/24 net  with batman? (I guess not)

Not really unless you want to get a connection to a distinct node other than 
the internet gateway. Remember: you also need a route back if you do so.


> -Do I have to set the DNS-Server manualy or is the gateway acting as DNS

DNS handling is not part of batman. You need to set appropriate DNS entries on 
the clients.


> I'm sorry this turns out to be more a routing problem than a batman/mesh
> problem. Hope you help me anyway.

Sure, no problem. Let us know whether it solves your problem or not.

Regards,
Marek


