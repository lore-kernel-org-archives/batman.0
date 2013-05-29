Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130526140240.GO1679@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-3-git-send-email-mihail.costea2005@gmail.com>
 <20130526140240.GO1679@ritirata.org>
Date: Wed, 29 May 2013 08:36:50 -0700
Message-ID: <CAP5XTDOc8iDYQNLbY9f1=07eifGWMZD2xYqvPF+VLxk4M5M43g@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 3/4] batman-adv: added necessary functions
 for NDP,
 like checking if a packet is valid or creating a Neighbor Advertisement
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

On 26 May 2013 07:02, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, May 17, 2013 at 03:27:51PM +0300, Mihail wrote:
>> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>>
>> Added functions needed for NDP snooping, like getting the IPv6 addresses
>> or getting the target HW address from an Neighbor Advertisement (NA).
>> Also added functions to create NA for Neighbor
>> Solicitations that have already the HW address in DAT.
>>
>> Problems: I have to generate router and override flags for NA. For now
>> I don't now exactly how to get them. From what I've seen, batman could
>> now which nodes are routers, but for override flag, we should find a
>> mechanism to know if the node is proxy or has anycast address.
>> For inspiration I have used the code at: <net/ipv6/ndisc.c>.
>
> What is the concept you have in mind?
> Maybe you first explain a bit more about your idea so that we can help you in
> find a way to implement that.
>
> You want to edit the router address and flags carried by the NA?
>

When creating the NA response for an HW address already contained in
the DAT, I must set 3 flags: router, solicited and override.

The solicited flag is 1 because I only answer to solicited NS.

The router flag should be 1 only if the device for which we have the
HW address is a router. From what I've seen there are some functions
in batatv for finding routers, but I'll have to see if they can be
used on the nodes connected to mesh-nodes. Or maybe there is another
way to see if the device is a router.

About the override flag, I don't really have an idea. I didn't
understand very well how it was calculated in net/ipv6/ndisc.c so I
set it to 1 by default (it should be 0 for proxy and anycast address).

> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Thanks,
Mihail
