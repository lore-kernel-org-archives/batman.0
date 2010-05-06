Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:26 +0200
Message-Id: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 00/26] staging:batman-adv
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


Hi Greg.

Here are a collection of BATMAM Advanced patches for Linux Next.

     Thanks
	Andrew

Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Andrew Lunn (2):
  staging:batman-adv: Update TODO file to reflect current state.
  staging:batman-adv: updating README

Dan Carpenter (1):
  staging:batman-adv: cleanup: change test for end of array

Linus L��ssing (2):
  batman-adv: only modify hna-table on active module
  staging:batman-adv: Fix aggregation direct-link bug

Marek Lindner (9):
  staging:batman-adv: fix aggregation timing bug
  staging:batman-adv: fix whitespace style issues
  staging:batman-adv: convert multiple /proc files to use sysfs
  staging:batman-adv: convert more files from /proc to /sys
  staging:batman-adv: move originator interval setting from /proc to
    /sys
  staging:batman-adv: remove redundant pointer to originator interface
  staging:batman-adv: move /proc interface handling to /sys
  staging:batman-adv: Fix whitespace problems criticized by
    checkpatch.pl
  staging:batman-adv: Reduce max characters on a line to 80

Simon Wunderlich (9):
  staging:batman-adv: Update copyright years
  staging:batman-adv: remove the beta from main.h for release
  staging:batman-adv: Remove dead max addr and obsolete VIS_FORMAT
    strings
  staging:batman-adv: Add 0.2.1 changes to the CHANGELOG
  staging:batman-adv: Update README about vis raw output
  staging:batman-adv: Changing version to 0.2.2-beta
  staging:batman-adv: Reorganize sequence number handling
  staging:batman-adv: Limit queue lengths for batman and broadcast
    packets
  staging:batman-adv: kfree_skb() in interface_tx() in error case

Sven Eckelmann (3):
  staging: batman-adv: Clone shared bat packets before modifying them
  staging:batman-adv: fix whitespace style issues
  staging:batman-adv: Update pointer to ethhdr after skb_copy

 drivers/staging/batman-adv/CHANGELOG           |   14 +
 drivers/staging/batman-adv/Makefile            |    4 +-
 drivers/staging/batman-adv/README              |  255 ++++++---
 drivers/staging/batman-adv/TODO                |   23 +-
 drivers/staging/batman-adv/aggregation.c       |   45 ++-
 drivers/staging/batman-adv/aggregation.h       |    7 +-
 drivers/staging/batman-adv/bat_sysfs.c         |  484 +++++++++++++++++
 drivers/staging/batman-adv/bat_sysfs.h         |   29 +
 drivers/staging/batman-adv/bitarray.c          |   76 ++-
 drivers/staging/batman-adv/bitarray.h          |    2 +-
 drivers/staging/batman-adv/device.c            |   37 +-
 drivers/staging/batman-adv/device.h            |    2 +-
 drivers/staging/batman-adv/hard-interface.c    |  531 ++++++++++---------
 drivers/staging/batman-adv/hard-interface.h    |   20 +-
 drivers/staging/batman-adv/hash.c              |    2 +-
 drivers/staging/batman-adv/hash.h              |    2 +-
 drivers/staging/batman-adv/main.c              |   60 ++-
 drivers/staging/batman-adv/main.h              |   23 +-
 drivers/staging/batman-adv/originator.c        |  295 ++++++++++-
 drivers/staging/batman-adv/originator.h        |    7 +-
 drivers/staging/batman-adv/packet.h            |    2 +-
 drivers/staging/batman-adv/proc.c              |  689 ------------------------
 drivers/staging/batman-adv/proc.h              |   40 --
 drivers/staging/batman-adv/ring_buffer.c       |    2 +-
 drivers/staging/batman-adv/ring_buffer.h       |    2 +-
 drivers/staging/batman-adv/routing.c           |  221 ++++++---
 drivers/staging/batman-adv/routing.h           |    2 +-
 drivers/staging/batman-adv/send.c              |  146 ++++--
 drivers/staging/batman-adv/send.h              |    6 +-
 drivers/staging/batman-adv/soft-interface.c    |   30 +-
 drivers/staging/batman-adv/soft-interface.h    |    2 +-
 drivers/staging/batman-adv/translation-table.c |   92 +++-
 drivers/staging/batman-adv/translation-table.h |    8 +-
 drivers/staging/batman-adv/types.h             |   54 ++-
 drivers/staging/batman-adv/vis.c               |  140 ++++-
 drivers/staging/batman-adv/vis.h               |   21 +-
 36 files changed, 1966 insertions(+), 1409 deletions(-)
 create mode 100644 drivers/staging/batman-adv/bat_sysfs.c
 create mode 100644 drivers/staging/batman-adv/bat_sysfs.h
 delete mode 100644 drivers/staging/batman-adv/proc.c
 delete mode 100644 drivers/staging/batman-adv/proc.h

