Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2018 00:01:55 +0200
Message-ID: <1581047.jmAOXYUeYu@sven-edge>
In-Reply-To: <20180605183131.4989-1-sven@narfation.org>
References: <20180605183131.4989-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1760905.d4rbEcptix";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Initialize memory for
 station_info
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc
Cc: Thomas Lauer <holminateur@gmail.com>, Marcel Schmidt <ff.z-casparistrasse@mailbox.org>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart1760905.d4rbEcptix
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Antonio,

On Dienstag, 5. Juni 2018 20:31:31 CEST Sven Eckelmann wrote:
> cfg80211_get_station is not initializing the memory given as parameter
> sinfo. The caller has to handle it. Otherwise the filled parameter may be
> set incorrectly and thus uninitialized memory is used to identify the
> throughput to an neighbor.

Hm, have to rewrite the commit message to something better. Maybe to something 
like:

batadv_v_elp_get_throughput is calling cfg80211_get_station with a pointer
(sinfo) to some uninitialized memory on the stack. But most of the
implementations behind cfg80211_get_station will not initialize sinfo to
zero before manipulating it. For example, the member
&struct station_info.filled is often only modified by using a read (of
possibly uninitialized/random memory), an OR operation and then a write of
the new value back to the original memory address. A caller without a
preinitialized &struct station_info.filled can then no longer decide which
parts of sinfo were filled in by cfg80211_get_station.

The caller of cfg80211_get_station must therefore take care that sinfo (or
at least sinfo.filled) is initialized to zero. Otherwise, the caller may
tries to read information which was not filled in and is therefore also
uninitialized. In batadv_v_elp_get_throughput's case, an invalid "random"
expected throughput may be saved for this neighbor and thus the B.A.T.M.A.N
V algorithm may switch to non-optimal neighbors for certain destinations.

> Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
> Reported-by: Thomas Lauer <holminateur@gmail.com>
> Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> 
> Cc: Thomas Lauer <holminateur@gmail.com>
> Cc: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>

Here some more information why I thought that this could be the reason (still 
has to be tested by the reporters):

* sinfo is usually allocated with alloc helper that initializes everything 
  to 0 [1,2]
* filled is set to 0 by functions which have sinfo on stack and call the 
  (internal) functionality [3,4]
* most implementations for cfg80211_get_station
  (&struct cfg80211_ops->get_station) [5] are *not* setting filled manually
  to a predefined value
  - default implementation [6] and its main helper [7] doesn't do that
  - ath6kl [8] doesn't do that
  - (ath10k [9] doesn't do that for statistics)
  - wil6210 [10] does it
  - brcmfmac does it for everything [11] except ibss [12]
  - (iwlwifi doesn't do that for the statistics [13])
  - libertas doesn't do that [14]
  - mwifiex does it [15]
  - quantenna doesn't do it [16,17]
  - (wlcore doesn't do it [18] for statistics)
  - rndis_wlan is doing it [19]
  - rtl8723bs does it [20]
  - (rtlwifi does it for statistics [21])
  - wilc1000 doesn't do it [22]
  - prism2 does it [23]
* nl80211 interface also does the memset [24]
* wext compat layer does it everywhere(?) [25]

But please check this again because a lot of the "research" was done in a
restaurant.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/sta_info.c?id=5037be168f0e4ee910602935b1180291082d3aac#n558
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/sta_info.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1007
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/ethtool.c?id=5037be168f0e4ee910602935b1180291082d3aac#n109
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/ethtool.c?id=5037be168f0e4ee910602935b1180291082d3aac#n136
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/wireless/util.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1735
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/cfg.c?id=5037be168f0e4ee910602935b1180291082d3aac#n714
[7] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/sta_info.c?id=5037be168f0e4ee910602935b1180291082d3aac#n2069
[8] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath6kl/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1774
[9] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath10k/mac.c?id=5037be168f0e4ee910602935b1180291082d3aac#n7676
[10] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/wil6210/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n303
[11] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n2489
[12] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n2574
[13] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n4174
[14] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/marvell/libertas/cfg.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1554
[15] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/marvell/mwifiex/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1352
[16] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n466
[17] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/quantenna/qtnfmac/commands.c?id=5037be168f0e4ee910602935b1180291082d3aac#n582
[18] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ti/wlcore//main.c?id=5037be168f0e4ee910602935b1180291082d3aac#n5705
[19] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/rndis_wlan.c?id=5037be168f0e4ee910602935b1180291082d3aac#n2477
[20] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1252
[21] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/rtlwifi/core.c?id=5037be168f0e4ee910602935b1180291082d3aac#n974
[22] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c?id=5037be168f0e4ee910602935b1180291082d3aac#n1162
[23] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/wlan-ng/cfg80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n267
[24] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/wireless/nl80211.c?id=5037be168f0e4ee910602935b1180291082d3aac#n4609
[25] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/wireless/wext-compat.c?id=5037be168f0e4ee910602935b1180291082d3aac
--nextPart1760905.d4rbEcptix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsXCFMACgkQXYcKB8Em
e0bEFA//SkR+EfMre27b+IW7UeJMRS/x+91Tn8qHfw9nVBv0j3lxuLiGqIrlY+Dx
31F57VYsm543dHN/V5gMkXjm3/OZg9VvB9e+XWwVgto8nf7Do4xfTkvX6BvVjEdB
CeNuwNZFxixhsywnGDcfiRKXzjV8ScNlpKNvtNw7MBc4W3OrWfe7JKX/JTQuLGCJ
W6uQ+qt6OzyUTBvwbf+iFI8NDXxUd7QKzNZx0An22VaICX5+FSRm2d/yiMgt2X1A
ZgTWw90eeJD3J6BziqxIVIERW5ztInGfAKOREixBGojmao4ka0U9Iv1Pf+AwRayz
fxPhIEaoo7Pkep5zaGYiRR7VtfjVxqWuxBZdizPVUEKO2stfw68KZyAc1C9kyHlm
KEAFNqmykVohCIdf6sNNGQ5pSNBTYb+JAh/WTyABgrrgk6zxQb365u/rHBGXaYuy
A2spV30s+X6Rq0AQQ1VflE7oAVY0/XnGoTe3RhBFOYHcbSn69pknbg7wnbRa+riP
u+lomFahGhFwijciZ0kUvaulxv4pb10GzOtbhHrxz3KCuru8TYzCctFqZDkRaEJ7
By6Fyopruj9TezaSjyfoh3ahoI6xV6AK5y+RKn3xeEd3c0jSdw0MCF23pyvtT/Q7
JMeyEYzHAcivNbwoQXYdpvlz2c5lqV0HJphXbntRydpK1lPHJWg=
=O2vr
-----END PGP SIGNATURE-----

--nextPart1760905.d4rbEcptix--



