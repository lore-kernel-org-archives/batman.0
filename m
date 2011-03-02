Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Wed,  2 Mar 2011 18:18:29 +0100
Message-Id: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Redundancy bonding mode patches, v2
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

Hi everyone,

Here are some smaller modifications of the redundancy bonding mode patches. I
haven't modified the batman_header yet, as there seem to be some other opinions
about this, too and might be easier to discuss at the WBMv4.

As always, everything is available here as well:
http://git.open-mesh.org/?p=t_x/batman-adv.git;a=shortlog;h=refs/heads/rbonding

Cheers, Linus

rbonding changelog v2:
* Fix (interim) refcounting bug / memory leak in unicast_send_skb() [5/12]
* change recv_icmp_ttl_exceeded() to change_icmp_ttl_exceeded(), as it
  is in the sending code path now (thanks Andrew!) [3/12]
* Add missing ttl modification in aggregation.c [3/12]
* rebased to f39fe6f230e4cbf2b04e659b056ea62a652578a0
