Return-Path: <smartwires@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2561223.2KfdzXezWu@sven-edge>
References: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
 <2542365.bvxhBZAykN@lafayette> <2561223.2KfdzXezWu@sven-edge>
From: Daniel Ghansah <smartwires@gmail.com>
Date: Mon, 1 Jan 2018 11:33:11 -0500
Message-ID: <CAL3ir7KuUTmBkqbDjz4-4V4ee0uEnDWv0Vf_Bq1C_rJTRpkncg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] 11ac throughput on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

@ Marek
Thanks for your response.I am aware of the bugus 6 mbits display I was
referring the results of batctl tp
Should I be using iperf?
@Sven
Thanks for the explanation. I am going to ask a friend to make a build
with those patches for me. The CPU I have been using is a QCA9557
I also have a Gateworks GW5310 so I can do some comparisons and report
back my results. Should I be using iperf or is there something else
you would recommend for more accurate throughput values.

Daniel

On Mon, Jan 1, 2018 at 4:13 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Montag, 1. Januar 2018 13:12:53 CET Marek Lindner wrote:
> [...]
>> This is a known bug caused by the QCA WiFi driver firmware blob. The exported
>> TX bitrate value is utterly bogus. Only QCA is in the position to fix that.
>>
>> There have been attempts such as this one:
>>  https://github.com/torvalds/linux/commit/c1dd8016ae02557e4f3fcf7339865924d9357f76
>> Not sure this fix addresses your case. Sven might know.
>
> This only works for 10.4 firmware versions with peer stats enabled. The 10.2.4
> firmware versions (only some are actually supported) require following patchset:
>
> * https://patchwork.kernel.org/patch/10092915/
> * https://patchwork.kernel.org/patch/10092917/
> * https://patchwork.kernel.org/patch/10092919/
>
> And you need the patch mentioned by Marek (+ the patch referenced in it) to
> get any TX rate values at all.
>
> But QCA already knows that they (relatively often) still report completely
> bogus values (and only QCA can fix it). And you must understand that the
> values which you will get here are *a lot* higher than what you can
> realistically achieve via this link since the TX/RX data rates are actually
> physical data rates and not the throughput measured via TCP/UDP/... - or by
> looking at the payload of the actually transported (QoS) data packets.
>
> So let as assume for now that you will lose 50% of the physical data rate to
> some expected overhead. Then you might still have the problem that each packet
> has to be retransmitted 4 times (or more) before it can be received by the
> other end and the aggregation is 1. The TX/RX data rate information in iw will
> not capture anything of that.
>
> But there can also be a lot of other factors which influence the performance -
> maybe you CPU is not capable of handling the packet generation and
> transmission, the MTU is not configured properly on the slave device, the NIC
> might not be able to transmit a single flow to saturate the link, batman-adv's
> throughput meter might not handle some packet loss as well as expected, the
> qdisc (flow dissector) might fail to handle the batman-adv tp packets
> properly, ...
>
> Kind regards,
>         Sven



-- 
Regards,
Daniel Ghansah
305-801-4895
