Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Network stops passing traffic randomly
From: smartwires@gmail.com
Date: Mon, 25 May 2020 08:35:12 -0000
Message-ID: <20200525083512.832.13419@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

I have been battling a weird problem recently, I have this problem occurring on two (2) separate networks, one with 2 nodes and the other with 3 nodes. What happens is the network is fine and all of a sudden the clients can not reach the Internet, This what I have observed. on both Openwrt 19.07, 18.07. A reboot of the gateway corrects the problem. 
1. Gateway is up and running and able the reach the internet.
2. batctl o show the neighbor/s
3. batctl ping [MAC] fails

root@Main-GW:~# batctl o
[B.A.T.M.A.N. adv openwrt-2018.1-5, MainIF/MAC: mesh0/e8:5b:b7:00:10:73 (bat0/22:55:4d:3e:5f:8f BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * e8:5b:b7:00:10:6b    0.880s   (255) e8:5b:b7:00:10:6b [     mesh0]
root@Main-GW:~# batctl ping e8:5b:b7:00:10:6b
PING e8:5b:b7:00:10:6b (e8:5b:b7:00:10:6b) 20(48) bytes of data
Reply from host e8:5b:b7:00:10:6b timed out
Reply from host e8:5b:b7:00:10:6b timed out
Reply from host e8:5b:b7:00:10:6b timed out
Reply from host e8:5b:b7:00:10:6b timed out
