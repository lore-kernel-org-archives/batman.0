Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <53263AE8.4050705@altermundi.net>
Date: Sun, 16 Mar 2014 20:59:36 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>	<53218FEB.8000100@meshcoding.com>	<CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>	<5321B5AE.9080005@meshcoding.com>
 <CAMcTwKrw+U7xZckqmcurrc8z4UZTkt50SqQ_esFHKo_D2Grf_A@mail.gmail.com>
 <5325A449.3080905@itamar.org>
In-Reply-To: <5325A449.3080905@itamar.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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

Hi Itamar,

You should also consider a problem at your wifi driver level.

We've seen a behavior very similar to what you are describing using
ath9k hardware a while ago.


Cheers,
NicoEchániz



El 16/03/14 10:16, Itamar escribió:
> I have compiled both the kernel module and batctl from source (2014.1.0).
> The problem remains. Whenever I reboot a node, its IP is never reachable
> from the network and the network can not be reached by it.
> 
> Things I have tried:
> 
> * DAT enabled
> * DAT Disabled
> * DAT not compiled (ticked "n" in the Makefile)
> 
> Of course, the tests were performed when all nodes in the mesh were with
> the consistent configuration and never mixed.
> 
> Another curious thing I have seen is that when looking at a tcpdump (via
> batctl) I could indeed see ARP requests to the pinged IP (the tcpdump
> running on the node hosting the pinged IP) but the node never replies.
> 
> What else should I try?
> 
> Thanks,
> Itamar
> 
> On 03/13/2014 04:51 PM, Itamar Landsman wrote:
>> Thanks,
>> I see that 2004.1 had just been released.. I will compile and give it
>> a go.
>>
>> Cheers,
>> Itamar
>>
>> On Thu, Mar 13, 2014 at 3:42 PM, Antonio Quartulli
>> <antonio@meshcoding.com> wrote:
>>>
>>> On 13/03/14 13:20, Itamar Landsman wrote:
>>>> Thanks Antonio,
>>>> I appreciate the quick reply.
>>>>
>>>> batctl -v returns: batctl debian-2012.1.0-1 [batman-adv: 2013.2.0]
>>>>
>>>> Should I compile and install from the latest git?
>>>> I see that the batctl command is from a much older release.. It
>>>> doesn't support the dat or dc parameters. Should I compile that one as
>>>> well?
>>> The recommendation is to always run the same version of batctl and
>>> batman-adv, exactly to avoid this kind of situations where you have a
>>> feature in the kernel module that cannot be used by batctl (I have to
>>> say that you can use every feature *without* batctl, but if you want to
>>> use the tool it is better to get the right version).
>>>
>>> The batman-adv version you run is also rather old. I'd personally
>>> recommend to wait one or two days for the next release and then download
>>> it (yes, the developers are in the process of releasing it).
>>>
>>> However, here[1] you have a description of the sysfs interface that you
>>> can use to quickly check the DAT status without doing any upgrade.
>>>
>>>
>>> Cheers,
>>>
>>>
>>> [1] http://www.open-mesh.org/projects/batman-adv/wiki/Tweaking
>>>
>>> -- 
>>> Antonio Quartulli
>>>
> 

