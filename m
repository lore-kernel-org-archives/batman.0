Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 22 Mar 2010 22:46:12 +0100
Message-Id: <1269294375-11043-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] Staging: Batman-adv: Bug fixes for
	2.6.34-rc2.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi Greg

Here are three patches against 2.6.34-rc2 which we would like including 
into the next -rc kernel. All three are bug fixes, with the first being a
regression relative to 2.6.33 and the second two being older bugs, prescent 
in 2.6.33.

   Thanks
	Andrew

Andrew Lunn (1):
  Staging: batman-adv: don't have interrupts disabled while sending.

Linus Luessing (1):
  Staging: batman-adv: Fix VIS output bug for secondary interfaces

Linus Lüssing (1):
  Staging: batman-adv: Fixing wrap-around bug in vis

 drivers/staging/batman-adv/proc.c |   51 ++++++---
 drivers/staging/batman-adv/vis.c  |  235 +++++++++++++++++++++++++------------
 drivers/staging/batman-adv/vis.h  |    8 +-
 3 files changed, 202 insertions(+), 92 deletions(-)

