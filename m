Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Wed, 17 Aug 2016 23:07:57 +0200
Message-Id: <20160817210759.19357-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: hard interface removal
	fixes
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

Hi,

This patchset contains another, revived patch (1/2). As we had quite
some trouble validating the patches back then in Aalborg, I tried to
push the overall structure in a hopefully easier to read and comprehend,
API like style. While keeping the initial idea (that is, steal and claim
forwarding packets from the queue under spinlock, then wait and free
without spinlock as a second step) intact.

The second patch is another kernel splat I came across while playing
with msleep(s)/mdelay()s in the purging routines.

Regards, Linus


PS: Especially for 1/2 I'm unsure whether to target it for maint/stable.
It didn't seem to be a show stopper for anyone within the last three years
(had been the only one reporting it at #168, I think?). And the fix is
difficult to do as one-liners, unless risking to introduce new race
conditions.

