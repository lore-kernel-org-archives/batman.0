Return-Path: <stephen.song@gmail.com>
MIME-Version: 1.0
Sender: stephen.song@gmail.com
In-Reply-To: <CAKON4Oy91hwHS2wupsPYsZQ8iMX0it1SwPPcf-vS=a1HQYr5rA@mail.gmail.com>
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
 <20130626180217.GC2120@ritirata.org>
 <CAD_CWO0=3LUL6HsZtG3CGSfR5=BXcoJ=ccfdLCFtthhZTUJKzw@mail.gmail.com>
 <CAKON4Oy91hwHS2wupsPYsZQ8iMX0it1SwPPcf-vS=a1HQYr5rA@mail.gmail.com>
Date: Wed, 26 Jun 2013 15:49:35 -0300
Message-ID: <CAD_CWO0hpqnzdMt9EmyJy85OM=Zw6pz3fZ7z27H1jSJc7vM8Qg@mail.gmail.com>
From: Steve Song <steve@villagetelco.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
Reply-To: steve@villagetelco.org,
 The list for a Better Approach To Mobile Ad-hoc Networking
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

On 26 June 2013 15:36, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Wed, Jun 26, 2013 at 2:18 PM, Steve Song <steve@villagetelco.org> wrote:
>> On 26 June 2013 15:02, Antonio Quartulli <ordex@autistici.org> wrote:
>>> On Wed, Jun 26, 2013 at 01:30:18PM -0400, jonsmirl@gmail.com wrote:
>>>> I'd like to setup batman up on single radio routers. I've installed
>>>> openwrt on three different chipsets now (RT3050, RT5350, AR9331) and
>>>> none of these wireless drivers implements support for simultaneous
>>>> adhoc and ap mode on virtual interfaces.
>>>>
>>>> Yet when I google around I see lots of examples of people using single
>>>> radio routers with dual adhoc and ap mode virtual interfaces.  So
>>>> which radios support simultaneous adhoc/ap mode?
>>>>
>>>> From AR9331...
>>>> valid interface combinations:
>>>> * #{ managed, WDS, P2P-client } <= 2048, #{ AP, mesh point, P2P-GO }
>>>> <= 8, #{ IBSS } <= 1,
>>>>   total <= 2048, #channels <= 1, STA/AP BI must match
>>>> * #{ AP } <= 1,
>>>>   total <= 1, #channels <= 1, STA/AP BI must match, radar detect
>>>> widths: { 20 MHz (no HT), 20 MHz }
>>>
>>> Am I wrong or AR9331 is handled by the ath5k driver?
>>>
>>> However in openwrt you will find some patches that are editing these interface
>>> combinations in order to allow IBSS + AP for some drivers (e.g. ath5k or
>>> ath9k..).
>>>
>>> This behaviour is not supported upstream for several reasons, therefore if you
>>> look in the kernel source you will never find a combination allowing the
>>> aforementioned schema.
>>
>> The AR9331 supports simultaneous IBSS and AP mode.  If your AR9331
>> device happens to be a TP-Link WR703n, you can download a firmware
>> with batman-adv configured for both modes at
>> http://download.villagetelco.org/firmware/secn/unstable/tp-link/SECN-2/SECN-2.0-RC1/openwrt-ar71xx-generic-tl-wr703n-v1-squashfs-sysupgrade.bin
>>  Alternatively if you'd just like to have a look the configuration
>> files, you can see them at
>> https://github.com/villagetelco/vt-firmware/tree/development/SECN-build/files/etc/config
>
> I tired these config files on the OpenWRT for AR9331 I had built from
> git source. They don't work because of the simultaneous ap/adhoc
> issue.
>
> So.. your binary must be built from a modified OpenWRT source.
> Probably using those patches Antonio referred to. Next I need to track
> down those patches...
>
> I have a some WR703n devices. Is there a link to the source you used
> to make the binary?

We use a stock AA OpenWRT distribution (RC1 currently I think).  All
modifications to it are contained in the Github repo at
https://github.com/villagetelco/vt-firmware  We have instructions on
setting up a build environment at
http://wiki.villagetelco.org/How_To_Set_Up_a_SECN_Build_Environment

-Steve

>>
>> Regards... Steve Song
>>
>>
>>> Cheers,
>>>
>>> --
>>> Antonio Quartulli
>>>
>>> ..each of us alone is worth nothing..
>>> Ernesto "Che" Guevara
>>
>>
>>
>> --
>> Steve Song
>> +1 902 529 0046
>> http://villagetelco.org
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Steve Song
+1 902 529 0046
http://villagetelco.org
