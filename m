Return-Path: <xbing6@gmail.com>
MIME-Version: 1.0
References: <CAG5qQ7j1FzdwTqcAPcG=tBp5YTFm4UiOgVdSuk0qL5-pT6KB+A@mail.gmail.com>
 <2200656.2eICcKID6T@bentobox>
In-Reply-To: <2200656.2eICcKID6T@bentobox>
From: Xuebing Wang <xbing6@gmail.com>
Date: Fri, 29 May 2020 12:42:10 +0800
Message-ID: <CAG5qQ7j+YwcoEeGnsGZUHtd1uBN8n+BEfYqm0zp5o1B4TsT_KA@mail.gmail.com>
Subject: Re: QoS over batman-adv
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <sw@simonwunderlich.de>

Hi Sven,

Thank you very much for your help. From air medium contention
perspective, 802.11e (part of 802.11-2007 and 802.11-2012) specifies 2
ways to support QoS:
-  EDCA (Enhanced distributed channel access)
-  HCCA (HCF Controlled Channel Access)

As Wi-Fi Alliance WMM (Wi-Fi Multimedia) requires EDCA, I assume ath9k
driver supports QoS (specifically EDCA) for infrastructure mode.

Any idea if anybody uses QoS (EDCA) on ath9k for IBSS which batman-adv
is based on? Thanks.

The reason I am exploring 802.11e is that we are running relatively
large batman-adv networks, and there can be multiple hops from node A
to node B, and I hope hops can quickly forward QoS traffic.

Xuebing Wang


On Mon, May 11, 2020 at 2:38 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Monday, 11 May 2020 05:33:39 CEST Xuebing Wang wrote:
> > Hi Simon and community,
> >
> > We have been using batman-adv on OpenWRT 15.05
> [...]
> > We are exploring the idea of QoS over batman-adv to transmit small
> > quantity of high priority data. Any suggestions? Thanks.
>
> First step: Update OpenWrt to something which is not EOL since many years.
> This will also update the batman-adv version to a version which is actually
> supported in openwrt-routing.
>
> And then you will get the dsfield or 802.1Q values propagated to the mac80211
> layer (as part of the priority field of the skbuff).
>
> If you want to have QoS on a higher layer (before it enters batman-adv) then
> just use the normal queuing disciplines of the Linux kernel.
>
> Kind regards,
>         Sven
