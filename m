Return-Path: <gui@altermundi.net>
In-Reply-To: <CAA_JP8V0gC60VhTjzcWLdAHw=HfbGaZgBTGrA+SGHAvSU+T1Gg@mail.gmail.com>
References: <CAA_JP8VT7ywrFo3-_R8C7SeQ8kBGWGaHOQR2J1Yx0-5F3LXd7A@mail.gmail.com>
 <744721D9-A7D7-4F59-93E2-ED4DA8939D53@altermundi.net>
 <CAA_JP8Vcez6R3aSHyrO7WRck3ucQV=BVCZYu9wXhvb=DKF8rBg@mail.gmail.com>
 <CAA_JP8V0gC60VhTjzcWLdAHw=HfbGaZgBTGrA+SGHAvSU+T1Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
From: Gui Iribarren <gui@altermundi.net>
Date: Wed, 15 Oct 2014 09:15:15 -0500
Message-ID: <9478D395-E256-4B4C-9587-D476EF190AFB@altermundi.net>
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
To: dan <dandenson@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Wdr3500 consumes about 3w to 5w, depending on traffic/cpu (no usb)
accepts input voltage up to 24v (undocumented)
Original PSU is 12v x 1a

Wdr3600 does not accept 24v (we burned 1 out and we didn't try again)

Mounted outdoors, on weatherproof enclosures.

USB radios? Mmmh... been there, done that: Here Be Dragons. You've been warned (google "ath9k_htc issues") :)

Cheers!

On October 15, 2014 7:51:04 AM CDT, dan <dandenson@gmail.com> wrote:
>GUI, what's the input voltage?  and amperage on the power supply?
>
>On Wed, Oct 15, 2014 at 6:49 AM, dan <dandenson@gmail.com> wrote:
>> TL-WDR3500/TL-WDR3600 pretty interesting!  Also has USB, might take
>an
>> additional radio.
>>
>> Are you mounting these outdoors or indoor?
>>
>> These are cheap enough, I could do a 3 radio mesh +2.4Ghz hotspot....
>>
>> On Wed, Oct 15, 2014 at 1:55 AM, Gui Iribarren <gui@altermundi.net>
>wrote:
>>> Tplink wdr3500, we've deployed more than 100, running nice with
>barrierbreaker
>>> tplink wdr3600 is identical, but with gigabit ethernet
>>> in some places, one or the other will be easier to find
>(availability) and cheaper.
>>> Tplink wdr4300 is like wdr3600 but with 3x3 on one of the bands
>(5ghz IIRC) so it has an extra, single-band antenna
>>>
>>> HTH,
>>> cheers!
>>>
>>> On October 14, 2014 7:34:56 PM CDT, dan <dandenson@gmail.com> wrote:
>>>>Anyone have any recommendations for a good dual radio mesh node for
>>>>batman-adv that won't break the bank?  I'm looking at having wired
>>>>clients, but two mesh radios to keep throughput high.  802.11n
>radios
>>>>also required.
>>>>
>>>>Thanks!
>>>

