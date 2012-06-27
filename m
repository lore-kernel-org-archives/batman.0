Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 27 Jun 2012 10:23:03 +0200
Message-Id: <1340785387-3821-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/5] new feature: Speedy Join 2012-06-27
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

Hello people,

this is the second version of the Speedy Join feature.

Since version v1 I changed a few things:
- indentation and style has been fixed taking into consideration Sven's
  suggestions
- Old patch 4 has been removed. TT flags do not really need to be carry along
  with the tt_entry in a roaming_adv packet. (at least this is not needed for
  the purpose of this feature). A roaming client will be marked as ROAM on the
  new mesh node and therefore it will be already purged if nobody claims it.

Thank you,
	Antonio

