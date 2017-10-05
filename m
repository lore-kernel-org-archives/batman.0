Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <a777df92-f03a-9f9e-7bcf-0c51f8fe0aa3@gmail.com>
Date: Thu, 5 Oct 2017 17:42:02 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [B.A.T.M.A.N.] [batman-adv] Sometimes it takes several minutes to
 join mesh after reboot when there are <4 nodes in the network
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon, Sven,

Thank you very much for your help. Our batman-adv BATMAN_IV are deployed 
in 100+ (may be more) sites, and works almost perfectly.

There is a minor issue: after reboot the board, sometimes it takes 
several minutes to join mesh after reboot when there are <4 nodes in the 
network.
- Usually board joins mesh instantly.
- When this happens, I can still 'ping ip-address%mesh0' using IBSS 
interface, so it is likely a batman-adv issue.
- This does not happen when I have >=4 nodes in the mesh network.
   -- For a setup of 6 nodes, I run the automated test for 1000 cycles, 
and no issues.

I use the automated test:
- reboot one board, and sleep 20 seconds
- 'batctl n | tail -1 | grep mesh0' to see if it is empty.

Here is my environment:
- Atheros ar9331 MIPS platform + built-in ath9k WiFi
- OpenWRT tag 15.05
- batman-adv version 2016.1.3 (with 22 patches in patches/ subfolder as 
you know it very well)
- routing_algos = BATMAN_IV

Is this a known issue? Thanks again.

Xuebing Wang

