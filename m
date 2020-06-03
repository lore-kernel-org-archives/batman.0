Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Network stops passing traffic randomly
References: <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
 <20200529001302.832.66710@diktynna.open-mesh.org>
 <174b4bab-d84e-899d-3ecf-34bfdccff4fd@coolheads.com>
 <8cb674e5-26b2-e992-61e6-5969cc50358f@candelatech.com>
 <f99daabf-2081-c6af-779d-580f8d352b59@coolheads.com>
 <92655f2e-4ec4-5e1b-4ea9-b1df87a88aac@candelatech.com>
 <c917d6e6-d3c1-61f5-1846-794f6cc06824@coolheads.com>
From: Ben Greear <greearb@candelatech.com>
Message-ID: <3659b31b-1f8b-1e21-43f5-b47f6e11d338@candelatech.com>
Date: Wed, 3 Jun 2020 09:42:45 -0700
MIME-Version: 1.0
In-Reply-To: <c917d6e6-d3c1-61f5-1846-794f6cc06824@coolheads.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: srn@coolheads.com, b.a.t.m.a.n@lists.open-mesh.org, smartwires@gmail.com



On 06/03/2020 08:35 AM, Steve Newcomb wrote:
>
>
> On 6/3/20 8:48 AM, Ben Greear wrote:
>> I'm working with the TIP project, which aims to provide stable OpenWrt capable hardware, among lots of other things.
>>
>> I know some others in that group are interested in low cost solutions, so curious to know what price you think is
>> viable for your market...
>>
>> https://telecominfraproject.com/wifi/
>
> Ben, your question is appropriately industrial, but I've already given my answer, which is: "Less is more."  The lower the price, the more human capital is protected from the abyss of the digital divide.
>
> True, the primary problem is not so much the one-time cost of a cheap radio.  However, one way to address the primary problem is to give public-spirited digital-haves a way to lift up their digital-have-not neighbors.  With mesh computing, that means purchasing multiple routers and making gifts of at least one of them, along with the gift of access.  What can the digital-haves afford to give, besides access?  Typically, not much.
>
> What follows is a rant.  Advice: skip it.

If you are trying to lift up a broad swath of the world, then you need scale and vision, and part of that is how
to make it self sustaining.  Giving a few crumbs to folks is less useful in my mind than helping give them the means
to make their own bread.  Think someone starting a company that wants to deploy 10k hotspots with 40k satellite
wifi mesh nodes....

Open source software (and maybe hardware) with high volume, affordable, and solid hardware
is one of the core aims of TIP.  Think of a price and minimum hardware that meets your goals,
if I find someone that can make such a thing at such a price, I'll let you know.

If you want wave-1 ath10k to mesh, my advice is to use 7 virtual station vdevs and one AP on each radio.  ath10k-ct
firmware and software will support this nicely.  Have those 7 stations connect to peers' AP vdevs.  Do routing mesh
magic through this topology.  Then you don't care about anything other than STA + AP working.  This might also scale to other platforms
that don't support IBSS or MESH well.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
