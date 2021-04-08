Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Batman-adv On Raspberry Pi Zero
From: giuseppedv@gmail.com
Date: Thu, 08 Apr 2021 13:43:30 -0000
Message-ID: <20210408134330.1234.53011@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi all,
I have to create a Mesh Ad-Hoc Wireless Network using a certain number of Raspberry Pi Zero.
I have decided to use Pi Zero Wireless card in ad-hoc  mode and use the batman-adv module
to create the mesh over the ad-hoc wireless network. Here my systems:
- Raspberries Pi Zero W V1.1.
- Raspbian Buster: 2021-03-04-raspios-buster-armhf-lite.img
- Kernel: 5.10.17+
- Batman-adv: built-in kernel module.
No problems to create the ad-hoc wireless network between the Zeroes, even if the mtu needed for Batman-adv
complains:
[quote]# ip link set dev wlan0 mtu 1532
Error: mtu greater than device maximum[/quote]

Problems arise when I try to add the wlan0 interface to batman handler (the batman-adv module is loaded
correctly with modprobe or at boot time)

batctl if add wlan0     <--- OK No Problems

but if I want to request the wlan0 status I receive

[quote]batctl if
wlan0: <error reading status> [/quote]

Anyone experienced the same issues?
