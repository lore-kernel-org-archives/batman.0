Return-Path: <fboehm@aon.at>
Message-ID: <4F9CFB7F.4010207@aon.at>
Date: Sun, 29 Apr 2012 10:27:43 +0200
From: fboehm <fboehm@aon.at>
MIME-Version: 1.0
References: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
In-Reply-To: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Batman with Ubiquiti SDK
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Mitar,

what Ubiquiti products are you using? Because they have the older 
802.11a/b/g based product series and the newer 802.11n based with their 
proprietary Airmax wireless drivers. I am asking because the Airmax 
products have been upgraded to kernel 2.6.32 recently. Integrating 
Batman would be much easier now. Unfortunately the SDK is only available 
on request since some time.

Regards,
Franz

Am 29.04.12 01:56, schrieb Mitar:
> Hi!
>
> Ubiquiti provides OpenWrt based SDK for their firmware. To my
> information, it contains some proprietary madwifi-based WiFi drivers
> with some older OpenWrt version. My question is how it would be
> possible to run Batman on top of their firmware (thus not latest
> OpenWrt). As Batman is in kernel, is is enough kernel-backwards
> compatible to be able to run also on older (2.6) kernel versions? For
> olsrd it is much simpler: you just install olsrd package and this is
> it.
>
>
> Mitar
>

