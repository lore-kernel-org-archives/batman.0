Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 May 2018 22:03:10 +0200
Message-Id: <20180525200312.13527-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 0/2] batman-adv: Default build sync with Kconfig
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
Cc: a@unstable.cc, linus.luessing@c0d3.blue, Sven Eckelmann <sven@narfation.org>

Hi,

yes, this is a rather harsh reminder that you should keep your settings in 
Kconfig and the out-of-tree module Makefiles in sync. Please submit an 
alternate patch (with a good commit message) for net/batman-adv/Kconfig when 
you want to keep the feature enabled by default.

Kind regards,
	Sven

Sven Eckelmann (2):
  batman-adv: Disable DAT during compilation
  batman-adv: Disable MCAST during compilation

 Makefile               | 4 ++--
 README.external.rst    | 4 ++--
 gen-compat-autoconf.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.0

