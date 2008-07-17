Message-ID: <487FA7DD.7080607@reglue.org>
Date: Thu, 17 Jul 2008 15:13:17 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
References: <487F60E5.5000003@reglue.org> <487F77DF.8050305@reglue.org>
	<487F9142.9000704@reglue.org>
In-Reply-To: <487F9142.9000704@reglue.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I don't seem to be really running batman.
batman -c -d 1 shows all the nodes
batman -c -d 2 shows there are no gateways although I had specified one.
Apparently, I'm just running an ad-hoc network that's happens to be 
running batman but not using it.

Sorry for the 36000 posts.

batmand -g 5mb eth1 vlan1 #for gw?
batmand -r 3 eth1 #for nodes?
suggestions?

Sorry again.



Don Davis wrote:
> Does batmand 0.3 automatically identify gateways?
> 
> I notice that simply typing
> batmand -g 8 eth1 isn't enough to identify a new gateway.  Do I have to 
> restart batmand on all the nodes?  or specify batmand -p newgwip -r 3 
> eth1 to get them to identify the new gateway?
> 
> I thought there was a way to automatically use a gw if another gw was down?
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

