Return-Path: <gui@altermundi.net>
Message-ID: <53B20803.6010005@altermundi.net>
Date: Mon, 30 Jun 2014 21:59:47 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <E1X1lN3-00041p-KL@fudo.makrotopia.org>
In-Reply-To: <E1X1lN3-00041p-KL@fudo.makrotopia.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Need a recommendation for a USB wifi dongle that
 is known to work with batman.
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

On 30/06/14 20:52, Daniel wrote:
> hi
> 
> On Jun 30, 2014 11:45 PM, cmsv <cmsv@wirelesspt.net> wrote:
>>
>> Tp-Link TL-WN 722 N works but has nothing to do with batman-adv. The 
>> support comes from openwrt or whatever linux distro one wants to use.
> 
> ...with up to 7 ad-hoc peers or ap clients associated and no more, due to firmware limitations of the ath9k_htc chipset... and yes, this applies to all ath9k_htc-based dongles. sorry to name a chipset and not a product name, but i got no idea what products are available in the markets around you. i'd go with something containing rt2800usb if it really got to be usb wifi (which generally should be avoided imho). performance is not great, but at least it works.
> 

+1, we had mild success with those dongles (tl-wn722n = ath9k_htc),
since the limitations don't become apparent in small meshes (~5 nodes)
but abandoned them in favour of multiband routers (tl-wdr3500) which use
ath9k on both radios, which is a lot more stable and doesn't have such
7-peers limitation.

based on our first-hand experience (we even bought a lot of 20 at some
point), i'd advise against trying to use ath9k_htc USB dongles for
meshing :(

cheers!


>>
>> On 06/30/2014 05:17 PM, david.moffatt@nokia.com wrote: 
>>>
>>> HI all, 
>>>
>>> If anyone is using batman with a USB wifi dongle could you post the name 
>>> of the dongle you are using? 
>>> If it required a special driver or firmware please let me know where you 
>>> got it. 
>>> Also please give dongles names not chipsets as it is hard to know what 
>>> chipset is in what dongles. 
>>>
>>> ‹Thank in advance. 
>>>
>>> David. 
>>>
>>>
