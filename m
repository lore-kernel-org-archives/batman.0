Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA_JP8V9s__94xJP37wTmon8CJRANbsbpA1SBq9NVf6UEdFtYg@mail.gmail.com>
References: <CAA_JP8VT7ywrFo3-_R8C7SeQ8kBGWGaHOQR2J1Yx0-5F3LXd7A@mail.gmail.com>
 <744721D9-A7D7-4F59-93E2-ED4DA8939D53@altermundi.net>
 <CAA_JP8Vcez6R3aSHyrO7WRck3ucQV=BVCZYu9wXhvb=DKF8rBg@mail.gmail.com>
 <CAA_JP8V0gC60VhTjzcWLdAHw=HfbGaZgBTGrA+SGHAvSU+T1Gg@mail.gmail.com>
 <9478D395-E256-4B4C-9587-D476EF190AFB@altermundi.net>
 <CAA_JP8V9s__94xJP37wTmon8CJRANbsbpA1SBq9NVf6UEdFtYg@mail.gmail.com>
From: tjhowse <tjhowse@gmail.com>
Date: Thu, 16 Oct 2014 08:50:18 +1000
Message-ID: <CAAxzKbQGQiwq5SyiKa3kAVcCgLLBceN7vL3uMkgDzoqrOQ-FQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] good dual radio node?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

I've bought 20-odd WDR-3600 units and used them in a batman-adv mesh
in a dusty construction site for about three months. I've had zero
failures during that time. My only complaint with the hardware is that
it would be nice if the SMA antenna connectors were recessed a bit, as
the antenna protrudes quite a bit. But that is a minor trifle.
Otherwise they're great.

Note that not all "dual band" routers are created equal. Many are
advertised as dual band, but can only talk on one band or the other,
not both simultaneously. The WDR-3600 is a true dual band device. I
use the 5GHz radio for the mesh backbone between the routers, and
2.4GHz to clients.

On 16 October 2014 00:57, dan <dandenson@gmail.com> wrote:
> Gui, may I ask how you use the nodes?  Is it in production or just a hobby?
>
> I run a wireless ISP and I have a number of areas that no one has
> tried to get into because the traditional star topology wont work
> (valleys, heavily treed, lots of switchbacks).  I have enough people
> wanting service that I should be able to get at least 2 uplinks from
> any single node throughout these areas.  I've been trying to put
> together a dual radio mesh out of alix or routerboard hardware but I'm
> hitting $200 per node which is too much.  This TPLink looks like a
> good option, add an external enclosure and some 7-8dBi omnis should be
> under $100!
>
> I'm just not sure if these are 'production' quality, do you have any
> failure rate for these in an outdoor enclosure?
>
> On Wed, Oct 15, 2014 at 8:15 AM, Gui Iribarren <gui@altermundi.net> wrote:
>> Wdr3500 consumes about 3w to 5w, depending on traffic/cpu (no usb)
>> accepts input voltage up to 24v (undocumented)
>> Original PSU is 12v x 1a
>>
>> Wdr3600 does not accept 24v (we burned 1 out and we didn't try again)
>>
>> Mounted outdoors, on weatherproof enclosures.
>>
>> USB radios? Mmmh... been there, done that: Here Be Dragons. You've been warned (google "ath9k_htc issues") :)
>>
>> Cheers!
>>
>> On October 15, 2014 7:51:04 AM CDT, dan <dandenson@gmail.com> wrote:
>>>GUI, what's the input voltage?  and amperage on the power supply?
>>>
>>>On Wed, Oct 15, 2014 at 6:49 AM, dan <dandenson@gmail.com> wrote:
>>>> TL-WDR3500/TL-WDR3600 pretty interesting!  Also has USB, might take
>>>an
>>>> additional radio.
>>>>
>>>> Are you mounting these outdoors or indoor?
>>>>
>>>> These are cheap enough, I could do a 3 radio mesh +2.4Ghz hotspot....
>>>>
>>>> On Wed, Oct 15, 2014 at 1:55 AM, Gui Iribarren <gui@altermundi.net>
>>>wrote:
>>>>> Tplink wdr3500, we've deployed more than 100, running nice with
>>>barrierbreaker
>>>>> tplink wdr3600 is identical, but with gigabit ethernet
>>>>> in some places, one or the other will be easier to find
>>>(availability) and cheaper.
>>>>> Tplink wdr4300 is like wdr3600 but with 3x3 on one of the bands
>>>(5ghz IIRC) so it has an extra, single-band antenna
>>>>>
>>>>> HTH,
>>>>> cheers!
>>>>>
>>>>> On October 14, 2014 7:34:56 PM CDT, dan <dandenson@gmail.com> wrote:
>>>>>>Anyone have any recommendations for a good dual radio mesh node for
>>>>>>batman-adv that won't break the bank?  I'm looking at having wired
>>>>>>clients, but two mesh radios to keep throughput high.  802.11n
>>>radios
>>>>>>also required.
>>>>>>
>>>>>>Thanks!
>>>>>
>>
