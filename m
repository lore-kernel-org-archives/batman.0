Return-Path: <moritzwarning@web.de>
Subject: Re: batman_v default throughput
References: <dc998970-a36c-cbb5-8de5-2ed2a3833d57@web.de>
 <44509c82-e60d-c94c-e686-faf08e0ec875@unstable.cc>
From: Moritz Warning <moritzwarning@web.de>
Message-ID: <9ff7477f-8d1f-9db4-8415-2f89b571532d@web.de>
Date: Sun, 11 Aug 2019 23:57:36 +0200
MIME-Version: 1.0
In-Reply-To: <44509c82-e60d-c94c-e686-faf08e0ec875@unstable.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio.

On 8/9/19 10:26 AM, Antonio Quartulli wrote:
> Hi Moritz,
>
> On 08/08/2019 23:05, Moritz Warning wrote:
>> Hi,
>>
>> the Freifunk network in Ulm has a batman_V network of >80 nodes. [0]
>>
>> For the map, we use the link throughput value from batman-adv to calcul=
ate a link value (capped at 40 MBit/s for 100%).
>> The default for VPN connections seem to be 1 MBit/s - when batman-adv d=
oesn't know the throughput from the driver.
>>
>> Is there a way to the set this throughput or can batman-adv measure it?
>>
>
> I think we discussed this topic in all its details (with Marek) during
> WMBv10, no?
Could be. I do not remember what was discussed..

>
> However, if you need to refresh the concept, you can look at the
> function that takes care of selecting the throughput:
> batadv_v_elp_get_throughput() in bat_v_elp.c
>
>
> The function is invoked for each neighbour/link across a given interface
> and can be summarized as follows:
> - if any throughput_override was set by the user for this iface, just
> use this value;
> - otherwise, if the iface is wifi, ask the wifi stack for the
> expected-throughput (computed by minstrel for ath9k and other SoftMAC
> drivers);
> - otherwise, ask the ethtool module if there is a known link speed for
> this iface;
> - otherwise, if none of the above worked, use the default throughput
> (1Mbps).
>
>
> As also mentioned at WBMv10, Marek and I had worked on a patchset that
> enables the tp_meter to measure the speed of a link, when no other
> throughput is available (i.e. for VPN or other virtual links). The
> patchset is still pending here [1].
That might be a nice fallback instead of employing a cranky iperf setup.
But (imho) it should be off/not compiled in by default and maybe only perf=
orm the check once, so to not to scare people into thinking batman-adv con=
sumes too much bandwidth for testing.

>
> We suggested you to manifest your interest about that patchset, so that
> the discussion could move on, but it seemed you were not motivated
> enough (at least back then).
>
> Maybe you could take this chance to revive that thread? :-)
Hm, I do not have that email in my email client anymore.
But it's good to know that there is a patch set that I can apply.

>
>
> Cheers,
>
>
> [1]
> https://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg17833.ht=
ml
>
>
>> Thanks!
>>
>> [0]: https://map11.freifunk-ulm.de/meshviewer
>>
>

