Return-Path: <linus.luessing@web.de>
Date: Fri, 10 May 2013 15:07:06 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130510130706.GA11726@Linus-Debian>
References: <CAHQ_bgh0rYJeF5PmFrSRam1arjvGTpZoYUQ4s3nRbHR=mJt57Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHQ_bgh0rYJeF5PmFrSRam1arjvGTpZoYUQ4s3nRbHR=mJt57Q@mail.gmail.com>
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

As far as I know it is not possible to have a virtual 802.11s mesh
and an IBSS interface at the same time with the ath5k/ath9k (at least
I think that was the case during the Wireless BattleMesh v6). You
might need to run tests one after the other or you could try to make
the ath5k/9k VAP patches [1],[2],[3] to not only work for IBSS but
also mesh mode.

Cheers, Linus

[1]: openwrt/package/mac80211/patches/410-ath9k_allow_adhoc_and_ap.patch
[2]: openwrt/package/mac80211/patches/411-ath5k_allow_adhoc_and_ap.patch
[3]: openwrt/package/mac80211/patches/412-mac80211_allow_adhoc_and_ap.patch


On Fri, May 10, 2013 at 08:56:27AM +0530, ajeet singh wrote:
> Dear all,
> 
> I have done the set-up of Batman-adv. and 802.11s in my lab.
> I am comparing their working functionalities and performance
> measurements (throughput etc.).
> 
> Have anyone tested batman-adv. and 802.11s with same test setup (I
> mean with same wireless chipsets)?
> 
> Please provide me any related URLs.
> 
> Thanks in advance.
> 
> Thanks
> Ajeet
