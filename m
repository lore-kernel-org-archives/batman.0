Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 10 Feb 2019 16:09:59 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190210150959.GD1477@otheros>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
 <3604216.NcQoz811mF@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3604216.NcQoz811mF@rousseau>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on
 DAT DHT candidates
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Marek,

Thanks for your feedback!

On Sun, Feb 10, 2019 at 07:59:59PM +0800, Marek Lindner wrote:
> On Saturday, 12 January 2019 05:02:08 HKT Linus Lüssing wrote:
> > Some old investigations and analysis seemed to indicate a potential
> > reduction of 91.71% of unanswered ARP Requests (45min: 97.95%, 60min:
> > 98.95%):
> 
> Does this reduction apply to this patch specifically or to the DHCPACK 
> snooping or both ? Has this patch been tested ?

The DHCPACK snooping part should reduce the broadcasted ARP Requests that
were answered. Which is the 12.881% DAT BCAST part in the link.

For the unanswered ARP Requests I do not expect any reduction from
the DHCPACK snooping part. If the client device is gone than there
will be no more DHCPACKs to refresh entries either.


This patch however targets the unanswered ARP Requests. So even if
the client is gone, we will then still respond with the value
stored in the DHT, without falling back to broadcasting.


I haven't tested these two patches in the network I had performed
the initial measurements and calculations in back then. But the
DHCPACKs patch was applied and tested on gateways at Freifunk
Darmstadt. And for this patch here I had tested in VMs that the
DHT-PUT entry stayed for longer than the previous 5 minutes.

> 
> > 
> > https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping
> > 
> > This patch is rebased on top of:
> > 
> > "batman-adv: DHCP snooping for DAT"
> 
> That patch is now called "batman-adv: Snoop DHCPACKs for DAT" and has been 
> merged ?

Correct.

> 
> 
> > @@ -152,7 +152,9 @@ static void batadv_dat_entry_put(struct batadv_dat_entry
> > *dat_entry) static bool batadv_dat_to_purge(struct batadv_dat_entry
> > *dat_entry) {
> >  	return batadv_has_timed_out(dat_entry->last_update,
> > -				    BATADV_DAT_ENTRY_TIMEOUT);
> > +				    BATADV_DAT_ENTRY_TIMEOUT) &&
> > +	       batadv_has_timed_out(dat_entry->last_dht_update,
> > +				    BATADV_DAT_DHT_TIMEOUT);
> >  }
> 
> This bit could be further simplified. Introducing 2 timeout fields is a bit 
> misleading since there only are 2 cases:
> 
> * last_update is updated (or not) while last_dht_update is/remains 0
> * last_update and last_dht_update have the same value
> 
> Why not turn last_dht_update into a bool and apply the timeout length based on 
> that bool. Something like:
> 
> if (is_global_entry)
>    return batadv_has_timed_out(dat_entry->last_update,
> BATADV_DAT_DHT_TIMEOUT);
> else
>    return batadv_has_timed_out(dat_entry->last_update,
> BATADV_DAT_ENTRY_TIMEOUT));

Good idea, thanks!

> Furthermore, don't jiffies overflow at some point on some architectures ? 
> Initializing a jiffies field with 0 appears error-prone.

Hm, good point. Assuming 32bit and 1 jiffy = 1ms it would overflow
every 49 days (2^32/1000/60/60/24). The time_before() macros
should accomodate for that (as long as the value to compare with
is < 49/2 days apart?). However you are right, the 0 value would
probably lead to faulty results for 49/2 days then...

Anyway, removing that new timeout thing should fix it, as
last_update is always initialized with "jiffies".

Regards, Linus
