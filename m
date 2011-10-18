Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 18 Oct 2011 18:10:41 +0200
References: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
In-Reply-To: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201110181810.41338.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
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


Hi,

> after an ./script/feeds update when i try to build openwrt I get an
> error on batman-adv package:
> 
> Applying
> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet
> .patch using plaintext:
> patching file translation-table.c
> Hunk #1 FAILED at 1054.
> Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.rej
> Patch failed!  Please fix
> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.
> patch!

works for me. Do you have additional patches in your patches folder which are 
incompatible ?

Regards,
Marek
