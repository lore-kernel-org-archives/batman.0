Return-Path: <thomas@cozybit.com>
MIME-Version: 1.0
In-Reply-To: <20130510130706.GA11726@Linus-Debian>
References: <CAHQ_bgh0rYJeF5PmFrSRam1arjvGTpZoYUQ4s3nRbHR=mJt57Q@mail.gmail.com>
 <20130510130706.GA11726@Linus-Debian>
From: Thomas Pedersen <thomas@cozybit.com>
Date: Fri, 10 May 2013 16:40:44 -0700
Message-ID: <CAG6hwVNYGxnO4rJoxBS387U0wuMEOnxLram4ZNq5rW4Ybx2SeQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Ajeet,

This should be possible with the patches Linus posted, but you'll
probably need the one at
http://www.spinics.net/lists/linux-wireless/msg107080.html as well.

On Fri, May 10, 2013 at 6:07 AM, Linus L=FCssing <linus.luessing@web.de> wr=
ote:
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



--
Thomas
