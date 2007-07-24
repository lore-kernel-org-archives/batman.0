From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Multiple connections / prioritiy
Date: Tue, 24 Jul 2007 12:54:54 +0200
References: <20070723140744.ozvor890jy5cockg@webmail.ddmesh.de>
	<46A591C0.8090009@poelzi.org>
In-Reply-To: <46A591C0.8090009@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707241254.54152.axel@open-mesh.net>
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

Hi

On Tuesday 24 July 2007 07:44, Daniel Poelzleithner wrote:
> Freifunk Dresden wrote:
> > If I have multiple connections between two nodes, is there a way to
> > setup the quality or
> > priority of those connection?
>
> Same goes for Leipzig, we have our vpn[1,2].leipzig.freifunk.net nodes.
> I thought about this problem a lot and the simplest solution would be to
> simply drop like 9 of 10 batman packets on the outgoing vpn interface.
> this is like a olsr multiplicator of 10 with the advantage that it saves
> bandwith.
on a specific interface
a) you man drop received originator messages (OGMs) which does not really 
reducing the traffic or
b) suspend the sending of OGMs 

However, dropping or suspending should only be applied to OGMs from 
non-neighboring nodes, otherwise it also affects the bidirectional link check 
which would result in a confusing side-effect, marking even more packets as 
invalid.

In parallel it might be beneficial to configure different originator intervals 
for particular interfaces. For example for a vpn connection a very large 
originator interval (with a small TTL would be sufficient) since its 
link-quality is not supposed to change anyway (and causing less traffic to 
the vpn).

/axel
