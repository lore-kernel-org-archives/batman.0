Return-Path: <dandenson@gmail.com>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<20120331204322.GA31423@ritirata.org>
	<CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
	<CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
From: Dan Denson <dandenson@gmail.com>
In-Reply-To: <CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Date: Sat, 31 Mar 2012 20:53:41 -0600
Message-ID: <-6553061881251442485@unknownmsgid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

>
> That sounds like a nice start!
> I'm not sure, though, if that number includes retransmissions and/or
> unacknowledged frames.
> IIRC i think i've seen that TX number grow in an interface with such a
> lossy link that was just sending traffic (trying to reach the distant
> ap) but getting nothing in return (ap couldn't hear me)
>
> So far, with openwrt and ath9k / ath9k_htc, i've found the "tx
> bitrate" (or MCS level) a fair indicator of the link capacity.
> if it says "65.0 MBit/s MCS 7" i cannot tell exactly how much goodput
> it will have, but i can be pretty confident that it will be better
> than when it says "6.5 MBit/s MCS 1"

Good point on ifconfigs potential limitations.

One issue with using the wireless sync rate is that fresnel zone
infractions will allow you to sync at one rate but for the link to
fall apart as the throughput grows.  I have seen a 130Mb link degrade
to 54Mb as soon as it started passing significant traffic.
