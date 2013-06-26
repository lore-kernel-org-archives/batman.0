Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130626190117.GF2120@ritirata.org>
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
 <20130626180217.GC2120@ritirata.org>
 <CAD_CWO0=3LUL6HsZtG3CGSfR5=BXcoJ=ccfdLCFtthhZTUJKzw@mail.gmail.com>
 <CAKON4Oy91hwHS2wupsPYsZQ8iMX0it1SwPPcf-vS=a1HQYr5rA@mail.gmail.com>
 <CAD_CWO0hpqnzdMt9EmyJy85OM=Zw6pz3fZ7z27H1jSJc7vM8Qg@mail.gmail.com>
 <CAKON4OzQpsZdGFoEPDpsZcCyu0pGBWLpuNoQZkgcYX-7CmzKqA@mail.gmail.com>
 <20130626190117.GF2120@ritirata.org>
Date: Wed, 26 Jun 2013 16:21:56 -0400
Message-ID: <CAKON4OxGMNFjXtpxiGe+fdH5uuLNuozn2hb8MKRAUPLLBDV_dg@mail.gmail.com>
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
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

On Wed, Jun 26, 2013 at 3:01 PM, Antonio Quartulli <ordex@autistici.org> wrote:
> On Wed, Jun 26, 2013 at 02:56:06PM -0400, jonsmirl@gmail.com wrote:
>> On Wed, Jun 26, 2013 at 2:49 PM, Steve Song <steve@villagetelco.org> wrote:
>> > We use a stock AA OpenWRT distribution (RC1 currently I think).  All
>> > modifications to it are contained in the Github repo at
>> > https://github.com/villagetelco/vt-firmware  We have instructions on
>> > setting up a build environment at
>> > http://wiki.villagetelco.org/How_To_Set_Up_a_SECN_Build_Environment
>>
>> Maybe it has gotten broken in OpenWRT trunk. There was a large
>> backport recently added to the kernel tree.
>>
>> When I active the alternate interfaces they won't let the other one come up.
>>
>> root@OpenWrt:/etc/config#
>> root@OpenWrt:/etc/config# ifconfig ap0 up
>> ifconfig: SIOCSIFFLAGS: Device or resource busy
>> root@OpenWrt:/etc/config#
>> root@OpenWrt:/etc/config# ifconfig adhoc0 down
>> [ 2510.510000] batman_adv: bat0: Interface deactivated: adhoc0
>> root@OpenWrt:/etc/config# ifconfig ap0 up
>> root@OpenWrt:/etc/config# ifconfig adhoc0 up
>> ifconfig: SIOCSIFFLAGS: Device or resource busy
>> root@OpenWrt:/etc/config#
>>
>> In my 'iw phy' output:
>>
>> valid interface combinations:
>> * #{ managed, WDS, P2P-client } <= 2048, #{ AP, mesh point, P2P-GO }
>> <= 8, #{ IBSS } <= 1,
>>   total <= 2048, #channels <= 1, STA/AP BI must match
>> * #{ AP } <= 1,
>>   total <= 1, #channels <= 1, STA/AP BI must match, radar detect
>> widths: { 20 MHz (no HT), 20 MHz }

I have Steve's image running 'iw phy' report this:

valid interface combinations:
* #{ managed, WDS, P2P-client } <= 2048, #{ IBSS, AP, mesh point, P2P-GO } <= 8,
  total <= 2048, #channels <= 1

Which says I can mix AP and IBSS mode.  So it appear that OpenWRT
trunk has been broken.


>>
>> How do you interpret this? It this saying one IBSS plus up to eight AP?
>
> Seems so.
> Maybe you should directly ask on the openwrt mailing list/channel?
> They may know what to do.
>
> Cheers,
>
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara



--
Jon Smirl
jonsmirl@gmail.com
