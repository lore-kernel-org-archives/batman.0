Return-Path: <omer.efrat@tandemg.com>
From: Omer Efrat <omer.efrat@tandemg.com>
Date: Sun, 17 Jun 2018 13:05:51 +0300
Message-Id: <1529229951-17730-1-git-send-email-omer.efrat@tandemg.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] [PATCH v3 0/5] use BIT_ULL for NL80211_STA_INFO_*
 attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, devel@driverdev.osuosl.org
Cc: Omer Efrat <omer.efrat@tandemg.com>

The BIT macro uses unsigned long which some architectures handle as 32 bit
and therefore might cause macro's shift to overflow when used on a value
equals or larger than 32 (NL80211_STA_INFO_RX_DURATION and afterwards).

Since 'filled' member in station_info changed to u64, BIT_ULL macro
should be used with all NL80211_STA_INFO_* attribute types instead of BIT
to prevent future possible bugs when one will use BIT macro for higher
attributes by mistake.

Note: The following patch series only does some code clean up.
The previous versions mentioned a bug fix but it appears as a mix up
with some local changes because NL80211_STA_INFO_TID_STATS value actually
equals 31.

Changes in v3:
  - Better phrasing commit messages due to the above note
  - Align patches to latest mac80211-next

Omer Efrat (5):
  cfg80211: use BIT_ULL for NL80211_STA_INFO_* attribute types
  mac80211: use BIT_ULL for NL80211_STA_INFO_* attribute types
  batman-adv: use BIT_ULL for NL80211_STA_INFO_* attribute types
  wireless-drivers: use BIT_ULL for NL80211_STA_INFO_ attribute types
  staging: use BIT_ULL for NL80211_STA_INFO_* attribute types

 drivers/net/wireless/ath/ath10k/mac.c              |  4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         | 14 ++--
 drivers/net/wireless/ath/wil6210/cfg80211.c        | 18 ++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 40 +++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  6 +-
 drivers/net/wireless/marvell/libertas/cfg.c        | 12 ++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 14 ++--
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 32 ++++-----
 drivers/net/wireless/rndis_wlan.c                  |  4 +-
 drivers/net/wireless/ti/wlcore/main.c              |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  | 10 +--
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  | 14 ++--
 drivers/staging/wlan-ng/cfg80211.c                 |  4 +-
 net/batman-adv/bat_v_elp.c                         |  2 +-
 net/mac80211/ethtool.c                             |  6 +-
 net/mac80211/sta_info.c                            | 84 +++++++++++-----------
 net/wireless/nl80211.c                             | 26 +++----
 net/wireless/wext-compat.c                         | 10 +--
 18 files changed, 151 insertions(+), 151 deletions(-)

-- 
2.7.4

