Return-Path: <andrew@lunn.ch>
Date: Wed, 7 Jul 2010 12:50:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100707105058.GD18453@lunn.ch>
References: <201007061948.05784.clemens-john@gmx.de>
	<201007070021.43888.clemens-john@gmx.de>
	<201007070030.30940.lindner_marek@yahoo.de>
	<201007071233.56171.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201007071233.56171.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jul 07, 2010 at 12:33:47PM +0200, Clemens John wrote:
> Am Mittwoch 07 Juli 2010, 00:30:30 schrieb Marek Lindner:
> > > Now batman advanced nodes behind the VPN does not get listet in the
> > > originator tables of nodes on the other side of the VPN.
> > > But do they get listed on the gateway list? Can Batman advanced choose a
> > > gateway behind the VPN?
> > 
> > No, because the gateway information travel with the OGMs which you don't
> > have on your VPN. Sending dhcp requests via unicast also does not work
> > because the VPN interfaces are not controlled by batman.
> 
> I just had another Idea but I?m not shure if this will work.
> 
> If we don?t use the Batman advanced gateway feature but run a DHCP Server on 
> gateways only, would a client always choose the "nearest" DHCP server?

It will likely choose the first to reply. You cannot guarantee the
first to reply is the nearest, it depends on what else they are is
doing at the same time, e.g. the nearest could be busy moving packets
between networks so has higher latency than an idle device a bit
further away.
 
> If this works, is it possible that all dhcp servers distribute the same ip 
> range? Will a client/server notice which IP?s are already assigned to clients?

Not recommended. Often the server will test to see if the address is
in use by ping'ing it, but this is not always implemented and is not a
guaranteed to work in all conditions. It is much better to allocate to
each server a unique range of addresses. These can however be inside
the same subnet.

    Andrew

