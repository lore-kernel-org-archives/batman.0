Return-Path: <bittorf@bluebottle.com>
Date: Tue, 1 Apr 2014 13:16:39 +0200
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20140401111639.GG26159@medion.lan>
References: <0643725B-CC5E-4AAA-8908-C6A0EA4CE631@gmail.com>
 <26865236.GIsAj78OZH@diderot> <533A078C.7060803@wirelesspt.net>
 <533A2A75.4000602@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533A2A75.4000602@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Batman-adv 2014.1.0 and 2014.0.0 issues with
 3.10 and 3.8 kernels
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

* Gui Iribarren <gui@altermundi.net> [01.04.2014 10:08]:
> something like
> 
>     $ cd feeds/routing
>     $ git log batman-adv # find your favorite old version
>     $ git checkout e2cfab7f287673b1d6854c59db6e710668d145f3

IMHO this does not work, because 'scripts/feeds' throws away
the history ("git clone --depth 1").

bye, bastian
