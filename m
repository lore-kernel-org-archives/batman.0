Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  6 Sep 2018 14:35:23 +0200
Message-Id: <20180906123528.30490-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 0/5] batman-adv: Missing list checks for
 *list_add*
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

Marek reviewed the the previous version of the patcheset [0] and requested
some changes for patch 1 and 3.

* patch 1:

  - added kerneldoc about the locking requirements

* patch 3

  - changed batadv_softif_create_vlan to handle problems in
    batadv_sysfs_add_vlan as fatal error

Kind regards,
        Sven

[0] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?series=150&submitter=&state=*&q=&archive=both&delegate=
[1] https://www.open-mesh.org/issues/235
[2] https://www.open-mesh.org/issues/236
[3] https://www.open-mesh.org/issues/237
[4] https://www.open-mesh.org/issues/238
[5] https://www.open-mesh.org/issues/239
[6] https://www.open-mesh.org/issues/240
[7] https://www.open-mesh.org/issues/241
[8] https://patchwork.open-mesh.org/patch/4919/

 net/batman-adv/gateway_client.c    | 11 +++++++++--
 net/batman-adv/network-coding.c    | 27 +++++++++++++++------------
 net/batman-adv/soft-interface.c    | 25 ++++++++++++++++++-------
 net/batman-adv/translation-table.c |  6 ++++--
 net/batman-adv/tvlv.c              |  8 ++++++--
 5 files changed, 52 insertions(+), 25 deletions(-)

-- 
2.11.0

