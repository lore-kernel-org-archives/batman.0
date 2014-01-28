Return-Path: <russell@personaltelco.net>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
 <52DF7556.9090200@makrotopia.org> <86y527oqpl.fsf_-_@coulee.tdb.com>
 <52E003DD.6040302@meshcoding.com> <52E02EDC.3080805@wirelesspt.net>
 <86iotbo9hw.fsf@coulee.tdb.com> <52E05E0F.7010203@wirelesspt.net>
 <52E08DFE.9030604@makrotopia.org> <52E5063E.3080408@makrotopia.org>
 <52E51A04.8020800@meshcoding.com> <52E5322D.60202@wirelesspt.net>
 <52E532D0.2000907@meshcoding.com> <52E5341F.30800@meshcoding.com>
 <52E69D7D.80905@wirelesspt.net>
From: Russell Senior <russell@personaltelco.net>
Date: Mon, 27 Jan 2014 17:21:32 -0800
In-Reply-To: <52E69D7D.80905@wirelesspt.net> (cmsv@wirelesspt.net's message of
 "Mon\, 27 Jan 2014 12\:55\:09 -0500")
Message-ID: <861tzsgaub.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

>>>>> "cmsv" == cmsv  <cmsv@wirelesspt.net> writes:

cmsv> Here is an update of some tests i ran in the past 24h with the
cmsv> following build:

cmsv> routers used: dlink dir 601a and tplink wr703n in "ng"
cmsv> mode. (atheros)

cmsv> My current AA DISTRIB_REVISION="r39154" mac80211 r39150 from
cmsv> openwrt trunk hostapd r39155 from trunk

I just went to try to set up an AA build environment from:

  git://git.openwrt.org/12.09/openwrt.git

in order to replicate.  The default feeds.conf from that tree seems to
point at a 'for-12.09.x' branch of the routing feed, and the
batman-adv Makefile there seems to use 2013.4.0, not 2014.0.0.  

Can you paste your feeds.conf file?


-- 
Russell Senior, President
russell@personaltelco.net
