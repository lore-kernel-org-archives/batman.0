Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:23 +0100
Message-Id: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 00/10] staging:batman-adv:
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net

Andrew Lunn (2):
  Fix the naming of the debug option in Kconfig.
  Add Kconfig dependancies on PROC_FS and PACKET. signed-off-by: Andrew
    Lunn <andrew@lunn.ch>

marek (4):
  [batman-adv] replace internal logging mechanism with standard kernel
    logging
  [batctl adapt batctl to the new logging mechanisms
  Updating orig_str for debug
  [batman-adv] correctly name the configuration option for debugging

simon (4):
  Andrews refactored routing.c file patch: "I broke a lot of the big
    functions up into many smaller ones. This helps with readability
    and there is now a lot less code squashed against the right
    margin."
  stop permanent warnings if a device is added but deactivated.
  split originator handling parts off routing.c
  if discarding a packet, we need to read it under any condition.

