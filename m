Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130810132043.GD849@ritirata.org>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <1373242365-763-6-git-send-email-mihail.costea2005@gmail.com>
 <20130810132043.GD849@ritirata.org>
Date: Wed, 14 Aug 2013 06:51:32 -0700
Message-ID: <CAP5XTDNHTHiU8Pak2qzj19azwCUT=qO9CHj3uv5TZXWi9-+1QQ@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 6/6] batman-adv: Adds snooping of router
 and override flags for NA creation
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

On 10 August 2013 06:20, Antonio Quartulli <ordex@autistici.org> wrote:
> On Mon, Jul 08, 2013 at 03:12:45AM +0300, mihail.costea2005@gmail.com wrote:
>> From: Mihail Costea <mihail.costea90@gmail.com>
>>
>> Snoops router and override flags for Neighbor Advertisement in order to
>> use it in NA creation. This information is stored in a extra member
>> in the dat entry. This is done separately from normal data,
>> because data is used for DHT comparison, while this flags can change
>> their value over time.
>
> Ok, therefore the extra member is not part of the "key" ( that we wrongly called
> data till now), but it is part of the "data" (that was a mac address only till
> now).
>
> I think that at this point it is better to generalise the data part too. We are
> not storing MAC addresses only anymore.
>
> For IPv4 we have data = { mac_addr }
> For IPv6 now we have data = { mac_addr, extra_stuff }.
>
> (and in the future we might have something else).
> I thought about not generalising the data field, but if we are going to
> introduce new (and IPv6 specific) fields than we have to do it anyway.
>
> I think that having a generic void *data and data_size where we can store the
> struct we want is much cleaner.
>
> What do you think? you think it is a too big work? In this case we could leave
> as you implemented it here and generalise later...Actually you "only" have to
> bring the mac_addr field inside the extra_data and rename extra_data to data.
>

I agree with calling IPs keys and mac + extra stuff to become generic
data. Also that generic data
should have its own struct if it has more than 1 member.

>>
>> Comments:
>> For now router and override are initialized to the values used in most
>> case scenarios. This can be changed easily if we want to avoid the
>> NA creation until we get the flags.
>
> when do we get this flags? when we create the entry don't we get the flags too
> from the snooped packet? (sorry but I don't entirely know the ND protocol).
>

So both router flag and override flag are always sent with NA package.
That means when
we snoop a NA we also get those.
For router, we can get that flag if we snoop NDP router packages.

For override flag, I think it might be possible to calculate it when
we create NA. Unfortunately I didn't
understand well how ndisc code was calculating it so I couldn't port
it here. Override flag must NOT be set
for proxy advertisements and anycast addresses. I don't really
understand what proxy advertisements are
and how anycast addresses are calculated. For anycast address I'm
pretty sure we should be able to calculate it,
because from what I understand that address is used by more different
nodes, so it should have information
known by more nodes.

>> Also, the router flag can be calculated easily using the Router Advertisement.
>> Any node that sends that package is a router, so there isn't a lot of snooping
>> in that case. This feature can be added easily.
>> The problem is that I have no other idea how to get the override flag,
>> with the exception of the current implemented mechanism.
>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
>> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>>
>> ---
>>  distributed-arp-table.c |  139 +++++++++++++++++++++++++++++++++++------------
>>  types.h                 |   21 ++++++-
>>  2 files changed, 124 insertions(+), 36 deletions(-)
>>
>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>> index 1a5749b..ce5c13d 100644
>> --- a/distributed-arp-table.c
>> +++ b/distributed-arp-table.c
>> @@ -39,7 +39,8 @@ static bool batadv_dat_snoop_arp_pkt(struct batadv_priv *bat_priv,
>>                                    struct sk_buff *skb, int hdr_size,
>>                                    uint16_t pkt_type, uint8_t pkt_dir_type,
>>                                    uint8_t **hw_src, void **ip_src,
>> -                                  uint8_t **hw_dst, void **ip_dst);
>> +                                  uint8_t **hw_dst, void **ip_dst,
>> +                                  void **extra_data);
>>
>>  static struct sk_buff *
>>  batadv_dat_create_arp_reply(struct batadv_priv *bat_priv,
>> @@ -56,7 +57,8 @@ static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
>>                                      struct sk_buff *skb, int hdr_size,
>>                                      uint16_t pkt_type, uint8_t pkt_dir_type,
>>                                      uint8_t **hw_src, void **ip_src,
>> -                                    uint8_t **hw_dst, void **ip_dst);
>> +                                    uint8_t **hw_dst, void **ip_dst,
>> +                                    void **extra_data);
>>
>>  static struct sk_buff *
>>  batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
>> @@ -68,6 +70,7 @@ batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
>>  static struct batadv_dat_type_info batadv_dat_types_info[] = {
>>       {
>>               .size = sizeof(__be32),
>> +             .extra_size = 0,
>>               .str_fmt = "%pI4",
>>               .snoop_pkt = batadv_dat_snoop_arp_pkt,
>>               .create_skb = batadv_dat_create_arp_reply,
>> @@ -75,6 +78,7 @@ static struct batadv_dat_type_info batadv_dat_types_info[] = {
>>  #if IS_ENABLED(CONFIG_IPV6)
>>       {
>>               .size = sizeof(struct in6_addr),>> +             .extra_size = sizeof(struct batadv_dat_ipv6_extra_data),
>>               .str_fmt = "%pI6c",
>>               .snoop_pkt = batadv_dat_snoop_ndisc_pkt,
>>               .create_skb = batadv_dat_create_ndisc_na,
>> @@ -119,6 +123,7 @@ static void batadv_dat_entry_free_ref_rcu(struct rcu_head *rcu)
>>
>>       dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
>>       kfree(dat_entry->data);
>> +     kfree(dat_entry->extra_data);
>>       kfree(dat_entry);
>>  }
>>
>> @@ -363,18 +368,20 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *data,
>>   * batadv_dat_entry_add - add a new dat entry or update it if already exists
>>   * @bat_priv: the bat priv with all the soft interface information
>>   * @data: the data to add/edit
>> + * @extra_data: the extra data for data param (can be NULL if none)
>>   * @data_type: type of the data added to DAT
>>   * @mac_addr: mac address to assign to the given data
>>   * @vid: VLAN identifier
>>   */
>>  static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
>> -                              uint8_t data_type, uint8_t *mac_addr,
>> -                              unsigned short vid)
>> +                              void *extra_data, uint8_t data_type,
>> +                              uint8_t *mac_addr, unsigned short vid)
>>  {
>>       struct batadv_dat_entry *dat_entry;
>>       int hash_added;
>>       char dbg_data[BATADV_DAT_DATA_MAX_LEN];
>>       size_t data_size = batadv_dat_types_info[data_type].size;
>> +     size_t extra_data_size = batadv_dat_types_info[data_type].extra_size;
>>
>>       dat_entry = batadv_dat_entry_hash_find(bat_priv, data, data_type, vid);
>>       /* if this entry is already known, just update it */
>> @@ -382,22 +389,40 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
>>               if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
>>                       memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
>>               dat_entry->last_update = jiffies;
>> -             batadv_dbg(BATADV_DBG_DAT, bat_priv, "Entry updated: %s %pM (vid: %u)\n",
>> +             if (extra_data)
>> +                     memcpy(dat_entry->extra_data, extra_data,
>> +                            extra_data_size);
>> +
>> +             batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> +                        "Entry updated: %s %pM (vid: %u)\n",
>>                          batadv_dat_data_to_str(dat_entry->data, data_type,
>>                                                 dbg_data, sizeof(dbg_data)),
>>                          dat_entry->mac_addr, vid);
>>               goto out;
>>       }
>>
>> +     /* alloc entry */
>>       dat_entry = kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
>>       if (!dat_entry)
>>               goto out;
>> +     /* some entries don't have an extra data and useful if allocation for
>> +      * data fails */
>
> this comment has to be indented
>
> /* like
>  * this
>  */
>
>
>
> There are other style issues in this patch, but they mostly concern what I
> already pointed out in the other comments.
>
> Remember to always check your patch with checkpatch.pl --strict in order to find
> problems before sending the patches.
>

I still don't know what generated some style problems. Alignments
problems shouldn't be here because I already
used --strict (but that didn't say anything about comments) and sent
the patches with git mail. That is weird.

>
> But overall is a very good job! I think we are close to the real patch series ;)
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Thanks,
Mihail
