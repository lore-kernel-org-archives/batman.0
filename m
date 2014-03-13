Return-Path: <hannes.harms@tu-bs.de>
Message-ID: <5321DB08.50502@tu-bs.de>
Date: Thu, 13 Mar 2014 17:21:28 +0100
From: "Harms, Hannes" <hannes.harms@tu-bs.de>
MIME-Version: 1.0
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
 <53218FEB.8000100@meshcoding.com>
 <CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>
 <5321B5AE.9080005@meshcoding.com>
 <CAMcTwKrw+U7xZckqmcurrc8z4UZTkt50SqQ_esFHKo_D2Grf_A@mail.gmail.com>
In-Reply-To: <CAMcTwKrw+U7xZckqmcurrc8z4UZTkt50SqQ_esFHKo_D2Grf_A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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

Dear list,
im wondering if it is possible to just compile the latest release of 
batman-adv and replace the existing  kernel module on an Debian System.
It is not necessary to have  a propriate kernel version  e.g. 3.13 ?

Cheers,
Hannes
Am 13.03.2014 15:51, schrieb Itamar Landsman:
> Thanks,
> I see that 2004.1 had just been released.. I will compile and give it a go.
>
> Cheers,
> Itamar
>
> On Thu, Mar 13, 2014 at 3:42 PM, Antonio Quartulli
> <antonio@meshcoding.com> wrote:
>>
>> On 13/03/14 13:20, Itamar Landsman wrote:
>>> Thanks Antonio,
>>> I appreciate the quick reply.
>>>
>>> batctl -v returns: batctl debian-2012.1.0-1 [batman-adv: 2013.2.0]
>>>
>>> Should I compile and install from the latest git?
>>> I see that the batctl command is from a much older release.. It
>>> doesn't support the dat or dc parameters. Should I compile that one as
>>> well?
>> The recommendation is to always run the same version of batctl and
>> batman-adv, exactly to avoid this kind of situations where you have a
>> feature in the kernel module that cannot be used by batctl (I have to
>> say that you can use every feature *without* batctl, but if you want to
>> use the tool it is better to get the right version).
>>
>> The batman-adv version you run is also rather old. I'd personally
>> recommend to wait one or two days for the next release and then download
>> it (yes, the developers are in the process of releasing it).
>>
>> However, here[1] you have a description of the sysfs interface that you
>> can use to quickly check the DAT status without doing any upgrade.
>>
>>
>> Cheers,
>>
>>
>> [1] http://www.open-mesh.org/projects/batman-adv/wiki/Tweaking
>>
>> --
>> Antonio Quartulli
>>

-- 
Dipl.-Ing. Hannes Harms
Technische Universität Braunschweig
Institut für mobile Maschinen und Nutzfahrzeuge
Langer Kamp 19a
D-38106 Braunschweig

Durchwahl: +49 (0)531 391-7197
E-Mail:  hannes.harms@tu-braunschweig.de
http://www.tu-braunschweig.de/imn

