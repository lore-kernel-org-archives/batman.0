Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Bonding Alternating
From: brian.edmisten@viasat.com
Date: Thu, 09 Sep 2021 20:09:39 -0000
Message-ID: <20210909200939.1153.2026@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Before Adding radios to my setup I connected to computers with three NICs each.  I added all three interfaces to the mesh interface bat0 on each.  I then run iperf across it and all the traffic seems to go on one interface.  I run iperf3 with -p 4 so there are multiple streams.  Changing it to bonding does not seem to change the behavior.
batctl o - shows all three interfaces
batctl n - shows three interfaces -This I thought seemed odd as its one neighbor across three links
batctl tg - shows all clients Via one address

If anyone can point me at what to look at next or what might be wrong would help.

I am using BATMAN_V version 2019.4 in kernel 5.4.68.
