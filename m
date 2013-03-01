Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130301110809.GC20607@ritirata.org>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
 <20130301110809.GC20607@ritirata.org>
Date: Fri, 1 Mar 2013 13:38:43 +0200
Message-ID: <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Implement DAT for IPv6
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

On 1 March 2013 13:08, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, Mar 01, 2013 at 12:59:18PM +0200, Mihail Costea wrote:
>> Hi,
>>
>> I've started implementing DAT for IPv6 and I have a few questions
>> regarding the design.
>> I've already implemented a snooping mechanism for Network Solicitation
>> package, but now I have to add it to the ipv6 distributed table.
>> I'm also a beginner in kernel programming so any help would be useful.
>>
>> From what I've seen there is a lot of code in distributed-arp-table.c
>> that could be used for ipv6 distributed table.
>
> yeah, I think that the table handling and DHT primitives can be reused for IPv6
> (they were designed on purpose).
>
>> A problem in using that code, from what I've seen, is the fact that
>> <struct batadv_dat_entry > has a field for ip with only 32 bits
>> (__be32).
>
> Yes, here a way to generalise the structure is needed.
>
>>
>> So I was thinking to make it more general by:
>> 1. transforming that into a pointer (unsigned char *ip) and add a
>> field size which will represent the total size of the ip.
>> The ip itself would be allocated dynamically.
>> 2. use a union with both _be32 / struct in6_addr. In this case the
>> problem is that if we use ipv4 then all the other space for struct
>> in6_addr would be wasted.
>
> correct. and for point 2) I think we waste a not negligible amount of memory..
>
>>
>> The second problem from what I've seen in the code is that the
>> batadv_priv->dat field is hardcoded.
>> For ipv6 we would need a new field to memorize the table, but I don't
>> think it's a really hard problem to solve in order to make it general.
>>
>
> I did not get the problem with the dat field?
> Can't you use the same table to store both IPv4 and IPv6? The DHT is made to
> store general data, so I think (with the suggestions you wrote above) that you
> should be able to use one table only.
>

I think it can be reuse. If I understood well the DHT has buckets for
each entry, so it shouldn't be a problem if
the IPv6 hash collides with the IPv4 hash.
I just thought that they should be separated because because they are
different concepts.
This makes it a lot more easier :).

>> This solution would be to avoid code duplicate. Off course, I could
>> still write all the code in parallel just for IPv6, but I think that a
>> common base would be useful.
>>
>
> Re-use code is definitely the way to go :) easy maintenance later, one single
> point for bug-fixing and code has been tested already (so it should work[tm] as
> expected :-))
>
>> Thanks,
>
> no worries :)
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
