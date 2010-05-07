Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:05 +0200
Message-Id: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv: linux-next
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi Greg.

Here are the patches again, this time with the right authorship. Sorry
we messed it up and caused you extra work.

     Thanks
	Andrew

Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Andrew Lunn (2):
      Staging: batman-adv: Update TODO file to reflect current state.
      Staging: batman-adv: updating README

Dan Carpenter (1):
      Staging: batman-adv: cleanup: change test for end of array

Linus L?ssing (4):
      Staging: batman-adv: only modify hna-table on active module
      Staging: batman-adv: Fix aggregation direct-link bug
      Staging: batman-adv: Remove dead max addr and obsolete VIS_FORMAT strings
      Staging: batman-adv: Update README about vis raw output

Luis de Bethencourt (1):
      Staging: batman-adv: fix whitespace style issues

Marek Lindner (6):
      Staging: batman-adv: fix aggregation timing bug
      Staging: batman-adv: convert multiple /proc files to use sysfs
      Staging: batman-adv: convert more files from /proc to /sys
      Staging: batman-adv: move originator interval setting from /proc to /sys
      Staging: batman-adv: remove redundant pointer to originator interface
      Staging: batman-adv: move /proc interface handling to /sys

Simon Wunderlich (7):
      Staging: batman-adv: Update copyright years
      Staging: batman-adv: remove the beta from main.h for release
      Staging: batman-adv: Add 0.2.1 changes to the CHANGELOG
      Staging: batman-adv: Changing version to 0.2.2-beta
      Staging: batman-adv: Reorganize sequence number handling
      Staging: batman-adv: Limit queue lengths for batman and broadcast packets
      Staging: batman-adv: kfree_skb() in interface_tx() in error case

Sven Eckelmann (5):
      Staging: batman-adv: Clone shared bat packets before modifying them
      Staging: batman-adv: fix whitespace style issues
      Staging: batman-adv: Update pointer to ethhdr after skb_copy
      Staging: batman-adv: Fix whitespace problems criticized by checkpatch.pl
      Staging: batman-adv: Reduce max characters on a line to 80
