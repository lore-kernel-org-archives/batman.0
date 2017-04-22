Return-Path: <xbing6@gmail.com>
References: <52905ff0-487f-f50f-797a-6f6f1740d1d4@gmail.com>
 <87fuh095zo.fsf@husum.klickitat.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <49f858df-6cd0-1917-2209-d26bb5e4d6c5@gmail.com>
Date: Sat, 22 Apr 2017 17:12:42 +0800
MIME-Version: 1.0
In-Reply-To: <87fuh095zo.fsf@husum.klickitat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] [ath10k] [batman-adv] Robustness
 of batman-adv or IBSS/802.11s on ath9k (AR9331 chip)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Russell Senior <russell@personaltelco.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, openwrt-devel@lists.openwrt.org, "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>

On 2017年04月22日 16:55, Russell Senior wrote:
>>>>>> "Xuebing" == Xuebing Wang <xbing6@gmail.com> writes:
> Xuebing> Hi ath10k community, Does anyone use ath9k driver + 802.11s (or
> Xuebing> IBSS/adhoc) on commercial products?
>
> Xuebing> Our setup is AR9331 + ath9k driver + OpenWRT 15.05 + batman-adv
> Xuebing> 2016.1 (PKG_RELEASE:=3)
>
> Xuebing> We are very serious about robustness of running batman-adv on
> Xuebing> AR9331, because we have 20+ commercial sites running, each site
> Xuebing> is with about 20 nodes.  - batman-adv + ar9331 work almost
> Xuebing> (well almost) perfectly.  - Sometimes, one node drops off the
> Xuebing> mesh, occurrence rate is very low.  - For one time, when Node
> Xuebing> drops off the mesh, "rmmod ath9k" then "modprobe ath9k" can get
> Xuebing> both batman-adv (and ibss/adhoc on top of ath9k) recover. This
> Xuebing> seemingly points to that the issue is with ath9k driver
> Xuebing> (ibss/adhoc mode).
>
> I'm running batman-adv on LEDE-project (r1497) on a TP-Link TP-WDR3600
> with ibss/adhoc + ap on the 2.4GHz radio.  This is ath9k, not ath10k.
> Seems to work fine, no problems.
Hi Russel,

Thanks. By "work fine", do you mean that you have 20+ nodes running for 
at least a month without any issues?

Xuebing Wang

