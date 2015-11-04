Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56394500.5010701@viisauksena.de>
References: <CAFJkCXrOyDam2BHpUbcW9Qcd8ZBxOSbTeU6_kORkw6R3qELfLQ@mail.gmail.com>
 <56394500.5010701@viisauksena.de>
From: tjhowse <tjhowse@gmail.com>
Date: Thu, 5 Nov 2015 09:34:48 +1000
Message-ID: <CAAxzKbQuzL4ukMitOQwYErQm82wuPHO2QHiRLcG6OY_7mzfrbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Compiling for Beaglebone
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I second the compile-on-device approach. It adds a bit of complexity
to your development chain, but it's oh-so-much simpler. A few years
ago I spent a long while failing to get together all the requirements
for cross-compiling to a beaglebone. I gave up and was compiling on
the device within half an hour.

On 4 November 2015 at 09:36, jens <jens@viisauksena.de> wrote:
> hoi,
>
> ive done something similar for raspberry pi some days ago,
> also suggesting to build on thedevice directly ...
> see :
> http://viisauksena.de/blog/raspberry-pi-und-freifunk-freiburg-or-batman-adv-mesh-network/
> and maybe https://cccfr.de/wiki/freifunk:debian
>
> greetz, jens
>
> On 03.11.2015 13:05, Justin Oursler wrote:
>> Hello,
>>
>> Can someone help get me started in cross-compiling batman-adv and
>> batctl?  Specifically, I'm wanting to run it on a Beaglebone running
>> Debian (http://beagleboard.org/project/debian/).  I already have the
>> arm-gnueabihf toolchain.
>>
>> Thanks,
>>
>> Justin
>
> --
> make the world nicer, please use PGP encryption
>
