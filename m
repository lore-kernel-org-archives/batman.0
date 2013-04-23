Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130422184428.GE5732@ritirata.org>
References: <1366629138-28627-1-git-send-email-mihail.costea2005@gmail.com>
 <20130422184428.GE5732@ritirata.org>
Date: Tue, 23 Apr 2013 09:34:24 +0300
Message-ID: <CAP5XTDNRthPWe508fhV_O26g9ndH=D3Dj2Sr=_d=uFOGQcguJA@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH] Added generic transformer to string
 function for DAT data
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

On 22 April 2013 21:44, Antonio Quartulli <ordex@autistici.org> wrote:
> Hi Mihail,
>
> You should first send the patch introducing the dat_entry->type field,
> otherwise this one cannot apply..
> Then please add a few lines commit message describing what this patch is
> bringing and why it would be nice to have this new function (e.g. talk about
> future uses with many dat_entry types..).
>
> However I put some comments inline
>

I wanted to keep the dat_entry->type for the second patch when I'll
have to modify all the functions (some need type in the function
signature).

As it is, the patch can be applied because it uses BATADV_DAT_IPV4
directly,but that will need to be modified in the second patch.
This patch contains the BATADV_DAT_IPV4 introduced too in types.h.

It might be better to have dat_entry->type introduced here and have
dat_entry->type = BATADV_DAT_IPV4 in batadv_dat_entry_add. Then use
type member only in batadv_dat_data_to_str. Still only 2 calls are
going to use it directly (2 of them, the last ones, because they don't
operate directly on dat_entry data).

Should all of this be defined in the same patch? Still type is not
really used here a lot (only for 2 batadv_dat_data_to_str calls).

> On Mon, Apr 22, 2013 at 02:12:18PM +0300, YourName wrote:
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
>> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>>
>> ---
>>
>>  distributed-arp-table.c |   71 +++++++++++++++++++++++++++++++++++++++++------
>>  types.h                 |    8 ++++++
>>  2 files changed, 70 insertions(+), 9 deletions(-)
>>
>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>> index 3a3e1d8..5df8f19 100644
>> --- a/distributed-arp-table.c
>> +++ b/distributed-arp-table.c
>> @@ -34,6 +34,36 @@
>>  static void batadv_dat_purge(struct work_struct *work);
>>
>>  /**
>> + * batadv_dat_data_to_str: transforms DAT data to string
>> + * @data: the DAT data
>> + * @type: type of data
>> + *
>> + * Returns the string representation of data. This should be freed with kfree.
>> + */
>> +static char *batadv_dat_data_to_str(void *data, uint8_t type)
>> +{
>> +     size_t buf_size;
>> +     char *buf, *format_type, ipv4[] = "%pI4";
>
> char ipv4[] should instead be const char *ipv4. However, I think a more general
> approach should be nice. Look at sysfs.c:46 for an example. In that case we have
> an array of strings where for a given item with value 0, you find its
> string representation exactly at index 0. For DAT it may be the same:
>
> if you do something like
>
> enum batadv_dat_types {
>         BATADV_DAT_IPV4  = 0,
>         BATADV_DAT_CHACHA = 1,
> };
>
> then you can have an array of strings where you can put the format to use with
> Ipv4 exactly at poistion 0 and the format to use for CHACHA at position 1:
>
> static char *batadv_dat_types_str_fmt[] {
>         "%pI4",
>         "%chacha",
> }
>
> This makes the code easier to be read by other people and also easy to be
> improved in the future.
>

This is a very good approach. Good to know :).

>> +
>> +     switch (type) {
>> +     case BATADV_DAT_IPV4:
>> +             /* maximum length for an IPv4 string representation + NULL */
>> +             buf_size = 16;
>> +             format_type = ipv4;
>> +             break;
>> +     default:
>> +             return NULL;
>> +     }
>> +
>
> If you use the same approach for the buf_size (another static array, say
> batadv_dat_type_str_len) then you can get rid of this switch (which otherwise
> would grow continuously as soon as we add new types) and use a couple of lines
> only.
>
>> +     buf = kmalloc(buf_size, GFP_ATOMIC);
>> +     if (!buf)
>> +             return NULL;
>> +     snprintf(buf, buf_size, format_type, data);
>> +
>> +     return buf;
>> +}
>
> for what concern the buffer, what do you think about using an approach similar
> to inet_ntop() ? Instead of allocating a buffer inside (which may fail as you
> correctly handled) the function could receive a buffer and its len directly from
> outside and use it (and return it). In this way you could easily put this
> function directly into a batadv_dbg().
>
> E.g.:
>
> *batadv_dat_data_to_str(data, type, buf, buf_len) {
>         /* play with buf and ensure we don't exceed buf_len  */
>         return buf;
> }
>
> ...
> char buf[20];
> ...
> batadv_dbg(BATADV_DBG_DAT, bat_priv, "this and that %s\n",
>            batadv_dat_data_to_str(data, type, buf, sizeof(buf)));
> ...
>
> I think the code using batadv_dat_data_to_str() will become smaller and easier,
> no?
>

In this case we need a #define for buffer size. Maybe something like
BATADV_DAT_DATA_MAX_LEN. This should be updated to the maximum length
of any possible data. I think this should be in
distributed-arp-table.h.
I opted for kmalloc because IPv4 has maximum 16 chars, IPv6 something
like 40, an some might have even more. But without kmalloc, just as
you said, the code is simpler when batadv_dat_data_to_str is called.

>> +
>> +/**
>>   * batadv_dat_start_timer - initialise the DAT periodic worker
>>   * @bat_priv: the bat priv with all the soft interface information
>>   */
>> @@ -272,6 +302,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
>>  {
>>       struct batadv_dat_entry *dat_entry;
>>       int hash_added;
>> +     char *dbg_data;
>>
>>       dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
>>       /* if this entry is already known, just update it */
>> @@ -279,9 +310,15 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
>>               if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
>>                       memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
>>               dat_entry->last_update = jiffies;
>> -             batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> -                        "Entry updated: %pI4 %pM\n", &dat_entry->ip,
>> -                        dat_entry->mac_addr);
>> +
>> +             dbg_data = batadv_dat_data_to_str(&dat_entry->ip,
>> +                                               BATADV_DAT_IPV4);
>> +             if (dbg_data) {
>> +                     batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> +                                "Entry updated: %s %pM\n", dbg_data,
>> +                                dat_entry->mac_addr);
>> +                     kfree(dbg_data);
>> +             }
>>               goto out;
>>       }
>>
>> @@ -304,8 +341,13 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
>>               goto out;
>>       }
>>
>> -     batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
>> -                &dat_entry->ip, dat_entry->mac_addr);
>> +     dbg_data = batadv_dat_data_to_str(&dat_entry->ip, BATADV_DAT_IPV4);
>> +     if (dbg_data) {
>> +             batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> +                        "New entry added: %s %pM\n", dbg_data,
>> +                        dat_entry->mac_addr);
>> +             kfree(dbg_data);
>> +     }
>>
>>  out:
>>       if (dat_entry)
>> @@ -527,6 +569,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
>>       int select;
>>       batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
>>       struct batadv_dat_candidate *res;
>> +     char *dbg_data;
>>
>>       if (!bat_priv->orig_hash)
>>               return NULL;
>> @@ -538,9 +581,13 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
>>       ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
>>                                                   BATADV_DAT_ADDR_MAX);
>>
>> -     batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> -                "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
>> -                ip_key);
>> +     dbg_data = batadv_dat_data_to_str(&ip_dst, BATADV_DAT_IPV4);
>> +     if (dbg_data) {
>> +             batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> +                        "dat_select_candidates(): IP=%s hash(IP)=%u\n",
>> +                        dbg_data, ip_key);
>> +             kfree(dbg_data);
>> +     }
>>
>>       for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
>>               batadv_choose_next_candidate(bat_priv, res, select, ip_key,
>> @@ -572,12 +619,18 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
>>       struct batadv_neigh_node *neigh_node = NULL;
>>       struct sk_buff *tmp_skb;
>>       struct batadv_dat_candidate *cand;
>> +     char *dbg_data;
>>
>>       cand = batadv_dat_select_candidates(bat_priv, ip);
>>       if (!cand)
>>               goto out;
>>
>> -     batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
>> +     dbg_data = batadv_dat_data_to_str(&ip, BATADV_DAT_IPV4);
>> +     if (dbg_data) {
>> +             batadv_dbg(BATADV_DBG_DAT, bat_priv,
>> +                        "DHT_SEND for %s\n", dbg_data);
>> +             kfree(dbg_data);
>> +     }
>>
>>       for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
>>               if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
>> diff --git a/types.h b/types.h
>> index b2c94e1..3488528 100644
>> --- a/types.h
>> +++ b/types.h
>> @@ -980,6 +980,14 @@ struct batadv_dat_entry {
>>  };
>>
>>  /**
>> + * batadv_dat_types - types used in batadv_dat_entry for IP
>> + * @BATADV_DAT_IPv4: IPv4 address type
>> + */
>> +enum batadv_dat_types {
>> +     BATADV_DAT_IPV4,
>> +};
>> +
>
> if you use the approach I proposed above, remember to assign values to the enum
> constants (at least tot he first) so to ensure they have the values you want.
>
>> +/**
>>   * struct batadv_dat_candidate - candidate destination for DAT operations
>>   * @type: the type of the selected candidate. It can one of the following:
>>   *     - BATADV_DAT_CANDIDATE_NOT_FOUND
>> --
>> 1.7.10.4
>
> Thanks a lot so far!
> If you have any question, comment or whatever feel free to interact with us on
> the batman-adv IRC channel (#batman @ freenode)!
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
