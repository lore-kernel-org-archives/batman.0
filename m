Return-Path: <ordex@autistici.org>
Date: Mon, 6 Jun 2011 00:01:10 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110605220109.GA14194@ritirata.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
	<1307307664-19910-2-git-send-email-ordex@autistici.org>
	<20110605214236.GV4071@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110605214236.GV4071@lunn.ch>
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

Hi Andrew, Thank you for replying

On dom, giu 05, 2011 at 11:42:36 +0200, Andrew Lunn wrote:
> Hi Antonio
> 
> >  
> > -	tt_local_add(soft_iface, soft_iface->dev_addr);
> > +	tt_local_add(soft_iface, soft_iface->dev_addr, 0);
> 
> Reading the code, it is not obvious what this 0 mean here. Did you see
> Sven's recent patches which introduced enums in various places? Maybe
> instead of a bool you could have an enum with two values: wired, wifi?
> 
> I've not looked at the other patches yet, but it might even make sense
> to have enums for wired, AP, client, adhoc?
>

Actually I only know whether the device is 802.11 or not. It could also be
something different from both wired and wireless. However you are right,
I should avoid the hardcoded zero. Maybe I can use NO_FLAGS as we did
for the other patches.

Later on someone else could add more enum values (interface types) and avoid
using NO_FLAGS here (TT_CLIENT_WIFI is an enum already).

> > +/* This function check whether the interface represented by ifindex is a
> > + * 802.11 wireless device or not. If so the tt_local_entry is marked with the
> > + * TT_CLIENT_WIFI flag */
> > +static void tt_check_iface(struct tt_local_entry *tt_local_entry, int ifindex)
> 
> It would be nice to have a more descriptive name, one which tells you
> what it is checking. Here it is clear, because of the comment, but
> where it is actually used, it is not possible to know what the
> function is checking.
> 
> Maybe what is actually needed is a function:
> 
> bool is_iface_wifi(int ifindex)
> 

sounds good. It is definitely simpler to read and to understand.

> and maybe that should be in hard-interface.c? It could be that knowing
> if an interface is wired or wifi could be useful in other places. This
> was one of the discussions at WBMv4, giving preference to wired
> interfaces over wireless.
> 

mh..Yes, once the function is named is_iface_wifi(), it makes definitely
sense to move it in hard-interface.c and make it usable by other part of
the code.


Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara ☭
