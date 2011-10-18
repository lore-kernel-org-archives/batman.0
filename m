Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Tue, 18 Oct 2011 13:59:18 +0200
Message-ID: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Compile error on openwrt with new patch
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,
after an ./script/feeds update when i try to build openwrt I get an
error on batman-adv package:

Applying ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.patch
using plaintext:
patching file translation-table.c
Hunk #1 FAILED at 1054.
Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.rej
Patch failed!  Please fix
./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.patch!

Rgds

-- 
Filippo Sallemi
