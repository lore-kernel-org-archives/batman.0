Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130526135925.GN1679@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <20130526135925.GN1679@ritirata.org>
Date: Wed, 29 May 2013 07:54:59 -0700
Message-ID: <CAP5XTDOWASv9LoaOYgr+hT2ygUwkD9kinbhe5dK5JUdF5tW2Bw@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 1/4] batman-adv: renamed
 batadv_dat_snoop_*_arp_* functions to batadv_dat_snoop_*_msg_*
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

Sorry for answering this late. But I gain access to a PC just now
after the flight.

On 26 May 2013 06:59, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, May 17, 2013 at 03:27:49PM +0300, Mihail wrote:
>> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>>
>> Renamed snooping functions in order to suggest that they should work on
>> more protocols than ARP.
>
> You are introducing the change now, therefore I'd rather speak using simple
> present instead of past (at least this is what we usually do in all the
> commits...same applies for the subject).
>

ACK

>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
>> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>>
>> ---
>>  distributed-arp-table.c |   16 ++++++++--------
>>  distributed-arp-table.h |   16 ++++++++--------
>>  routing.c               |   12 ++++++------
>>  soft-interface.c        |    6 +++---
>>  4 files changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
>> index af670d3..b2ca7e0 100644
>> --- a/distributed-arp-table.c
>> +++ b/distributed-arp-table.c
>> @@ -978,7 +978,7 @@ out:
>>  }
>>
>>  /**
>> - * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try to
>> + * batadv_dat_snoop_outgoing_msg_request - snoop the ARP request and try to
>
> To be honest I do not really like this new naming schema..but I have no better
> idea now :)
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

It could be batadv_dat_snoop_outgoing_pkt_request, with pkt from
packet. That's the only other idea I have.

--
Mihail Costea
