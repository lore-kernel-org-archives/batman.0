Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <52905ff0-487f-f50f-797a-6f6f1740d1d4@gmail.com>
Date: Sat, 22 Apr 2017 13:16:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [ath10k] [batman-adv] Robustness of batman-adv or
 IBSS/802.11s on ath9k (AR9331 chip)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, openwrt-devel@lists.openwrt.org

Hi ath10k community,

Does anyone use ath9k driver + 802.11s (or IBSS/adhoc) on commercial 
products?

Our setup is AR9331 + ath9k driver + OpenWRT 15.05 + batman-adv 2016.1 
(PKG_RELEASE:=3)

We are very serious about robustness of running batman-adv on AR9331, 
because we have 20+ commercial sites running, each site is with about 20 
nodes.
- batman-adv + ar9331 work almost (well almost) perfectly.
- Sometimes, one node drops off the mesh, occurrence rate is very low.
- For one time, when Node drops off the mesh, "rmmod ath9k" then 
"modprobe ath9k" can get both batman-adv (and ibss/adhoc on top of 
ath9k) recover. This seemingly points to that the issue is with ath9k 
driver (ibss/adhoc mode).

As this email is mainly addressed to ath10k community (rather than 
batman-adv or openwrt), does anyone commercially use 802.11s (or 
ibss/adhoc)+ ath9k/ath10k? Does 802.11s (or ibss/adhoc) + ath9k/ath10k 
work perfectly?

Thanks.
Xuebing Wang

