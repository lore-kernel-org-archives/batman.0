Return-Path: <moritz.warning@uni-bielefeld.de>
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=ISO-8859-1
Date: Tue, 16 Oct 2012 14:43:52 +0200
From: Moritz Warning <moritz.warning@uni-bielefeld.de>
Message-id: <14969_1350392034_ZZi171PvmcSCs.00_507D5688.1010203@uni-bielefeld.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove footer from originators
	list
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch would make the output consistent with the "batctl tg" output
by sending no output if there is no entry to be displayed.

The intention is to make it easier to parse the output using console facilities.
Of course you could use grep -v "^No" to filter out this line,
but that would be ugly and somewhat harsh for low performance machines such as routers
and big tables (I haven't done benchmarks in this regard).
This also helps the intention of the -H patch (https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-October/008143.html).

Relevant ticket: http://www.open-mesh.org/issues/165

Signed-off-by: Moritz Warning <moritzwarning at web.de>
diff --git a/originator.c b/originator.c
index 8c32cf1..d559a77 100644
- --- a/originator.c
+++ b/originator.c
@@ -467,9 +467,6 @@ next:
                rcu_read_unlock();
        }
 
- -       if (batman_count == 0)
- -               seq_printf(seq, "No batman nodes in range ...\n");
- -
 out:
        if (primary_if)
                batadv_hardif_free_ref(primary_if);
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJQfVaIAAoJECHrh56PP4wpuzQH/ib2VlbQ1ulVsvNMoZ3Vltxp
F+CXAPLymPrWPu30+vzFN2FauEtjT8K3WY4J0JgnlZqt1D9163kxvEnaCXTMRPsV
B1YT5dnPIyKMdJfX/XULdSJtxAy1PCL4HqbJvRm+QhqXnDisUMMjfL3rX9tCyAb0
ctQt+VxVhodNbznTAbol2jeEnnNsZOvyoSQ/0x850grnx0kRRLWy9y2xsrBxuhtn
hyEBepOTx84z2bw1IIQJgOiafNVz+NtvMWKBnhZgkIsJbZac8g0IWY18uW0icqWC
JyuYQHlsuYO3v9pez4MLkO6DWlez1+3tKiTs/Yj5qS1cAmEfrrUGHV9ouetF80Q=
=MoTM
-----END PGP SIGNATURE-----
