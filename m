From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] deactivated/reenabled interfaces needs batmand
	restart
Date: Mon, 5 May 2008 19:59:24 +0200
References: <481F3DD0.8060506@ddmesh.de>
In-Reply-To: <481F3DD0.8060506@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805051959.24542.axel@open-mesh.net>
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
I am aware of that problem and plan to port the interface-watchdog idea from 
batman-0.3 rv970/971 also to batman-exp. Just give me some time...

ciao,
axel


On Montag 05 Mai 2008, Freifunk Dresden wrote:
> Hello again,
>
>
> I'm running batman-experimental rev1023. Batman is running with two
> interfaces, one for wifi and one for backbone. The backbone interface is
> created by tincd a vpn deamon. If I have an active vpn connection batman
> recognizes the nodes at the other end of this connection. When the
> connection dead because the client has closed the vpn connection, batman is
> still working correctly.
>
> The problem occurres when the client re-creates the vpn connection. Batman
> ignores the interface. the log does not show incomming packages from the
> vpn-client. If I just restart batmand with the two interfaces, batman shows
> the packets within seconds and the node is reachable.
>
> Is there a way that the inactive interfaces are reactivated and used
> automatically?
>
> /Stephan
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


