Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:44 +0200
Message-Id: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] kerneldoc cleanups
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

just some minor kerneldoc cleanups of things I found while running

    (./scripts/kernel-doc -v -list net/batman-adv/*.{c,h} 2>&1 > /dev/null)| \
    grep -v Scanning|grep -v -e BATADV_TQ_LOCAL_WINDOW_SIZE \
    -e "Excess struct/union/enum/typedef member 'bcast_bits' description in 'batadv_orig_node'" \
    -e "Excess struct/union/enum/typedef member 'real_bits' description in 'batadv_neigh_ifinfo_bat_iv'" \
    -e '#ifdef' -e "#define" -e '#endif' \
    -e "[0-9]* warnings" \
    -e 'no structured comments found'

There are still some warnings left.

Kind regards,
	Sven

