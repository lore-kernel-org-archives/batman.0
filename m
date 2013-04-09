Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130409112843.GC3624@ritirata.org>
References: <CAP5XTDPvnsM_4Vd+y6DMSgLPEoRWGymi4drQKVeOyPuuVqU2gQ@mail.gmail.com>
 <20130409112843.GC3624@ritirata.org>
Date: Tue, 9 Apr 2013 16:13:01 +0300
Message-ID: <CAP5XTDPhyNpH1znY3w8xkgHeMX92P3chtj7OSAAz+CgEfvRXCw@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] DAT - possible bug at incoming ARP request
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

On 9 April 2013 14:28, Antonio Quartulli <ordex@autistici.org> wrote:
> Hi Mihail,
>
> On Tue, Apr 09, 2013 at 01:47:52PM +0300, Mihail Costea wrote:
>> Hi,
>>
>> In the file distributed-arp-table.c, function
>> batadv_dat_snoop_incoming_arp_request, after creation of ARP reply
>> (skb_new = arp_create(...)) and testing if the creation was
>> successful, shouldn't exist a call to skb_reset_mac_header(skb_new),
>> just like in batadv_dat_snoop_outgoing_arp_request?
>>
>> I've done something similar for NDP and I think that this is the line
>> that might generate a kernel panic (not sure yet, I might have to do
>> more testing).
>>
>> As I said, I'm not sure yet, and maybe my code might generate it. But
>> my question is why isn't here a skb_reset_mac_header as it is in the
>> first function.
>>
>
> skb_reset_mac_header() is invoked in batadv_send_skb_packet() right before
> accessing the ethernet header. This is where DAT needs it, no further accesses
> to the Ethernet header are done on its side.
>
> I'd say that invocation at distributed-arp-table.c:843 can probably be avoided
> (and there are
> other similar cases in the rest of the code...)
>
>
> skb_reset_mac_header() has to be invoked at the right moment in order to
> correctly set the skb->mac_header pointer. In batman-adv we do this when
> skb->data points at the beginning of the batman-adv header when we need to
> access the Ethernet header for some reasons.
>
> Be aware that some of the skb_* functions do invoke skb_reset_mac_header() on
> their own (e.g. eth_type_trans).
>
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Understood. Thanks.


--
Mihail Costea
