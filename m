Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  9 Dec 2010 10:23:48 +0100
Message-Id: <1291886638-19344-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] NDP patches v2
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

Hi there,

The following points have been changed during the last series:
- Use SKBs instead of own packet buffer
  (batman-adv: Send neighbor discovery packets)
- Also accept first packet for packet counting already 
  (batman-adv: Creating neighbor structures, updating LQs)
- Fixing the asymmetric penalty handling (no more changes since previous PATCHv2 10/10 though)
  (batman-adv: Use local tq values determined by NDP on OGMs)

I've also added my Signed-off-by now, as it seems to work fine here for me
and the integration now makes more sense to me after PATCHv2 10/10 :). So
for me, it'd be ok to add it upstream. Does it make sense to do the OGM
cleanup with these patches already or would it be fine to do them after
NDP got upstream? In the first case the maintenance/rebasing of the cleanup
patches might be more effort until NDP gets upstream. In the latter case,
there'd be no need to hurry for doing the cleanup then, reducing the chances
of breaking something :). Or would you prefer to have the full batch
including the cleanup for the OGMs already?

Cheers, Linus
