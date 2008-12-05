From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Want to count the number of nodes connecting to a
	batman gateway
Date: Fri, 5 Dec 2008 15:46:36 +0800
References: <1228438302.11385.65.camel@desiree>
In-Reply-To: <1228438302.11385.65.camel@desiree>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812051546.36926.lindner_marek@yahoo.de>
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

On Friday 05 December 2008 08:51:42 david johnson wrote:
> I'm busy trying to adapt batman-exp to do some fair bandwidth allocation
> and to do this I need each tunnel from a client to be shown as a
> seperate vpn.  Or I need a way to count the number of nodes connecting
> to the gateway

The batgat kernel module has that feature exposed via /proc but I have no idea 
what bmx can do for you.

Regards,
Marek

