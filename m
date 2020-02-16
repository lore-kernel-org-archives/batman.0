Return-Path: <emiliemeyer1016@gmail.com>
MIME-Version: 1.0
From: Emilie Meyer <emiliemeyer1016@gmail.com>
Date: Sun, 16 Feb 2020 10:20:41 -0800
Message-ID: <CAFF9uhp7M94yAPhWnpUkBwLzQa8rgxMGdBYU2CNQ203QtJZs9g@mail.gmail.com>
Subject: Issue with bridging LAN and mesh network
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi all

I have tried to set up a mesh network according to the following tutorial:

https://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide

Everything goes well until the steps for creating a bridge between
eth0 and bat0.
When running the command as shown below, it fails.

root@OpenWrt:~# ip link set eth0 master mesh-bridge
ip: either "dev" is duplicate, or "master" is garbage

I suspect that the ip version (BusyBox v1.28.4) I got does not support bridging?
Sincerely hope that someone can please guide me to solve this issue.

This is my HW/SW:
HW: TP-Link TL-WR841N and Ubiquiti M2 Bullet
OpenWrt 18.06.4, r7808-ef686b7292

As you see I have not the newest HW so that's the reason why I have
initially tried to use OpenWrt version 18.06.4 and not the newest
version.
Anyone that have experience with Batman on these wifi devices, please share.

Many thanks in advance for your help.

-- 
Regards

Emilie
