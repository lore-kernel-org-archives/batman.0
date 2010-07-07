Return-Path: <ordex@ritirata.org>
Date: Wed, 7 Jul 2010 14:44:17 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100707124417.GC10395@ritirata.org>
References: <201007061948.05784.clemens-john@gmx.de>
	<201007071325.56772.clemens-john@gmx.de>
	<201007071410.33193.lindner_marek@yahoo.de>
	<201007071433.59862.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201007071433.59862.clemens-john@gmx.de>
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

On Wed, Jul 07, 2010 at 02:33:53PM +0200, Clemens John wrote:
> Am Mittwoch 07 Juli 2010, 14:10:33 schrieb Marek Lindner:
> > On Wednesday, July 07, 2010 13:25:51 Clemens John wrote:
> > > Right and the wifi clients have no batman advanced installed. Currently
> > > they are getting their IP and defaultroute from a central dhcp server
> > 
> > Wow - when it comes to your setup and requirements you know how to keep
> > your answer short. I hoped you would say a bit more ... :)
> > 
> > At this point I don't see why you would need to use the gateway feature at
> > all. There is nothing to optimize.
> 
> Yes the network is working well but in this setup the central dhcp server is 
> the only gateway because I only get the defaultroute of this server.
> 
> What if I have more gateways? I know that I can set the defaultroute to this 
> server by hand but a "normal" user can´t do this. I need a method to choose 
> the gateway individually and automatically so that the user gets the best 
> gateway available.
> 
> Are there any ideas to do this? Or am I completely on the wrong way?
> 

If I'm not wrong, at this point you could put a dhcp server on each
gateway and use the gw-mode feature of batman, so that each gw will
anounce itself as gw and a dhcp request, becoming from a client, will be
redirected to the best gw in the mesh.


Please someone corrects me if I am wrong.

> Thank you
> Clemens

Regards


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
