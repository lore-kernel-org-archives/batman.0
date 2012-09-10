Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
References: <h1pf9bti26g2966o34ml5cv4.1347057546796@email.android.com>
 <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
From: Esteban Municio <emunicio@gmail.com>
Date: Mon, 10 Sep 2012 10:23:26 -0500
Message-ID: <CAMVTf1jYnm-SOjOSvPF89PRTQJuOLFP5VfwbCZDKJEkOG8EMZg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] How to force a specific network topology
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

Hi Martin

Thanks you, I have seen the description and I think that your patch is
what we are looking for. I'm gonna try to test it, but I'm a totally
newbie in patches issues.
Could you tell me superficially what I have to do for rebase the patch
before to build it and add it to our nodes?

Thanks you

2012/9/10 Esteban Municio <emunicio@gmail.com>:
> Hi Sven
>
> I don't understand very well what are you meaning. Now I have 1 bridge
> over with batman-adv:
>
> batctl if add wlan0
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
>
> Then, should I add a bridge to wlan0 and after bridge it again with the e=
th0?
>
> brctl addbr bridgeWlan
> brctl addif bridgeWlan wlan0
>
> batctl if add mesh-bridge
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
>
> And then, should I install ebtables in all the nodes(now we have 9
> nodes, and only 1 have internet access to install it directly)
> It seem a little difficult for me :-)
>
> Could I try another method?something like set paths manually?
> In 802.11s we have a usefull comand for block links undesirables:
> iw dev INTERFACE_MESH_NAME station set MAC_ADD plink_option block
> nothing similar like that in batman-adv?
>
> Regards
>
> 2012/9/7 Martin Hundeb=F8ll <martin@hundeboll.net>:
>> Hi Esteban
>>
>> You can try my patch to filter OGMs:
>> http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/hundeboll/fi=
lter
>>
>> The commit message tells how to use it. Unfortunately, its base is quite=
 old, but it should be easy to rebase. Otherwise I can rebase it when I ret=
urn from Canada next week...
>>
>> Cheers,
>> Martin
>>
>> PS: Sorry for top posting. This Android client want let me change it :(
>>
>> Sven Eckelmann <sven@narfation.org> wrote:
>>
>>>On Friday 07 September 2012 16:58:33 Esteban Municio wrote:
>>>> Hi list
>>>>
>>>> Is there any way to block some links between nodes in order to force a
>>>> specific network topology in batman-adv?
>>>>
>>>> Por example, if y have 3 nodes A, B, C and I want to create a string
>>>> topology A <-> B <-> C, where A can not connect directly with C, how
>>>> could I get it without move far away the nodes?
>>>
>>>You can try to add a your interface to a bridge (only one interface per
>>>bridge) and add this bridge to batman-adv. Now you can filter packets us=
ing
>>>ebtables (and therefore drop packets from specific hosts).
>>>
>>>Kind regards,
>>>       Sven
>
>
>
> --
> Esteban



--=20
Esteban
