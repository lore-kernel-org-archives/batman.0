Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130810110303.GA849@ritirata.org>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <20130810110303.GA849@ritirata.org>
Date: Sat, 10 Aug 2013 12:01:02 -0700
Message-ID: <CAP5XTDMWzo8S086mdmHpgKnGCVWtiJvdHWA=KHa5gFV0H_D5QA@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Generalize DAT in order to
 support any type of data, not only IPv4
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

Hi Antonio,

Thanks for the update.
I will do the changes as soon as possible. I haven't sync in a while
with the code base, so I think the whole changes might take a while to
implement (+ I'm also working full time and trying to finish the paper
for my Diploma Project).
I hope that in 2 weeks I will finish everything because I can mostly
work on my weekends. I don't have to finish everything by the time I
present the Diploma Project, but once I have presented it, I can
dedicate all my time here (at that time I would have finished my
internship too).

But maybe that is done by then :).

Thanks,
Mihail

On 10 August 2013 04:03, Antonio Quartulli <ordex@autistici.org> wrote:
> Hi Mihail,
>
> sorry for the very looong delay :)
> I'm finally sitting at my new location and I can give you some feedback on your
> nice work.
> Comments are inline.
>
> On Mon, Jul 08, 2013 at 03:12:40AM +0300, mihail.costea2005@gmail.com wrote:
>> From: Mihail Costea <mihail.costea90@gmail.com>
>>
>> Mades DAT support more types by making its data a void*, adding type field
>> to dat_entry and adding data_type to necessary functions.
>> This change is needed in order to make DAT support any type of data, like IPv6 too.
>>
>> Adds generic function for transforming DAT data to string.
>> The function is used in order to avoid defining different debug messages
>> for different DAT data types. For example, if we had IPv6 as a DAT data,
>> then "%pI4" should be "%pI6c", but all
>> the other text of the debug message would be the same.
>> Also everything is memorized in a struct in order to avoid further
>> switch cases for all types.
>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
>> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>>
>> ---
>>  distributed-arp-table.c |  197 +++++++++++++++++++++++++++++++++++------------
>>  distributed-arp-table.h |    1 +
>>  types.h                 |   24 +++++-
>>  3 files changed, 169 insertions(+), 53 deletions(-)
>>
>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>> index f2543c2..90565d0 100644
>> --- a/distributed-arp-table.c
>> +++ b/distributed-arp-table.c
>> @@ -31,9 +31,32 @@
>>  #include "types.h"
>>  #include "translation-table.h"
>>
>> +static struct batadv_dat_type_info batadv_dat_types_info[] = {
>> +     {
>> +             .size = sizeof(__be32),
>> +             .str_fmt = "%pI4",
>> +     },
>> +};
>> +
>>  static void batadv_dat_purge(struct work_struct *work);
>>
>>  /**
>> + * batadv_dat_data_to_str: transforms DAT data to string
>> + * @data: the DAT data
>> + * @type: type of data
>> + * @buf: the buf where the data string is stored
>> + * @buf_len: buf length
>> + *
>> + * Returns buf.
>> + */
>> +static char *batadv_dat_data_to_str(void *data, uint8_t type,
>> +                                 char *buf, size_t buf_len)
>> +{
>> +     snprintf(buf, buf_len, batadv_dat_types_info[type].str_fmt, data);
>> +return buf;
>
> alignment.
> Remember to check your patches with "checkpatch.pl --strict" before sending. It
> will tell you about these hidden mistakes.
>
>> +}
>> +
>> +/**
>>   * batadv_dat_start_timer - initialise the DAT periodic worker
>>   * @bat_priv: the bat priv with all the soft interface information
>>   */
>> @@ -45,6 +68,19 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
>>  }
>>
>>  /**
>> + * batadv_dat_entry_free_ref_rcu - free a dat entry using its rcu
>> + * @rcu: the dat entry rcu
>> + */
>> +static void batadv_dat_entry_free_ref_rcu(struct rcu_head *rcu)
>> +{
>> +     struct batadv_dat_entry *dat_entry;
>> +
>> +     dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
>> +     kfree(dat_entry->data);
>> +     kfree(dat_entry);
>> +}
>> +
>> +/**
>>   * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
>>   * free it
>>   * @dat_entry: the entry to free
>> @@ -52,7 +88,7 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
>>  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
>>  {
>>       if (atomic_dec_and_test(&dat_entry->refcount))
>> -             kfree_rcu(dat_entry, rcu);
>> +             call_rcu(&dat_entry->rcu, batadv_dat_entry_free_ref_rcu);
>>  }
>>
>
> since you are not using the kfree_rcu() function anymore, you should also delete
> the compatibility function we have in compat.c (and its declaration in
> compat.h).
>
>>  /**
>> @@ -136,12 +172,21 @@ static void batadv_dat_purge(struct work_struct *work)
>>   *
>>   * Returns 1 if the two entries are the same, 0 otherwise.
>>   */
>> -static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
>> +static int  batadv_compare_dat(const struct hlist_node *node, const void *data2)
>>  {
>> -     const void *data1 = container_of(node, struct batadv_dat_entry,
>> -                                      hash_entry);
>> +     struct batadv_dat_entry *dat_entry1 =
>> +                     container_of(node, struct batadv_dat_entry,
>> +                                  hash_entry);
>> +     struct batadv_dat_entry *dat_entry2 =
>> +                     container_of(data2,
>> +                                  struct batadv_dat_entry, data);
>
> These assignments are really ugly :-P.
> Please make the assignments after the declarations. They will look much better.
>
>> +     size_t data_size = batadv_dat_types_info[dat_entry1->type].size;
>>
>> -     return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
>> +     if (dat_entry1->type != dat_entry2->type)
>> +             return 0;
>> +
>> +     return (memcmp(dat_entry1->data, dat_entry2->data,
>> +                     data_size) == 0 ? 1 : 0);
>>  }
>>
>>  /**
>> @@ -198,8 +243,9 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
>>  }
>>
>>  /**
>> - * batadv_hash_dat - compute the hash value for an IP address
>> + * batadv_hash_dat - compute the hash value for a DAT data
>>   * @data: data to hash
>> + * @data_type: type of data
>>   * @size: size of the hash table
>>   *
>>   * Returns the selected index in the hash table for the given data.
>> @@ -209,7 +255,8 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
>>       uint32_t hash = 0;
>>       const struct batadv_dat_entry *dat = data;
>>
>> -     hash = batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
>> +     hash = batadv_hash_bytes(hash, dat->data,
>> +                              batadv_dat_types_info[dat->type].size);
>>       hash = batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));
>>
>>       hash += (hash << 3);
>> @@ -223,32 +270,40 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
>>   * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
>>   * table
>>   * @bat_priv: the bat priv with all the soft interface information
>> - * @ip: search key
>> + * @data: search key
>> + * @data_type: type of data
>>   * @vid: VLAN identifier
>>   *
>>   * Returns the dat_entry if found, NULL otherwise.
>>   */
>>  static struct batadv_dat_entry *
>> -batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
>> -                        unsigned short vid)
>> +batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *data,
>> +                        uint8_t data_type, unsigned short vid)
>>  {
>>       struct hlist_head *head;
>>       struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
>>       struct batadv_hashtable *hash = bat_priv->dat.hash;
>> -     uint32_t index;
>> +     uint32_t index, data_size = batadv_dat_types_info[data_type].size;
>>
>>       if (!hash)
>>               return NULL;
>>
>> -     to_find.ip = ip;
>> +     to_find.data = kmalloc(data_size, GFP_ATOMIC);
>> +     if (!to_find.data)
>> +             return NULL;
>> +     memcpy(to_find.data, data, data_size);
>
> why do you create a copy of the data? It is going to be read only by the hashing
> function. I think you can reuse the same data passed as argument no? You can
> directly assign "to_find.data = data;", can't you?
>
>> +     to_find.type = data_type;
>>       to_find.vid = vid;
>>
>>       index = batadv_hash_dat(&to_find, hash->size);
>>       head = &hash->table[index];
>> +     kfree(to_find.data);
>>
>
> ..consequently, this kfree can be deleted.
>
>>       rcu_read_lock();
>>       hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
>> -             if (dat_entry->ip != ip)
>> +             if (dat_entry->type != data_type)
>> +                     continue;
>> +             if (memcmp(dat_entry->data, data, data_size))
>>                       continue;
>>
>>               if (!atomic_inc_not_zero(&dat_entry->refcount))
>> @@ -265,25 +320,30 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
>>  /**
>>   * batadv_dat_entry_add - add a new dat entry or update it if already exists
>>   * @bat_priv: the bat priv with all the soft interface information
>> - * @ip: ipv4 to add/edit
>> - * @mac_addr: mac address to assign to the given ipv4
>> + * @data: the data to add/edit
>> + * @data_type: type of the data added to DAT
>> + * @mac_addr: mac address to assign to the given data
>>   * @vid: VLAN identifier
>>   */
>> -static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
>> -                              uint8_t *mac_addr, unsigned short vid)
>> +static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
>> +                              uint8_t data_type, uint8_t *mac_addr,
>> +                              unsigned short vid)
>
> here I realised we have a small conceptual problem.
> what we are calling "data" is not the real data, but is the "key".
> The data instead is supposed to be what we store in the entry: the mac address
> (that could possibly be generalised too..).
>
> I think generalising the data is not very important now. We have an ARP/ND table
> for now, so we can assume we only want to store MAC addresses, but I would
> suggest to rename the member (and so the variables) from "data" to "key".
> It makes much more sense in terms of DHT. (Tell me if you think I am not right).
>
>
> From now on I'll try to speed up the reviews so that we can get this thing done
> soonish ;)
>
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara



-- 
Mihail Costea
