Return-Path: <martin@hundeboll.net>
Message-ID: <4FAA970F.7080901@hundeboll.net>
Date: Wed, 09 May 2012 18:10:55 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <4FA54C09.6000303@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
	<4FA7AD9B.2030604@universe-factory.net>
	<201205081404.14409.lindner_marek@yahoo.de>
	<4FA916EB.8030609@universe-factory.net>
	<CAHD-aqKEcv0F7ZKL1xsXOj8k1ZvRM1YXvOYKadj44SUBPpff4g@mail.gmail.com>
In-Reply-To: <CAHD-aqKEcv0F7ZKL1xsXOj8k1ZvRM1YXvOYKadj44SUBPpff4g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
 without neighbors on the primary interface
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

Hi Guido,

On 05/08/2012 10:52 PM, Guido Iribarren wrote:
> mDNS solutions like avahi translate between hostnames and ips, while
> batman visualization deals with MACs, and those cannot necessarily be
> obtained from IPs (in some cases, ARP will help, but won't work in
> interfaces without IPs)
>
> maybe i'm ignoring some MAC discovery protocol?

While reading about TLV's on wikipedia[1], I came across a MAC discovery protocol[2], LLDP, which eventually lead me to OpenLLDP[3]. If this also works on 802.11, I think we have a winner :)

Happy hacking!

[1] http://en.wikipedia.org/wiki/Type-length-value
[2] http://en.wikipedia.org/wiki/Link_Layer_Discovery_Protocol
[3] http://openlldp.sourceforge.net/

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
