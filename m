Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <4FA916EB.8030609@universe-factory.net>
References: <4FA54C09.6000303@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
	<4FA7AD9B.2030604@universe-factory.net>
	<201205081404.14409.lindner_marek@yahoo.de>
	<4FA916EB.8030609@universe-factory.net>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Tue, 8 May 2012 17:52:18 -0300
Message-ID: <CAHD-aqKEcv0F7ZKL1xsXOj8k1ZvRM1YXvOYKadj44SUBPpff4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

>>> supply its own hostname for vis in my opinion. I think one possibility
>>> to add this without breaking compatiblity would be adding a hostname
>>> record after the neighbor entries in the vis packets.
>>
>> Flooding the network with arbitrary data like hostnames, service
>> announcements, weather info, etc comes up from time to time but it often boils
>> down to the question: Why does it have to be in the kernel ? There are several
>> ways to implement this feature in user space today without changing the kernel
>> code.
>>
>> Regards,
>> Marek
>
> I see your point, but then one could also ask why the visualization has
> to be in the kernel at all...

visualization just means collecting information batman is already handling.
neighbour information is essential to normal working, and generating a
"vd dot" just exports that info.
hostnames, (ip addresses, etc) on the other hand, are not of interest
to current code

That said, I would also love to find a solution to this, since
maintaining the /etc/bat-hosts in the nodes simply doesn't escalate in
my opinion,
and Marek' suggestion about "several ways to implement this feature in
user space today" is not entirely clear to me:
mDNS solutions like avahi translate between hostnames and ips, while
batman visualization deals with MACs, and those cannot necessarily be
obtained from IPs (in some cases, ARP will help, but won't work in
interfaces without IPs)

maybe i'm ignoring some MAC discovery protocol?

Cheers,

Guido
