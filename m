Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130315115722.GI8563@ritirata.org>
References: <CAP5XTDM0KWS4c=0Z_KO=AdFh9rBDo_AOz553bstFk0FQRuWA0Q@mail.gmail.com>
 <20130315115722.GI8563@ritirata.org>
Date: Fri, 15 Mar 2013 15:19:22 +0200
Message-ID: <CAP5XTDMsHjgL0Mj8Wi8it+S=LU3qpC7enRyp570wrucOBaSczQ@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Modified DAT structures and
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

On 15 March 2013 13:57, Antonio Quartulli <ordex@autistici.org> wrote:
> On Sat, Mar 09, 2013 at 07:40:48PM +0200, Mihail Costea wrote:
>> Subject: [RFC] batman-adv: Modified DAT structures and functions in orde=
r
>>  to support both IPv4 and IPv6
>>
>> In order to support DHT for IPv6 there was needed a general implementati=
on for
>> the IP field in distributed-arp-table.c (now the IP is __be32 and this p=
atch
>> will transform it to unsigned char *). Distinction between types is done
>> using a new enum.
>>
>> Also all functions were changed to support this.
>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>
> Hi Mihail,
>
> thanks for this patch. Sorry for the late reply, but I required some time=
 to
> review it all :)
>
> As first concern I would say that we need some more #ifdef (not thrown in=
 the
> code, but placed in the right spots) to let the whole code work if somebo=
dy has
> disabled the IPv6 support in his kernel.

Thx for the info. I haven't thought about this. I'll think how it's
best to work with the IPv6 support.

> More comments inline
>
>>
>> ---
>>  distributed-arp-table.c |  234 ++++++++++++++++++++++++++++++++++++----=
-------
>>  types.h                 |   21 ++++-
>>  2 files changed, 197 insertions(+), 58 deletions(-)
>>
>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>> index 9215caa..ed6e817 100644
>> --- a/distributed-arp-table.c
>> +++ b/distributed-arp-table.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/if_ether.h>
>>  #include <linux/if_arp.h>
>>  #include <net/arp.h>
>> +#include <net/ipv6.h>
>>
>>  #include "main.h"
>>  #include "hash.h"
>> @@ -31,6 +32,36 @@
>>  #include "translation-table.h"
>>  #include "unicast.h"
>>
>> +/* Prints similar debug message for IPv4 and IPv6.
>> + * At list one variable parameter should be the IP itself, and it shoul=
d
>> + * be placed correctly based on format prefix and format suffix argumen=
ts.
>> + */
>> +#ifdef CONFIG_BATMAN_ADV_DEBUG
>> +
>> +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
>> +                            format_suffix, ...) \
>> +             { \
>> +             switch (ip_type) { \
>> +             case BATADV_DAT_IPv4: \
>> +                     batadv_dbg(BATADV_DBG_DAT, bat_priv, \
>> +                                format_prefix "%pI4" format_suffix, \
>> +                                     __VA_ARGS__); \
>> +                     break; \
>> +             case BATADV_DAT_IPv6: \
>> +                     batadv_dbg(BATADV_DBG_DAT, bat_priv, \
>> +                                format_prefix "%pI6c" format_suffix, \
>> +                                     __VA_ARGS__); \
>> +                     break; \
>> +             } \
>> +             }
>> +
>> +#else
>> +
>> +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
>> +                            format_suffix, ...) /* do nothing */
>
> in this case we prefer to write a stub function rather than an empty defi=
ne. In
> this way the type check can still work and report issues. See
> distributed-arp-table.h for an example.

Should both defines be functions or only the empty define?
It's not a big problem. It would be nice to play more with functions
with variable args too :).

>> +
>> +#endif /* CONFIG_BATMAN_ADV_DEBUG */
>> +
>>  static void batadv_dat_purge(struct work_struct *work);
>>
>>  /**
>> @@ -47,12 +78,14 @@ static void batadv_dat_start_timer(struct
>> batadv_priv *bat_priv)
>>  /**
>>   * batadv_dat_entry_free_ref - decrements the dat_entry refcounter and =
possibly
>>   * free it
>> - * @dat_entry: the oentry to free
>> + * @dat_entry: the entry to free
>>   */
>
> this is an example of change that should go in a separate patch as it is =
fixing
> a typo previously introduced.

ACK.

>>  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entr=
y)
>>  {
>> -     if (atomic_dec_and_test(&dat_entry->refcount))
>> +     if (atomic_dec_and_test(&dat_entry->refcount)) {
>> +             kfree(dat_entry->ip);
>>               kfree_rcu(dat_entry, rcu);
>> +     }
>
> mh, here we are mixing rcu freeing and not. it may be better to create a =
freeing
> function which take cares of freeing everything which will be set in this=
 point
> by means of call_rcu() (you can grep for call_rcu in translation-table.c =
to see
> how we use it).
>

Thx. I saw that if we use call_rcu() there's no need to use
kfree_rcu(), but only kfree().

>>  }
>>
>>  /**
>> @@ -130,18 +163,50 @@ static void batadv_dat_purge(struct work_struct *w=
ork)
>>  }
>>
>>  /**
>> + * batadv_sizeof_ip - gets sizeof IP based on its type (IPv4 / IPv6)
>> + * @ip_type: type of IP address
>> + *
>> + * Returns sizeof IP, or sizeof IPv4 if @ip_type is invalid
>
> no need to write the '@' here.
>
> [...]
>

ACK.

>>  /**
>> + * batadv_dat_types - types used in batadv_dat_entry for IP
>> + * @BATADV_DAT_IPv4: IPv4 address type
>> + * @BATADV_DAT_IPv6: IPv6 address type
>> + */
>> +enum batadv_dat_types {
>> +     BATADV_DAT_IPv4,
>> +     BATADV_DAT_IPv6,
>> +};
>
> Constants should be all capital letters (look at the 'v')
>

ACK.

>> +
>> +/**
>>   * struct batadv_dat_candidate - candidate destination for DAT operatio=
ns
>>   * @type: the type of the selected candidate. It can one of the followi=
ng:
>>   *     - BATADV_DAT_CANDIDATE_NOT_FOUND
>> --
>
> What is not entirely clear to me (I may have overlooked it) is how do the=
 two
> types of data interacts. If I am not wrong, you want to use the same tabl=
e for
> both data, but this will create problems when comparing a 16bytes long ip=
v6
> address with a 4bytes long ipv4 one. So you should assume that mixed comp=
are can
> happen and you should check the type of the two objects before going to t=
he real
> data compare.
>
> I think you are on the right track, but you should think a bit more how t=
o
> generalise your approach in order to account the case I described above.
>

About this I think we could use container_of or something similiar
maybe to get the whole dat_entry structure and then test if types are
equal.

> It would also be nice to generalise it such that you do not have to talk =
about
> IPs, but about "DHT data" and its len, which can then be whatever we woul=
d like.
> However this point might be something we want to discuss later...now you =
can
> focus on your patch assuming we want to store IPv4/6 only.
>

Good to know. I would prefer for this patch to keep it similar so  we
wouldn't lose time with understanding the patch again.

> Cheers,
>
> p.s. feel free to join our IRC channel (#batman at irc.freenode.org) for =
live
> discussions)
>
> Cheers=B2,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Thx a lot for the review. Monday I will send the update to the changes.
Should it be in this thread or a new thread?

Cheers,
Mihail
