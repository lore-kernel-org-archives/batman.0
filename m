Return-Path: <elfring@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <512d2e7c-0967-9303-2b68-6c9ef53d6ed2@users.sourceforge.net>
Date: Sat, 6 May 2017 18:12:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 0/2] batman-adv: Fine-tuning for three
 function implementations
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 6 May 2017 18:03:45 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Replace a seq_puts() call by seq_putc() in two functions
  Combine two seq_puts() calls into one call in batadv_nc_nodes_seq_print_text()

 net/batman-adv/bat_iv_ogm.c     | 2 +-
 net/batman-adv/bat_v.c          | 2 +-
 net/batman-adv/network-coding.c | 4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.12.2

