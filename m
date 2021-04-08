Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Problems with Multiple Interfaces
From: joe@careyhome.org
Date: Thu, 08 Apr 2021 05:56:29 -0000
Message-ID: <20210408055629.1234.95039@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Everybody,

I'm running BATMAN v 2019.2 with ath10k on OpenWRT.  The particular router I'm using has two interfaces, 2.4 GHz and 5GHz.  With each router using single interface (e.g. 2.4 GHz), it works fine.  When I add a second interface (e.g. 5GHz), it sometimes hangs.  

I know that BATMAN is expected to alternate between the two interfaces, but that doesn't seem to be working.  As you probably know, using two interfaces should dramatically improve throughput if you need to make a hop through another mesh node.

To verify this is the problem, I did a test where I ran three routers,  2.4G <> Dual (2.4G & 5G) <> 5G.  I would try to ping between the two routers that were using just a single interface.  Obviously, that must hop through the dual radio router.  The dual radio router has both interfaces on the bat0 master, and batctl reports they're both active.  

The system would sometimes lose link, although batctl would report getting neighbor messages.  Even using the batctl ping function doesn't get through.  I can see traffic flowing on both the 2.4 GHz and 5GHz interfaces. 

I'm happy to provide lots of configuration detail, but I thought I'd start with a high level description in case this is a known problem.

Any assistance is appreciated.  Thank you,

--Joe
