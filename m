Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Network stops passing traffic randomly
References: <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
 <20200529001302.832.66710@diktynna.open-mesh.org>
 <174b4bab-d84e-899d-3ecf-34bfdccff4fd@coolheads.com>
From: Ben Greear <greearb@candelatech.com>
Message-ID: <8cb674e5-26b2-e992-61e6-5969cc50358f@candelatech.com>
Date: Tue, 2 Jun 2020 13:02:24 -0700
MIME-Version: 1.0
In-Reply-To: <174b4bab-d84e-899d-3ecf-34bfdccff4fd@coolheads.com>
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



On 06/01/2020 07:05 PM, Steve Newcomb wrote:
>
>
> On 5/28/20 8:13 PM, smartwires@gmail.com wrote:
>> Steve, I am also using ap with a QCA9558 SOC and Also using ath10k-firmware-qca988x . I have also considered using adhoc.
>
> I think I discovered something yesterday that explains everything, and it's very reproducible.  The mesh mode in the QCA firmware works reliably in the lab and in the field, but only when there are 3 or fewer nodes.  If I add one more node, the mesh will completely fail, either immediately or within a few hours.  If the nodes are strung out in a daisy chain, failure is usually, but not always, delayed for a while, and the links break in a piecemeal fashion, one at a time.  If the nodes are close enough to each other, total failure occurs quite quickly.  I surmise that the 802.11s implementation in the QCA driver was not tested with more than 3 nodes, or perhaps it wasn't designed to support more than 3 nodes.  Sigh.
>
> Sven, I think this epiphany obviates the need for your test (which I still haven't figured out how to execute in the field), but I'll return to that effort if you think I should.
>
> So in the end, unless I replace the hardware throughout the neighborhood with far more expensive hardware, I must find a way to use Ben's driver, or to have no mesh network with more than 3 nodes in it.

Have you tried using IPQ4019 based systems?  They seem pretty affordable, and the 3-radio Linksys MR8300 & EA8300 seem pretty stable
in my testing recently (in AP mode, not tested mesh).

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
