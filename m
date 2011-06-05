Return-Path: <ordex@autistici.org>
Date: Mon, 6 Jun 2011 01:22:35 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110605232234.GD29069@ritirata.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
	<1307307664-19910-2-git-send-email-ordex@autistici.org>
	<20110605214236.GV4071@lunn.ch>
	<20110605220109.GA14194@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110605220109.GA14194@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: detect clients connected
 through a 802.11 device
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

Hi all,

On lun, giu 06, 2011 at 12:01:10 +0200, Antonio Quartulli wrote:
> Hi Andrew, Thank you for replying
> 
> On dom, giu 05, 2011 at 11:42:36 +0200, Andrew Lunn wrote:
> > Hi Antonio
> > 
> > >  
> > > -	tt_local_add(soft_iface, soft_iface->dev_addr);
> > > +	tt_local_add(soft_iface, soft_iface->dev_addr, 0);
> > 
> > Reading the code, it is not obvious what this 0 mean here. Did you see
> > Sven's recent patches which introduced enums in various places? Maybe
> > instead of a bool you could have an enum with two values: wired, wifi?
> > 
> > I've not looked at the other patches yet, but it might even make sense
> > to have enums for wired, AP, client, adhoc?
> >
> 
> Actually I only know whether the device is 802.11 or not. It could also be
> something different from both wired and wireless. However you are right,
> I should avoid the hardcoded zero. Maybe I can use NO_FLAGS as we did
> for the other patches.

Ok, this was not the case for NO_FLAGS (this is not a flag field).
I introduced a new constant:

#define NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */

I can't use an enum here because it is just a simple MACRO, not a set of
values. However does it make sense to have several constats defined as
0? should we always use the same? But what about the name?

> Later on someone else could add more enum values (interface types) and avoid
> using NO_FLAGS here (TT_CLIENT_WIFI is an enum already).

It is late. I mixed things up. These are two separated issues:

1) With NULL_IFINDEX I account the hardcoded 0.

2) Later on more enum values similar to TT_CLIENT_WIFI (e.g.
TT_CLIENT_ETH, TT_CLIENT_ADHOC, etc..) can be added. But till now we
only have is_wifi_iface().

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara ☭
