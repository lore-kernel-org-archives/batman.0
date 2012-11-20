Return-Path: <surfbytes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20121120092421.GC3129@ritirata.org>
References: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
 <75191138.5RcUHhBkvt@bentobox> <20121120092421.GC3129@ritirata.org>
Date: Tue, 20 Nov 2012 15:37:17 -0800
Message-ID: <CAG_HyLwVWZdkDqxEDfDQL0k35UHeNrAOaVqKYJsMeN4VkWucHQ@mail.gmail.com>
From: Randy Graham <surfbytes@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] batman over 802.15.4 .
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
To: b.a.t.m.a.n@lists.open-mesh.org

Thanks for all of your replies, you have answered my questions !

It seems that batman-adv is not suitable for a 802.15.4 mesh network,
so I guess I'll need to look elsewhere.

Does anyone know of a non-proprietary mesh network stack for 802.15.4 on linux ?
I know that zigbee has not made into the kernel due to GPL issues.

Thanks again for your help.

-Randy


On Tue, Nov 20, 2012 at 1:24 AM, Antonio Quartulli <ordex@autistici.org> wrote:
> On Tue, Nov 20, 2012 at 09:27:39AM +0100, Sven Eckelmann wrote:
>> On Monday 19 November 2012 20:25:34 Randy Graham wrote:
>> [...]
>> > 1. Will batman-adv work over 802.15.4 ?
>> [...]
>> > 2. Can batman-adv work with either of these interfaces ?
>> >
>> > I tried configuring these interfaces using 'batctl' but it complains
>> > that they are an unsupported type.
>> > 'iwconfig' reports these interfaces as having 'no wireless extensions'
>> > which I suspect is the issue.
>>
>> No, batman-adv works on 802.3 compatible interfaces (aka ARPHRD_ETHER) which
>> provide special mac behaviour. This has nothing to do with the wireless
>> extensions (which are deprecated anyway).
>>
>> > Please let me know if running b.a.t.m.a.n. over 802.15.4 is feasible.
>>
>> 802.15.4 has the type ARPHRD_IEEE802154 for its fake hard interfaces. So you
>> need an "ethernet emulation" layer on top of it to use it with batman-adv. I
>> don't know whether the mac layer works well enough in theory to be used with
>> batman-adv.
>
>
> And other than these technical details, I would say that batman-adv is not a
> very good protocol for 802.15.4/low-power wireless. It might need heavy
> restructuring if you really want to use it in a deployment.
>
> However, I'm pretty familiar with 802.15.4, therefore if you really want to go
> ahead, we can even discuss further what batman-adv would need and what would
> not.
>
> Regards,
>
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
