From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Re: Batman problem with tun0
Date: Fri, 6 Jul 2007 09:59:54 +0200
References: <200707051000.l65A02Y3020074@open-mesh.net>
	<468DEE47.6080106@fokus.fraunhofer.de>
In-Reply-To: <468DEE47.6080106@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707060959.54813.lindner_marek@yahoo.de>
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

> thanks for replying so fast. Unfortunately the reason isn't the blocked
> tcp-port, I tested it after I shutdown the firewall on each node with
> the same result as you can see above. Is there something else I can do?

Sure. You can debug this by using tcpdump. Use the following call to see the 
batman TCP and UDP gateway connections: tcpdump -ni <your_wifi_dev> port 1967
Best would be to send it to me, so that I can say a few words about your 
problem.  :-)

Regards,
Marek
