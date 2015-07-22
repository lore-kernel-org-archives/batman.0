Return-Path: <carlosmeralto@gmail.com>
MIME-Version: 1.0
Date: Wed, 22 Jul 2015 15:26:23 +0100
Message-ID: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
From: Carlos Meralto <carlosmeralto@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.]  Recover in case of node fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi guys,

I'm trying to make a study of various protocols for WMN and one of
them is BATMAN. One the tests is the time to recovery in case of node
fail.

I have a topology with 4 routers with 2 possible paths:
A-B-C
A-D-C

For the test i'm doing a continuous ping from A to C (level 3 ping)
and shut down the router that forward the message (i.e B or C). In
this test BATMAN can't recover the PING. But when i cancel the ping
and check the Originators table (batctl o) the route is refreshed. And
when i try to ping again it works.

Is any limitation in BATMAN for recovery in a continuous PING?
Has anyone done this type of test and values obtained?

Thanks in advance.

Best Regards
