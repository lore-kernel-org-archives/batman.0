Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130402220654.GB14372@ritirata.org>
References: <CAP5XTDPibzzo_wLjXOsT07JnwNM_YTioxXdwo2bcDuAb0021xA@mail.gmail.com>
 <20130402220654.GB14372@ritirata.org>
Date: Wed, 3 Apr 2013 09:19:57 +0300
Message-ID: <CAP5XTDMHwbKGL2YasitBAR6UH10A4_d89=98H53PGp8L=xmG1w@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batman-adv: Modified DAT structures and
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

On 3 April 2013 01:06, Antonio Quartulli <ordex@autistici.org> wrote:
> On Mon, Mar 18, 2013 at 02:07:42PM +0200, Mihail Costea wrote:
>> Subject: [RFCv2] batman-adv: Modified DAT structures and functions in order
>>  to support both IPv4 and IPv6
>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>>
>> ---
>
>
> A couple of remarks that I missed till today:
>
>> +
>> +/**
>>   * batadv_compare_dat - comparing function used in the local DAT hash table
>>   * @node: node in the local table
>>   * @data2: second object to compare the node to
>> + * @ip_type: type of IP address
>>   *
>>   * Returns 1 if the two entries are the same, 0 otherwise.
>>   */
>> -static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
>> +static int batadv_compare_dat(const struct hlist_node *node, const void *data2,
>> +                            uint8_t ip_type)
>>  {
>> -     const void *data1 = container_of(node, struct batadv_dat_entry,
>> -                                      hash_entry);
>> +     struct batadv_dat_entry *dat_entry1 = container_of(node,
>> +                             struct batadv_dat_entry, hash_entry);
>> +     struct batadv_dat_entry *dat_entry2 = container_of(data2,
>> +                             struct batadv_dat_entry, ip);
>> +     size_t ip_size;
>>
>> -     return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
>> +     if (dat_entry1->type != dat_entry2->type)
>> +             return 0;
>> +
>> +     ip_size = batadv_sizeof_ip(ip_type);
>> +     return (memcmp(dat_entry1->ip, dat_entry2->ip, ip_size) == 0 ? 1 : 0);
>> +}
>> +
>> +static int batadv_compare_dat_ipv4(const struct hlist_node *node,
>> +                            const void *data2)
>> +{
>> +     return batadv_compare_dat(node, data2, BATADV_DAT_IPV4);
>> +}
>> +
>> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>> +static int batadv_compare_dat_ipv6(const struct hlist_node *node,
>> +                            const void *data2)
>> +{
>> +     return batadv_compare_dat(node, data2, BATADV_DAT_IPV6);
>>  }
>> +#endif
>>
>
> can't you simply use one function (batadv_compare_dat()) and use
> dat_entry1->type to compute the ip_size?
>
> In this way you do not need the two wrapper functions (batadv_compare_dat_ipv6()
> and batadv_compare_dat_ipv4()).
>
>
>>  /**
>>   * batadv_arp_hw_src - extract the hw_src field from an ARP packet
>> @@ -201,16 +367,19 @@ static __be32 batadv_arp_ip_dst(struct sk_buff
>> *skb, int hdr_size)
>>   * batadv_hash_dat - compute the hash value for an IP address
>>   * @data: data to hash
>>   * @size: size of the hash table
>> + * @ip_type: type of IP address
>>   *
>>   * Returns the selected index in the hash table for the given data.
>>   */
>> -static uint32_t batadv_hash_dat(const void *data, uint32_t size)
>> +static uint32_t batadv_hash_dat(const void *data, uint32_t size,
>> +                            uint8_t ip_type)
>>  {
>>       const unsigned char *key = data;
>>       uint32_t hash = 0;
>> -     size_t i;
>> +     size_t i, ip_size;
>>
>> -     for (i = 0; i < 4; i++) {
>> +     ip_size = batadv_sizeof_ip(ip_type);
>> +     for (i = 0; i < ip_size; i++) {
>>               hash += key[i];
>>               hash += (hash << 10);
>>               hash ^= (hash >> 6);
>
>
> mh, I think we should encode the "type" in the hash as well..
> Maybe we can postpone this suggestion to when we will make the DHT more and more
> generic. :) For now (that we encode IPs) we won't have IP addresses of the same
> size but different type :):)
>
>> @@ -289,14 +476,34 @@ static void batadv_dat_entry_add(struct
>> batadv_priv *bat_priv, __be32 ip,
>>       if (!dat_entry)
>>               goto out;
>>
>> -     dat_entry->ip = ip;
>> +     ip_size = batadv_sizeof_ip(ip_type);
>> +     dat_entry->ip = kmalloc(ip_size, GFP_ATOMIC);
>> +     if (!dat_entry->ip)
>> +             goto out;
>> +     memcpy(dat_entry->ip, ip, ip_size);
>> +     dat_entry->type = ip_type;
>> +
>>       memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
>>       dat_entry->last_update = jiffies;
>>       atomic_set(&dat_entry->refcount, 2);
>>
>> -     hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
>> -                                  batadv_hash_dat, &dat_entry->ip,
>> -                                  &dat_entry->hash_entry);
>> +     switch (ip_type) {
>> +     case BATADV_DAT_IPV4:
>> +             hash_added = batadv_hash_add(bat_priv->dat.hash,
>> +                             batadv_compare_dat_ipv4, batadv_hash_dat_ipv4,
>> +                             dat_entry->ip, &dat_entry->hash_entry);
>> +             break;
>> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>> +     case BATADV_DAT_IPV6:
>> +             hash_added = batadv_hash_add(bat_priv->dat.hash,
>> +                             batadv_compare_dat_ipv6, batadv_hash_dat_ipv6,
>> +                             dat_entry->ip, &dat_entry->hash_entry);
>> +             break;
>
> to reduce indentation here you could use a pointer to function which can be
> assigned to either batadv_hash_dat_ipv4 or batadv_hash_dat_ipv6 in the switch
> and then invoke batadv_hash_add once outside the switch block.
>
> if you follow the iupper suggestion, batadv_compare_dat_ipv6/4()
> should just become batadv_compare_dat()
>
>> +#endif
>> +     default:
>> +             hash_added = 1; /* in order to catch next if */
>
> assign 1 (better -1) to hash_added declaration/initialisation and avoid this
> default branch.
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

ACK

--
Mihail Costea
