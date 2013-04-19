Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130419123826.GB13226@ritirata.org>
References: <CAP5XTDOompgC27u857UaC6UZ6pk1mg6BnLdtsEL1uMgMq452bw@mail.gmail.com>
 <20130419123826.GB13226@ritirata.org>
Date: Fri, 19 Apr 2013 21:39:17 +0300
Message-ID: <CAP5XTDM4yWxbjEDSDkAyAuizLQDh97Ea616tGOs-dS5YBKgX-A@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFCv3] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On 19 April 2013 15:38, Antonio Quartulli <ordex@autistici.org> wrote:
>
> Hi Mihail,
>
> On Mon, Apr 15, 2013 at 12:37:33PM +0300, Mihail Costea wrote:
>
> [...]
>
> >
> > +#ifdef CONFIG_BATMAN_ADV_DEBUG
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +
> > +/* batadv_dat_dbg_ip - print similar debug message for IPv4 and IPv6.
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @ip_type: IPv4 / IPv6 address
> > + * @format_prefix: format before IP field
> > + * @format_suffix: format after IP field
> > + *
> > + * At list one variable parameter should be the IP itself, and it should
> > + * be placed correctly based on format prefix and format suffix arguments.
> > + */
> > +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
> > +  format_suffix, ...) \
> > + { \
> > + switch (ip_type) { \
> > + case BATADV_DAT_IPV4: \
> > + batadv_dbg(BATADV_DBG_DAT, bat_priv, \
> > +   format_prefix "%pI4" format_suffix, \
> > +   __VA_ARGS__); \
> > + break; \
> > + case BATADV_DAT_IPV6: \
> > + batadv_dbg(BATADV_DBG_DAT, bat_priv, \
> > +   format_prefix "%pI6c" format_suffix, \
> > +   __VA_ARGS__); \
> > + break; \
> > + } \
> > + }
>
> I think this define is pretty overkill..What about creating a function which
> only takes care of converting a generic DHT data in a string. Later you can
> invoke this function when you want to print an IPv4/6 using batadv_dbg.
>
> Here is an example:
>
> char *batadv_dat_data_to_str(struct batadv_dat_entry *dat_entry,
>                              const char *buf, size_t buf_len)
> {
>         /* do something and put the string representation of the entry in the
>          * buf, without exceeding buf_len.
>          * Remember to use IS_ENABLED(CONFIG_IPV6) inside
>          */
>
>
>         return buf;
> }
>
> Then you can call it directly as parameter of a batdv_dbg function. E.g:
>
> batadv_dbg(....," %s\n", batadv_dat_data_to_str(entry, buf, buf_len));
>
> I think this approach would be better and easy to extend for future data types.
> If you like this approach, what do you think about sending a patch now to add
> this function to the current code?
>

This could work. buf could be a string with a given pattern inside
(let's say %data, or something similar) that would be automatically
converted to the right type (like %pI4, or %pI6c.

> > +
> >  static void batadv_dat_purge(struct work_struct *work);
> >
> >  /**
> > @@ -45,6 +101,19 @@ static void batadv_dat_start_timer(struct
> > batadv_priv *bat_priv)
> >  }
> >
> >  /**
> > + * batadv_dat_entry_free_ref_rcu - free a dat entry using its rcu
> > + * @rcu: the dat entry rcu
> > + */
> > +static void batadv_dat_entry_free_ref_rcu(struct rcu_head *rcu)
> > +{
> > + struct batadv_dat_entry *dat_entry;
> > +
> > + dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
> > + kfree(dat_entry->data);
> > + kfree(dat_entry);
> > +}
> > +
> > +/**
> >   * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
> >   * free it
> >   * @dat_entry: the entry to free
> > @@ -52,7 +121,7 @@ static void batadv_dat_start_timer(struct
> > batadv_priv *bat_priv)
> >  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
> >  {
> >   if (atomic_dec_and_test(&dat_entry->refcount))
> > - kfree_rcu(dat_entry, rcu);
> > + call_rcu(&dat_entry->rcu, batadv_dat_entry_free_ref_rcu);
> >  }
> >
> >  /**
> > @@ -130,6 +199,26 @@ static void batadv_dat_purge(struct work_struct *work)
> >  }
> >
> >  /**
> > + * batadv_sizeof_ip - get sizeof IP based on its type (IPv4 / IPv6)
> > + * @ip_type: type of IP address
> > + *
> > + * Returns sizeof IP, or sizeof IPv4 if ip_type is invalid.
> > + */
> > +static size_t batadv_sizeof_ip(uint8_t ip_type)
> > +{
> > + switch (ip_type) {
> > + case BATADV_DAT_IPV4:
> > + return sizeof(__be32);
> > +#if IS_ENABLED(CONFIG_IPV6)
> > + case BATADV_DAT_IPV6:
> > + return sizeof(struct in6_addr);
> > +#endif
> > + default:
> > + return sizeof(__be32); /* fallback to IPv4 */
> > + }
> > +}
>
> Either you mail client killed the tabs or this switch is not indented properly.
> Also, do you think it would be better to return 0 in case of unknown type? In
> this way we prevent any further operation on the data buffer.
>

It might be from my gmail. Next time I will send it with git send-email. Thanks.

> > +
> > +/**
> >   * batadv_compare_dat - comparing function used in the local DAT hash table
> >   * @node: node in the local table
> >   * @data2: second object to compare the node to
> > @@ -138,10 +227,18 @@ static void batadv_dat_purge(struct work_struct *work)
> >   */
> >  static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
> >  {
> > - const void *data1 = container_of(node, struct batadv_dat_entry,
> > - hash_entry);
> > + struct batadv_dat_entry *dat_entry1 = container_of(node,
> > + struct batadv_dat_entry, hash_entry);
> > + struct batadv_dat_entry *dat_entry2 = container_of(data2,
> > + struct batadv_dat_entry, data);
> > + size_t ip_size;
> >
> > - return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
> > + if (dat_entry1->type != dat_entry2->type)
> > + return 0;
> > +
> > + ip_size = batadv_sizeof_ip(dat_entry1->type);
> > + return (memcmp(dat_entry1->data, dat_entry2->data,
> > +       ip_size) == 0 ? 1 : 0);
> >  }
> >
> >  /**
> > @@ -201,16 +298,19 @@ static __be32 batadv_arp_ip_dst(struct sk_buff
> > *skb, int hdr_size)
> >   * batadv_hash_dat - compute the hash value for an IP address
> >   * @data: data to hash
> >   * @size: size of the hash table
> > + * @ip_type: type of IP address
> >   *
> >   * Returns the selected index in the hash table for the given data.
> >   */
> > -static uint32_t batadv_hash_dat(const void *data, uint32_t size)
> > +static uint32_t batadv_hash_dat(const void *data, uint32_t size,
> > +       uint8_t ip_type)
> >  {
> >   const unsigned char *key = data;
> >   uint32_t hash = 0;
> > - size_t i;
> > + size_t i, ip_size;
> >
> > - for (i = 0; i < 4; i++) {
> > + ip_size = batadv_sizeof_ip(ip_type);
> > + for (i = 0; i < ip_size; i++) {
> >   hash += key[i];
> >   hash += (hash << 10);
> >   hash ^= (hash >> 6);
> > @@ -223,31 +323,47 @@ static uint32_t batadv_hash_dat(const void
> > *data, uint32_t size)
> >   return hash % size;
> >  }
>
> Also here, I think it is a mail client problem at this point :)
> Did you send the patch using git send-email? It will take care of not ruining
> the text ;)
>
> >
> > +static uint32_t batadv_hash_dat_ipv4(const void *data, uint32_t size)
> > +{
> > + return batadv_hash_dat(data, size, BATADV_DAT_IPV4);
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static uint32_t batadv_hash_dat_ipv6(const void *data, uint32_t size)
> > +{
> > + return batadv_hash_dat(data, size, BATADV_DAT_IPV6);
> > +}
> > +#endif
> > +
> >  /**
> >   * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
> >   * table
> >   * @bat_priv: the bat priv with all the soft interface information
> >   * @ip: search key
> > + * @ip_type: type of IP address
> >   *
> >   * Returns the dat_entry if found, NULL otherwise.
> >   */
> >  static struct batadv_dat_entry *
> > -batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
> > +batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *ip,
> > +   uint8_t ip_type)
> >  {
> >   struct hlist_head *head;
> >   struct batadv_dat_entry *dat_entry, *dat_entry_tmp = NULL;
> >   struct batadv_hashtable *hash = bat_priv->dat.hash;
> >   uint32_t index;
> > + size_t ip_size;
> >
> >   if (!hash)
> >   return NULL;
> >
> > - index = batadv_hash_dat(&ip, hash->size);
> > + ip_size = batadv_sizeof_ip(ip_type);
> > + index = batadv_hash_dat(ip, hash->size, ip_type);
> >   head = &hash->table[index];
> >
> >   rcu_read_lock();
> >   hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
> > - if (dat_entry->ip != ip)
> > + if (memcmp(dat_entry->data, ip, ip_size))
> >   continue;
> >
>
> Why don't you check the type first? if dat_entry->type != ip_type then you can
> "continue;" and skip the memory check. If you don't do so you may do a memory
> check beyond the limit of dat_entry->data if it is smaller than ip_size.
>

Thanks. Didn't think about this case.

> >   if (!atomic_inc_not_zero(&dat_entry->refcount))
> > @@ -264,24 +380,28 @@ batadv_dat_entry_hash_find(struct batadv_priv
> > *bat_priv, __be32 ip)
> >  /**
> >   * batadv_dat_entry_add - add a new dat entry or update it if already exists
> >   * @bat_priv: the bat priv with all the soft interface information
> > - * @ip: ipv4 to add/edit
> > + * @ip: IP to add/edit
> > + * @ip_type: type of IP address
> >   * @mac_addr: mac address to assign to the given ipv4
> >   */
> > -static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
> > - uint8_t *mac_addr)
> > +static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *ip,
> > + uint8_t ip_type, uint8_t *mac_addr)
> >  {
> >   struct batadv_dat_entry *dat_entry;
> >   int hash_added;
> > + size_t ip_size;
> > + batadv_hashdata_choose_cb choose;
> >
> > - dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
> > + dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, ip_type);
> >   /* if this entry is already known, just update it */
> >   if (dat_entry) {
> >   if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
> >   memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
> >   dat_entry->last_update = jiffies;
> > - batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > -   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
> > -   dat_entry->mac_addr);
> > +
> > + batadv_dat_dbg_ip(bat_priv, ip_type, "Entry updated: ",
> > +  " %pM\n", dat_entry->data,
> > +  dat_entry->mac_addr);
> >   goto out;
> >   }
> >
> > @@ -289,13 +409,30 @@ static void batadv_dat_entry_add(struct
> > batadv_priv *bat_priv, __be32 ip,
> >   if (!dat_entry)
> >   goto out;
> >
> > - dat_entry->ip = ip;
> > + ip_size = batadv_sizeof_ip(ip_type);
> > + dat_entry->data = kmalloc(ip_size, GFP_ATOMIC);
> > + if (!dat_entry->data)
> > + goto out;
> > + memcpy(dat_entry->data, ip, ip_size);
> > + dat_entry->type = ip_type;
> > +
> >   memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
> >   dat_entry->last_update = jiffies;
> >   atomic_set(&dat_entry->refcount, 2);
> >
> > + switch (ip_type) {
> > +#if IS_ENABLED(CONFIG_IPV6)
> > + case BATADV_DAT_IPV6:
> > + choose = batadv_hash_dat_ipv6;
> > + break;
> > +#endif
> > + default:
> > + choose = batadv_hash_dat_ipv4; /* IPv4 by default */
> > + break;
> > + }
> > +
> >   hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
> > -     batadv_hash_dat, &dat_entry->ip,
> > +     choose, dat_entry->data,
> >       &dat_entry->hash_entry);
> >
> >   if (unlikely(hash_added != 0)) {
> > @@ -304,9 +441,8 @@ static void batadv_dat_entry_add(struct
> > batadv_priv *bat_priv, __be32 ip,
> >   goto out;
> >   }
> >
> > - batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
> > -   &dat_entry->ip, dat_entry->mac_addr);
> > -
> > + batadv_dat_dbg_ip(bat_priv, ip_type, "New entry added: ", " %pM\n",
> > +  dat_entry->data, dat_entry->mac_addr);
>
> Here you can use the "new function" I told you about at the beginning of the
> email.
>
> >  out:
> >   if (dat_entry)
> >   batadv_dat_entry_free_ref(dat_entry);
> > @@ -513,7 +649,8 @@ static void batadv_choose_next_candidate(struct
> > batadv_priv *bat_priv,
> >   * batadv_dat_select_candidates - select the nodes which the DHT message has to
> >   * be sent to
> >   * @bat_priv: the bat priv with all the soft interface information
> > - * @ip_dst: ipv4 to look up in the DHT
> > + * @ip_dst: IP to look up in the DHT
> > + * @ip_type: type of IP address
> >   *
> >   * An originator O is selected if and only if its DHT_ID value is one of three
> >   * closest values (from the LEFT, with wrap around if needed) then the hash
> > @@ -522,7 +659,8 @@ static void batadv_choose_next_candidate(struct
> > batadv_priv *bat_priv,
> >   * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
> >   */
> >  static struct batadv_dat_candidate *
> > -batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
> > +batadv_dat_select_candidates(struct batadv_priv *bat_priv, void *ip_dst,
> > +     uint8_t ip_type)
> >  {
> >   int select;
> >   batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
> > @@ -535,12 +673,11 @@ batadv_dat_select_candidates(struct batadv_priv
> > *bat_priv, __be32 ip_dst)
> >   if (!res)
> >   return NULL;
> >
> > - ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
> > -    BATADV_DAT_ADDR_MAX);
> > + ip_key = (batadv_dat_addr_t)batadv_hash_dat(ip_dst, BATADV_DAT_ADDR_MAX,
> > + ip_type);
> >
> > - batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > -   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
> > -   ip_key);
> > + batadv_dat_dbg_ip(bat_priv, ip_type, "dat_select_candidates(): IP=",
> > +  " hash(IP)=%u\n", ip_dst, ip_key);
> >
> >   for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
> >   batadv_choose_next_candidate(bat_priv, res, select, ip_key,
> > @@ -554,6 +691,7 @@ batadv_dat_select_candidates(struct batadv_priv
> > *bat_priv, __be32 ip_dst)
> >   * @bat_priv: the bat priv with all the soft interface information
> >   * @skb: payload to send
> >   * @ip: the DHT key
> > + * @ip_type: type of IP address
> >   * @packet_subtype: unicast4addr packet subtype to use
> >   *
> >   * This function copies the skb with pskb_copy() and is sent as unicast packet
> > @@ -563,7 +701,7 @@ batadv_dat_select_candidates(struct batadv_priv
> > *bat_priv, __be32 ip_dst)
> >   * otherwise.
> >   */
> >  static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
> > - struct sk_buff *skb, __be32 ip,
> > + struct sk_buff *skb, void *ip, uint8_t ip_type,
> >   int packet_subtype)
> >  {
> >   int i;
> > @@ -573,11 +711,11 @@ static bool batadv_dat_send_data(struct
> > batadv_priv *bat_priv,
> >   struct sk_buff *tmp_skb;
> >   struct batadv_dat_candidate *cand;
> >
> > - cand = batadv_dat_select_candidates(bat_priv, ip);
> > + cand = batadv_dat_select_candidates(bat_priv, ip, ip_type);
> >   if (!cand)
> >   goto out;
> >
> > - batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
> > + batadv_dat_dbg_ip(bat_priv, ip_type, "DHT_SEND for ", "\n", ip);
> >
> >   for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
> >   if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
> > @@ -693,8 +831,8 @@ int batadv_dat_cache_seq_print_text(struct
> > seq_file *seq, void *offset)
> >   goto out;
> >
> >   seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
> > - seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
> > -   "last-seen");
> > + seq_printf(seq, "                       %-26s %-15s %5s\n",
> > +   "IPv4/IPv6", "MAC", "last-seen");
> >
> >   for (i = 0; i < hash->size; i++) {
> >   head = &hash->table[i];
> > @@ -707,9 +845,20 @@ int batadv_dat_cache_seq_print_text(struct
> > seq_file *seq, void *offset)
> >   last_seen_msecs = last_seen_msecs % 60000;
> >   last_seen_secs = last_seen_msecs / 1000;
> >
> > - seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
> > -   &dat_entry->ip, dat_entry->mac_addr,
> > -   last_seen_mins, last_seen_secs);
> > + switch (dat_entry->type) {
> > + case BATADV_DAT_IPV4:
> > + seq_printf(seq, " * %-40pI4 %15pM %6i:%02i\n",
> > +   dat_entry->data, dat_entry->mac_addr,
> > +   last_seen_mins, last_seen_secs);
> > + break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > + case BATADV_DAT_IPV6:
> > + seq_printf(seq, " * %-40pI6c %15pM %6i:%02i\n",
> > +   dat_entry->data, dat_entry->mac_addr,
> > +   last_seen_mins, last_seen_secs);
> > + break;
> > +#endif
> > + }
> >   }
> >   rcu_read_unlock();
> >   }
> > @@ -830,9 +979,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct
> > batadv_priv *bat_priv,
> >   hw_src = batadv_arp_hw_src(skb, 0);
> >   ip_dst = batadv_arp_ip_dst(skb, 0);
> >
> > - batadv_dat_entry_add(bat_priv, ip_src, hw_src);
> > + batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
> >
> > - dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
> > + dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
> > +       BATADV_DAT_IPV4);
> >   if (dat_entry) {
> >   skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
> >       bat_priv->soft_iface, ip_dst, hw_src,
> > @@ -851,8 +1001,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct
> > batadv_priv *bat_priv,
> >   batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
> >   ret = true;
> >   } else {
> > - /* Send the request to the DHT */
> > - ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
> > + /* Send the request on the DHT */
> > + ret = batadv_dat_send_data(bat_priv, skb, &ip_dst,
> > +   BATADV_DAT_IPV4,
> >     BATADV_P_DAT_DHT_GET);
> >   }
> >  out:
> > @@ -895,9 +1046,10 @@ bool
> > batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
> >   batadv_dbg_arp(bat_priv, skb, type, hdr_size,
> >         "Parsing incoming ARP REQUEST");
> >
> > - batadv_dat_entry_add(bat_priv, ip_src, hw_src);
> > + batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
> >
> > - dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
> > + dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
> > +       BATADV_DAT_IPV4);
> >   if (!dat_entry)
> >   goto out;
> >
> > @@ -956,14 +1108,16 @@ void batadv_dat_snoop_outgoing_arp_reply(struct
> > batadv_priv *bat_priv,
> >   hw_dst = batadv_arp_hw_dst(skb, 0);
> >   ip_dst = batadv_arp_ip_dst(skb, 0);
> >
> > - batadv_dat_entry_add(bat_priv, ip_src, hw_src);
> > - batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
> > + batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
> > + batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst);
> >
> >   /* Send the ARP reply to the candidates for both the IP addresses that
> >   * the node obtained from the ARP reply
> >   */
> > - batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
> > - batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
> > + batadv_dat_send_data(bat_priv, skb, &ip_src, BATADV_DAT_IPV4,
> > +     BATADV_P_DAT_DHT_PUT);
> > + batadv_dat_send_data(bat_priv, skb, &ip_dst, BATADV_DAT_IPV4,
> > +     BATADV_P_DAT_DHT_PUT);
> >  }
> >  /**
> >   * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
> > @@ -998,8 +1152,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct
> > batadv_priv *bat_priv,
> >   /* Update our internal cache with both the IP addresses the node got
> >   * within the ARP reply
> >   */
> > - batadv_dat_entry_add(bat_priv, ip_src, hw_src);
> > - batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
> > + batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
> > + batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst);
> >
> >   /* if this REPLY is directed to a client of mine, let's deliver the
> >   * packet to the interface
> > @@ -1043,7 +1197,8 @@ bool batadv_dat_drop_broadcast_packet(struct
> > batadv_priv *bat_priv,
> >   goto out;
> >
> >   ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
> > - dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
> > + dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
> > +       BATADV_DAT_IPV4);
> >   /* check if the node already got this entry */
> >   if (!dat_entry) {
> >   batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > diff --git a/types.h b/types.h
> > index 5f542bd..5b820f6 100644
> > --- a/types.h
> > +++ b/types.h
> > @@ -961,17 +961,19 @@ struct batadv_algo_ops {
> >  };
> >
> >  /**
> > - * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
> > - * is used to stored ARP entries needed for the global DAT cache
> > - * @ip: the IPv4 corresponding to this DAT/ARP entry
> > - * @mac_addr: the MAC address associated to the stored IPv4
> > + * struct batadv_dat_entry - it is a single entry of batman-adv
> > ARP/NDP backend. It
> > + * is used to stored ARP/NDP entries needed for the global DAT cache
> > + * @data: the data corresponding to this DAT ARP/NDP entry
> > + * @type: the type corresponding to this DAT ARP/NDP entry
> > + * @mac_addr: the MAC address associated to the stored data
> >   * @last_update: time in jiffies when this entry was refreshed last time
> >   * @hash_entry: hlist node for batadv_priv_dat::hash
> >   * @refcount: number of contexts the object is used
> >   * @rcu: struct used for freeing in an RCU-safe manner
> >   */
> >  struct batadv_dat_entry {
> > - __be32 ip;
> > + void *data;
> > + uint8_t type;
> >   uint8_t mac_addr[ETH_ALEN];
> >   unsigned long last_update;
> >   struct hlist_node hash_entry;
> > @@ -980,6 +982,18 @@ struct batadv_dat_entry {
> >  };
> >
> >  /**
> > + * batadv_dat_types - types used in batadv_dat_entry for IP
> > + * @BATADV_DAT_IPv4: IPv4 address type
> > + * @BATADV_DAT_IPv6: IPv6 address type
> > + */
> > +enum batadv_dat_types {
> > + BATADV_DAT_IPV4,
> > +#if IS_ENABLED(CONFIG_IPV6)
> > + BATADV_DAT_IPV6,
> > +#endif
> > +};
> > +
> > +/**
> >   * struct batadv_dat_candidate - candidate destination for DAT operations
> >   * @type: the type of the selected candidate. It can one of the following:
> >   *  - BATADV_DAT_CANDIDATE_NOT_FOUND
> > --
> > 1.7.10.4
>
> Nice job so far!
>
> My suggestion now is to send patch (1) for the new "data_to_str" function and then
> split this RFC in two patches:
> (2) generalise the dat_entry struct by introducing the type and data fields,
> with all the needed functions
> (3) introduce the IPv6 data type and the related function.
>
> However, having patch (3) merged without a "user" would not make much sense.
> So I think it would be good for now to send patch (1) and (2) and then send (3)
> along with the "snooping patch" as soon as it is ready.
>
> Thanks a lot!
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Thanks for the advice. I will make the changes asap.

Mihail
