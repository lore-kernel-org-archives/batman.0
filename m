Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 23 Oct 2013 01:47:29 +0200
References: <525B1838.4070900@altermundi.net>
In-Reply-To: <525B1838.4070900@altermundi.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201310230147.29419.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Add a lightweight framework
	for running facter scripts that feed data into alfred every 5
	minutes
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
To: b.a.t.m.a.n@lists.open-mesh.org

> Alfred expects to be fed data periodically, but there's currently no easy
> way to do that from scripts, prompting people to write whole C programs
> to accomplish tasks that could easily be scripted.
> Provide a really simple framework to run scripts every 5 minutes, using a
> cronjob, when alfred is started by the init.d script.
> 
> Signed-off-by: Gui Iribarren <gui@altermundi.net>
Applied in the OpenWRT routing feed in commit 14f85e7 and commit 0d9ca3e in 
the devel feed.

Thanks!
   Simon
