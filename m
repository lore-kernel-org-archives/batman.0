Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <42b14dc4-e931-527f-e105-07db7c6f3b87@gmail.com>
Date: Sun, 23 Apr 2017 10:49:37 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [batman-adv] Deaf hang happens quite often for a
 distant node (ar9331 + openwrt)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Simon and Sven,

Thank you very much for your help.

I hope I correctly took the deaf state and 0xdeadbeef patches:
[1] https://patchwork.kernel.org/patch/9433619/
[2] https://patchwork.kernel.org/patch/9433621/

Also, I use software encryption, in the hope to avoid key cache corruption.
[3] https://patchwork.kernel.org/patch/9381651/

Are there other patches I need to apply for ar9331?

I use ath_warn() before some cases of ath9k_queue_reset(). For a distant 
node, I saw below. deaf hang comes quite often, did you observe this too?
-----------------
[  985.520000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 1166.000000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 1617.200000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 2399.280000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 4023.600000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 4648.610000] ath: phy0: tx hung, resetting the chip
[ 4802.610000] ath: phy0: tx hung, resetting the chip
[ 5103.360000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 5975.680000] ath: phy0: RX deaf hang is detected. Schedule chip reset
[ 6998.400000] ath: phy0: RX deaf hang is detected. Schedule chip reset
-----------------

Thanks.

Xuebing Wang

