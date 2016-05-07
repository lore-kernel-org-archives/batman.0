Return-Path: <contact@wifibot.com>
From: contact <contact@wifibot.com>
Message-ID: <572DF6E3.3030901@wifibot.com>
Date: Sat, 7 May 2016 16:08:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] no able to switch routing algo to V ?
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

Hello,

I just got openwrt 15.05.1 with batman-adv 2016.1 on 3 picostation HP, 
this time a selected before the build of openwrt batman V option, I can 
see it when it ask for available routing algo ,

root@OpenWrt:/etc/init.d# cat /sys/kernel/debug/batman_adv/routing_algos
Available routing algorithms:
  * BATMAN_IV
  * BATMAN_V

but when I do :

echo BATMAN_V > /sys/module/batman_adv/parameters/routing_algo

It does nothing, still on BATMAN_IV during session and on reboot ?

sysctl -a does not show any routing_algoritms param for batman-adv ?

Best Regards,

Laurent
