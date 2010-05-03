Return-Path: <fboehm@aon.at>
Message-ID: <4BDE91F3.4010209@aon.at>
Date: Mon, 03 May 2010 11:05:55 +0200
From: =?ISO-8859-1?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
References: <201005030828.08856.lindner_marek@yahoo.de>
	<20100503080301.GE10849@lunn.ch>
In-Reply-To: <20100503080301.GE10849@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Also all Atheros based systems with binary drivers from Atheros itself 
or SDK's from third party vendors only work with particular (quite old) 
kernel versions. Perhaps you are able to build with newer kernel but 
it's much more difficult to get support from the chip manufacturer this way.

Using open source drivers instead is not always an opinion because it's 
very hard to comply with radio regulations and get your product 
certified. This is why I think it's somehow also important for BATMAN to 
support older kernels.

This problem also applies to Sigma Designs, Texas Instrument and all 
other Multimedia-SOC vendors but there will seldom be BATMAN on non 
wireless systems like this :-)

Franz


Andrew Lunn schrieb:
>> At some point we have to start thinking about how many versions we
>> want to support. Each new kernel brings more changes which need to
>> be dealt with.  Right now, the required effort is still at a
>> sustainable level but the gap is growing. On one hand it is a nice
>> playground to expand our knowledge about macros and demonstrate what
>> nasty things you can do (see the second patch as an example).  ;-)
>> On the other hand it always requires a serious amount of time and
>> effort. It only makes sense if at least some people are using
>> it. Opinions ?
> 
> I guess the problem here is devices which cannot use modern kernels.
> 
> Why can a device not use a modern kernel?
> 
> 1) Binary only drivers which work only for a specific kernel. I guess
>    the biggest problem here is broadcom devices? What is the current
>    state here? How good is the native linux broadcom driver? Are there
>    other chipsets without an open driver?
> 
> 2) The need to use a vendor kernel since the mainline kernel does not
>    have the necessary support. How big a problem is this?
> 
> What other reasons are there not to use a modern kernel?
> 
>    Andrew
>     
> 
