Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201008121233.46032.lindner_marek@yahoo.de>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTik9JYyRM4UO2RLvm4NfhaDmnLEHamo8kKLV4RnB@mail.gmail.com>
	<AANLkTimJ1u9ZrrOyD1k_nNzfq-H+AhbAFNm4w4dhnBy2@mail.gmail.com>
	<201008121233.46032.lindner_marek@yahoo.de>
Date: Thu, 12 Aug 2010 13:41:41 +0300
Message-ID: <AANLkTi=nX3JGXjpZRT9O5qf=TKMqxLWB+mazWAeD4wsF@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Nat Question
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

I originally had my MTU values set incorrectly, but believe i have
them correct now

router with internet

ath0 - MTU 1524 (physical wifi device)
bat0 - MTU 1500
br-lan - MTU 1500 (bridged with bat0/eth1)
wifi0 - MTU 1500 (should this be 1524 also)

router on otherside of mesh

ath0 - MTU 1524 (physical wifi device)
bat0 - MTU 1500
br-lan - MTU 1500
wifi0 - MTU 1500 (should this be 1524 also)

I am aware that it is quite an old verison, although this is the
version that is currently in the openwrt repo. I will compile a more
recent version once i have the basics working i think.

Thanks for you help so far guys, two people have suggested MTU issues
now, so fingers crossed someone can see something wrong with the
output above?

On Thu, Aug 12, 2010 at 1:33 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Thursday 12 August 2010 12:16:29 David Beaumont wrote:
>> nexthops .. . [B.A.T.M.A.N. Adv 0.1 rv1176, MainIF/MAC:
>
> FYI: You use a very old version of batman-adv ...
>
>
>> Pings work fine, a wget just pauses and waits indefinitely
>
> That sounds like a MTU problem. What is the mtu of your wifi interfaces ? Here
> is a document describing the issue:
> http://www.open-mesh.org/wiki/batman-adv-quick-start-guide
>
> Cheers,
> Marek
>
