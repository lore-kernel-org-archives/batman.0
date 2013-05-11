Return-Path: <ajeetbbr@gmail.com>
MIME-Version: 1.0
Date: Sat, 11 May 2013 18:59:58 +0530
Message-ID: <CAHQ_bgg6rTMN2wnnToQLTwXx+U_U3scbOY3zmz6m-_wX7xzoHw@mail.gmail.com>
From: ajeet singh <ajeetbbr@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Performance Comparison (Batman-adv. vs. 802.11s)
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello All,

Thanks a lot for reply.

After applying patch
http://www.spinics.net/lists/linux-wireless/msg107080.html , I am able
to run batman-adv and 802.11s on top of the same wireless chipset (One
after another).

I am using Atheros-AR9271 chipsets (ath9k_htc) for my tests.

I am getting good ping latency in both cases IBSS (Batman-adv) and
mesh mode (802.11s), but latency fluctuation is there in the case of
mesh mode.

802.11s gives around 15 mbps between two nodes but there is unexpected
throughput result in the case of batman-adv. It=92s coming in kbps
sometimes.

As I have tested batman-adv with different chipsets and got pretty
good throughput around 30 mbps. I suspect there may be something with
ath9k_htc driver and batman-adv compatibility. I will be investigating
the problem in details. Please let me know if you people have any
information related to this problem.

Thanks for providing the paper URL
(http://wwwtlc.iet.unipi.it/research/ggt-iswpc10.pdf), but this paper
is a quite old and within 2 years, both protocols have evolved a lot.

Thanks
Ajeet


On Sat, May 11, 2013 at 3:30 PM,
<b.a.t.m.a.n-request@lists.open-mesh.org> wrote:
> Send B.A.T.M.A.N mailing list submissions to
>         b.a.t.m.a.n@lists.open-mesh.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
> or, via email, send a message with subject or body 'help' to
>         b.a.t.m.a.n-request@lists.open-mesh.org
>
> You can reach the person managing the list at
>         b.a.t.m.a.n-owner@lists.open-mesh.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of B.A.T.M.A.N digest..."
>
>
> Today's Topics:
>
>    1. Re: Performance Comparison (Batman-adv. vs. 802.11s)
>       (Linus L?ssing)
>    2. Re: Performance Comparison (Batman-adv. vs. 802.11s)
>       (Thomas Pedersen)
>    3. Re: Performance Comparison (Batman-adv. vs. 802.11s)
>       (Yeoh Chun-Yeow)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 10 May 2013 15:07:06 +0200
> From: Linus L?ssing <linus.luessing@web.de>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
>         <b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Performance Comparison (Batman-adv. vs.
>         802.11s)
> Message-ID: <20130510130706.GA11726@Linus-Debian>
> Content-Type: text/plain; charset=3Dutf-8
>
> Hi Ajeet,
>
> As far as I know it is not possible to have a virtual 802.11s mesh
> and an IBSS interface at the same time with the ath5k/ath9k (at least
> I think that was the case during the Wireless BattleMesh v6). You
> might need to run tests one after the other or you could try to make
> the ath5k/9k VAP patches [1],[2],[3] to not only work for IBSS but
> also mesh mode.
>
> Cheers, Linus
>
> [1]: openwrt/package/mac80211/patches/410-ath9k_allow_adhoc_and_ap.patch
> [2]: openwrt/package/mac80211/patches/411-ath5k_allow_adhoc_and_ap.patch
> [3]: openwrt/package/mac80211/patches/412-mac80211_allow_adhoc_and_ap.pat=
ch
>
>
> On Fri, May 10, 2013 at 08:56:27AM +0530, ajeet singh wrote:
>> Dear all,
>>
>> I have done the set-up of Batman-adv. and 802.11s in my lab.
>> I am comparing their working functionalities and performance
>> measurements (throughput etc.).
>>
>> Have anyone tested batman-adv. and 802.11s with same test setup (I
>> mean with same wireless chipsets)?
>>
>> Please provide me any related URLs.
>>
>> Thanks in advance.
>>
>> Thanks
>> Ajeet
>
>
> ------------------------------
>
> Message: 2
> Date: Fri, 10 May 2013 16:40:44 -0700
> From: Thomas Pedersen <thomas@cozybit.com>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
>         <b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Performance Comparison (Batman-adv. vs.
>         802.11s)
> Message-ID:
>         <CAG6hwVNYGxnO4rJoxBS387U0wuMEOnxLram4ZNq5rW4Ybx2SeQ@mail.gmail.c=
om>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> Hi Ajeet,
>
> This should be possible with the patches Linus posted, but you'll
> probably need the one at
> http://www.spinics.net/lists/linux-wireless/msg107080.html as well.
>
> On Fri, May 10, 2013 at 6:07 AM, Linus L?ssing <linus.luessing@web.de> wr=
ote:
>> Hi Ajeet,
>>
>> As far as I know it is not possible to have a virtual 802.11s mesh
>> and an IBSS interface at the same time with the ath5k/ath9k (at least
>> I think that was the case during the Wireless BattleMesh v6). You
>> might need to run tests one after the other or you could try to make
>> the ath5k/9k VAP patches [1],[2],[3] to not only work for IBSS but
>> also mesh mode.
>>
>> Cheers, Linus
>>
>> [1]: openwrt/package/mac80211/patches/410-ath9k_allow_adhoc_and_ap.patch
>> [2]: openwrt/package/mac80211/patches/411-ath5k_allow_adhoc_and_ap.patch
>> [3]: openwrt/package/mac80211/patches/412-mac80211_allow_adhoc_and_ap.pa=
tch
>>
>>
>> On Fri, May 10, 2013 at 08:56:27AM +0530, ajeet singh wrote:
>>> Dear all,
>>>
>>> I have done the set-up of Batman-adv. and 802.11s in my lab.
>>> I am comparing their working functionalities and performance
>>> measurements (throughput etc.).
>>>
>>> Have anyone tested batman-adv. and 802.11s with same test setup (I
>>> mean with same wireless chipsets)?
>>>
>>> Please provide me any related URLs.
>>>
>>> Thanks in advance.
>>>
>>> Thanks
>>> Ajeet
>
>
>
> --
> Thomas
>
>
> ------------------------------
>
> Message: 3
> Date: Sat, 11 May 2013 11:59:21 +0800
> From: Yeoh Chun-Yeow <yeohchunyeow@gmail.com>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
>         <b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Performance Comparison (Batman-adv. vs.
>         802.11s)
> Message-ID:
>         <CAEFj985diyOZstxbb5chNPXxQz4mswsaWPhD5_LqBfATuic4fQ@mail.gmail.c=
om>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> Hi, Ajeet
>
> You can take a look on this paper [1] published in year 2010.
>
> [1] http://wwwtlc.iet.unipi.it/research/ggt-iswpc10.pdf
>
> ----
> Chun-Yeow
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
>
>
> ------------------------------
>
> End of B.A.T.M.A.N Digest, Vol 77, Issue 12
> *******************************************



--=20
Thanks
Ajeet
