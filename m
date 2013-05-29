Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130526135746.GM1679@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-2-git-send-email-mihail.costea2005@gmail.com>
 <20130526135746.GM1679@ritirata.org>
Date: Wed, 29 May 2013 08:21:37 -0700
Message-ID: <CAP5XTDPhKhaJtagOw2XO04g5ffqt=MmFKaTjtaHZ5RAiACWHJg@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 2/4] batman-adv: added IPv6 to DAT and
 generic functions in distributed-arp-table.c
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

On 26 May 2013 06:57, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, May 17, 2013 at 03:27:50PM +0300, Mihail wrote:
>> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>>
>> Added IPv6 functionality to generic functions implemented in the first
>> patch.
>
> avoid references to "first"/"second"/"third" patch. Once committed, they will
> just be some patches in the list. You can either explicitly mention the name of
> the patch ("writing the subject in this way") or just saying
> previously/whatever else.
>
>

ACK

>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
>> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>>
>> ---
>>  distributed-arp-table.c |   30 ++++++++++++++++++++++++++----
>>  types.h                 |    6 +++++-
>>  2 files changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>> index b2ca7e0..42118be 100644
>> --- a/distributed-arp-table.c
>> +++ b/distributed-arp-table.c
>> @@ -32,7 +32,7 @@
>>  #include "unicast.h"
>>
>>  static char *batadv_dat_types_str_fmt[] = {
>> -     "%pI4",
>> +     "%pI4", "%pI6c",
>
> better going on a new line rather than putting both on the same one (like the
> array declared in the gateway code).
>

ACK

>>  };
>>
>>  static void batadv_dat_purge(struct work_struct *work);
>> @@ -173,6 +173,10 @@ static size_t batadv_sizeof_dat_data(uint8_t data_type)
>>       switch (data_type) {
>>       case BATADV_DAT_IPV4:
>>               return sizeof(__be32);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +     case BATADV_DAT_IPV6:
>> +             return sizeof(struct in6_addr);
>> +#endif
>>       default:
>>               return 0;
>>       }
>> @@ -295,6 +299,12 @@ static uint32_t batadv_hash_dat_ipv4(const void *data, uint32_t size)
>>       return batadv_hash_dat(data, BATADV_DAT_IPV4, size);
>>  }
>>
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +static uint32_t batadv_hash_dat_ipv6(const void *data, uint32_t size)
>> +{
>> +     return batadv_hash_dat(data, BATADV_DAT_IPV6, size);
>> +}
>> +#endif
>>
>>  /**
>>   * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
>> @@ -393,6 +403,11 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
>>       case BATADV_DAT_IPV4:
>>               choose = batadv_hash_dat_ipv4;
>>               break;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +     case BATADV_DAT_IPV6:
>> +             choose = batadv_hash_dat_ipv6;
>> +             break;
>> +#endif
>
> mh...I was just wondering: for the hash functions it would be nice to re-use the
> same "array approach" that you used for the printing format.
>
> So we would have an array of function pointers to reference rather than having
> this switch block...What do you think?
>
> I think it would be possible to do this for many other "variable" parameters if
> required.
>

Should there be a struct that contains all of them, like:

struct batadv_dat_data  {
  char *format;
  signature *hash_function;
  .......
}

And after that the array with the initialization for all types.
Or should they be declared as arrays that have nothing in common? Like
just adding a new array for the choose functions.

>>       default:
>>               goto out;
>>       }
>> @@ -872,8 +887,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
>>               goto out;
>>
>>       seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
>> -     seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
>> -                "last-seen");
>> +     seq_printf(seq, "                       %-26s %-15s %5s\n",
>> +                "IPv4/IPv6", "MAC", "last-seen");
>>
>>       for (i = 0; i < hash->size; i++) {
>>               head = &hash->table[i];
>> @@ -888,10 +903,17 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
>>
>>                       switch (dat_entry->type) {
>>                       case BATADV_DAT_IPV4:
>> -                             seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
>> +                             seq_printf(seq, " * %-40pI4 %15pM %6i:%02i\n",
>>                                          dat_entry->data, dat_entry->mac_addr,
>>                                          last_seen_mins, last_seen_secs);
>>                               break;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +                     case BATADV_DAT_IPV6:
>> +                             seq_printf(seq, " * %-40pI6c %15pM %6i:%02i\n",
>
> can't you generalise this using the printing format array defined at the
> top of this patch?
>

I forgot about that.

>> +                                        dat_entry->data, dat_entry->mac_addr,
>> +                                        last_seen_mins, last_seen_secs);
>> +                             break;
>> +#endif
>>                       }
>>               }
>>               rcu_read_unlock();
>> diff --git a/types.h b/types.h
>> index 284e3d2..74c7091 100644
>> --- a/types.h
>> +++ b/types.h
>> @@ -931,10 +931,14 @@ struct batadv_dat_entry {
>>
>>  /**
>>   * batadv_dat_types - types used in batadv_dat_entry for IP
>> - * @BATADV_DAT_IPv4: IPv4 address type
>> + * @BATADV_DAT_IPV4: IPv4 address type
>
> I guess this is a mistake. In the last version of your last patch you are using
> IPV4 and therefore it is impossible that you have IPv4 here (or maybe you forgot
> to fix this comment...in this case, this fix should go direclty in the previous
> patch).
>

Don't know what happened here. Maybe by mistake I introduces this when
I merged it with the old code used for snooping.

>> + * @BATADV_DAT_IPV4: IPv6 address type
>>   */
>>  enum batadv_dat_types {
>>       BATADV_DAT_IPV4 = 0,
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +     BATADV_DAT_IPV6 = 1,
>> +#endif
>>  };
>>
>>  /**
>> --
>> 1.7.10.4
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara


Thanks,
Mihail
