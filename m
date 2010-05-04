Return-Path: <fboehm@aon.at>
Message-ID: <4BE014CC.50904@aon.at>
Date: Tue, 04 May 2010 14:36:28 +0200
From: =?ISO-8859-15?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
References: <201005030828.08856.lindner_marek@yahoo.de>	<201005041021.30248.lindner_marek@yahoo.de>	<4BE0014E.8080204@aon.at>
	<201005041340.07717.onelektra@gmx.net>
In-Reply-To: <201005041340.07717.onelektra@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] sysfs compat
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

Hi Elektra,

the problem lies somewhere else like mentioned earlier:

" ... Using open source drivers instead is not always an opinion because 
it's very hard to comply with radio regulations and get your product 
certified. ..."

You are right regarding the quality of binary drivers from chip 
suppliers. But if you pay lots of money for an SDK with outdated kernel 
:-) and with binary drivers included, the supplier should give you 
support for every problem their binary drivers create.

For example you will never ever get 100% source from Sigma Designs to 
debug their binary stuff because they mostly fear loosing their 
intellectual property.

Of course it's a different point of view if you are working on a 
commercial product or on a software project for some sort of community. 
In the first way you have to get your product certified. In the second 
way you want to prevent using binary drivers.

Regards,
Franz


elektra schrieb:
> Hello Franz -
> 
> as a comment: Whenever I used drivers from a chip manufacturer so far I had a 
> miserable experience. Basic features and most common applications usually 
> work, but thats it. Drivers are usually buggy and unmaintained. Particularly 
> ad-hoc mode support usually is theoretically there but practically broken. I 
> know of no proprietary vendor driver that works properly.
> 
> The fact that you are usually bound to a very old version of Linux is telling. 
> I only use / promote chips with decent open-source support. OpenWrt is 
> awesome.
> 
> Cheers,
> Elektra
> 
