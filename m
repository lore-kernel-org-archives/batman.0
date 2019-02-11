Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 11 Feb 2019 08:51:19 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190211075119.GG1477@otheros>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
 <3604216.NcQoz811mF@rousseau> <20190210150959.GD1477@otheros>
 <497454a6-ed48-2e48-2508-056147447c42@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <497454a6-ed48-2e48-2508-056147447c42@unstable.cc>
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
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Thanks Antonio!

On Mon, Feb 11, 2019 at 08:21:22AM +1000, Antonio Quartulli wrote:
> Hi,
> 
> On 11/02/2019 01:09, Linus Lüssing wrote:
> >> Furthermore, don't jiffies overflow at some point on some architectures ? 
> >> Initializing a jiffies field with 0 appears error-prone.
> > 
> > Hm, good point. Assuming 32bit and 1 jiffy = 1ms it would overflow
> > every 49 days (2^32/1000/60/60/24). The time_before() macros
> > should accomodate for that (as long as the value to compare with
> > is < 49/2 days apart?). However you are right, the 0 value would
> > probably lead to faulty results for 49/2 days then...
> > 
> > Anyway, removing that new timeout thing should fix it, as
> > last_update is always initialized with "jiffies".
> 
> +1
> 
> the problem is on last_dht_update that gets initializes with 0 (for
> locally cached entries).
> If you agree on removing it and using a bool (I like this idea too!),
> the overflow problem should be gone.


While updating the patch I noticed two more things in
batadv_dat_snoop_incoming_arp_reply():

It seems that batadv_dat_entry_add() is only performed if the dat
entry does not exist yet. Which kind of defeats the purpose of the
DHCPACK snooping and extended timeout, I guess?

I'm thinking about moving the "goto out" here[0] to below the
batadv_dat_entry_add(). Something like:

--------
bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
					 struct sk_buff *skb, int hdr_size)
{
[...]
	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
	if (dat_entry && batadv_compare_eth(hw_src, dat_entry->mac_addr)) {
		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
			   hw_src, &ip_src, hw_dst, &ip_dst,
			   dat_entry->mac_addr,	&dat_entry->ip);
		dropped = true;
// Remove:
//		goto out;
	}

	/* Update our internal cache with both the IP addresses the node got
	 * within the ARP reply
	 */
	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);

// New:
	if (dropped)
		goto out;
[...]
--------


Secondly, I'm wondering about what to do with ARP Replies on
batadv_dat_snoop_incoming_arp_reply() which did not come with
a DHT-PUT.

With the v1 of this patch I would either update last_update or
last_dht_update. Now I need to decide. Updating
dat_entry->last_update and setting dat_entry->global = true for
incoming ARP Replies which did not come via a DHT-PUT seems wrong.
We only want long timeouts on the three DHT candidates because
they are the ones that will be updated reliably from other nodes.

So, should I just avoid updating DAT entries via incoming ARP
Replies that did not come via a DHT-PUT? Any other ideas?

Regards, Linus
