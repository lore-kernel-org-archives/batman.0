Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 00:27:20 +0200
Message-Id: <1334701645-25862-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] Preparation for SPEEDY_JOIN/ROAM
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello everybody,

in preparation to my next patchset, which will enable clients to be detected
from nodes in the network _before_ they are announced by means of the TT
mechanism (more details will come within the companion email email of the
related patchset), I'm sending this 4 patches that fix/clean up something here
and there plus a little behaviour change in the OGM preparation.

In particular (for further details please refer to the commit message of each
patch):

patch 1) changes the behaviour of how an OGM is built. Instead of
preparing/building it at the same time we schedule it, this patch delays such
operation to the instant before sending the message. This patch also introduce a
new entry in the protocol API called ".bat_fill_ogm".

patch 2) in case of ADD and DEL events (or viceversa) of the same client during
the same originator interval, such events can be both nullified instead of being
sent.

patch 3) future operations will require to look for a particular originator in
the orig_list of a global entry, therefore tt_global_entry_has_orig() is
modified accordingly so that it returns the found originator, if any.

patch 4) updates the tt_global_entry ttvn in case of reannouncement of the same
client.

patch 5) changes tt_global_Add() sign. We use to pass several boolean flags to
this function that are then converted to the TT_CLIENT_* ones. This patch
modifies the tt_global_add() sign so that we can directly pass a combination of
TT_CLIENT_* flags instead of several boolean parameters.



Thank you,
	Antonio



