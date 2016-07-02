Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 02 Jul 2016 09:18:43 +0200
Message-ID: <2321853.1W2NHJvWgx@sven-edge>
In-Reply-To: <1467432591-28023-2-git-send-email-linus.luessing@c0d3.blue>
References: <1467432591-28023-1-git-send-email-linus.luessing@c0d3.blue>
 <1467432591-28023-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6143549.d36OmDsybA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart6143549.d36OmDsybA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Haven't looked at the patch itself but it doesn't seem to compile (see
the CONFIG_* options):

    /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/gen-compat-autoconf.sh /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/compat-autoconf.h
    /usr/bin/make -C /home/sven/projekte/build_test/linux-build//linux-4.6 M=/home/sven/projekte/build_test/tmp.ZCzmUfnk6m PWD=/home/sven/projekte/build_test/tmp.ZCzmUfnk6m REVISION= CONFIG_BATMAN_ADV=m CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=n INSTALL_MOD_DIR=updates/ modules
    make[1]: Entering directory '/home/sven/projekte/build_test/linux-build/linux-4.6'
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/bat_algo.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/bat_iv_ogm.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/bitarray.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/debugfs.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/fragmentation.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/gateway_client.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/gateway_common.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/hard-interface.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/hash.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/icmp_socket.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/main.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/netlink.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/network-coding.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/originator.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/routing.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/send.o
      CC [M]  /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/soft-interface.o
    scripts/Makefile.build:291: recipe for target '/home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/soft-interface.o' failed
    scripts/Makefile.build:440: recipe for target '/home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv' failed
    Makefile:1428: recipe for target '_module_/home/sven/projekte/build_test/tmp.ZCzmUfnk6m' failed
    make[1]: Leaving directory '/home/sven/projekte/build_test/linux-build/linux-4.6'
    Makefile:77: recipe for target 'all' failed
    /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/soft-interface.c:252:9: error: undefined identifier 'batadv_dat_snoop_outgoing_dhcp_ack'
    /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/soft-interface.c: In function 'batadv_interface_tx':
    /home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/soft-interface.c:252:2: error: implicit declaration of function 'batadv_dat_snoop_outgoing_dhcp_ack' [-Werror=implicit-function-declaration]
      batadv_dat_snoop_outgoing_dhcp_ack(bat_priv, skb, proto, vid);
      ^
    cc1: some warnings being treated as errors
    make[3]: *** [/home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv/soft-interface.o] Error 1
    make[2]: *** [/home/sven/projekte/build_test/tmp.ZCzmUfnk6m/net/batman-adv] Error 2
    make[1]: *** [_module_/home/sven/projekte/build_test/tmp.ZCzmUfnk6m] Error 2
    make: *** [all] Error 2

Kind regards,
	Sven
--nextPart6143549.d36OmDsybA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXd2rTAAoJEF2HCgfBJntGCAsQAKzh57/Vjd92z/YUhaZpUpu4
xL7vKBuO3ejssxXSYLApQiErzVjxEh95+5ZQ96SvqlSb7OYdUu4Zs0VjsTjfUoMD
i2dRG13p7umdXpv8TriNan4iJHE5Ktlgj0ViDpWJa3BlJNXkW1p8O6RdAYUwGoyb
NpC9XiB9Vw511WNXhgl5VaBlvw5pQTmPEl8j/b/E2luECjK3p5YEB2TjSnzPyrps
xHZiB8PwZDESWSClmZBcBatI7T9KNfkaJS3wIim9s1s8r8Al9c4Ufy6fwIjwSBDn
j0+gV38kReSWsWB+wntlrmlpv259Awmx8KUphHiKMHMz2BOIDeAUkMuO0dkUtX0O
yY15QWHv8MEZ30lz0s3OuGLV5zZFpmnIf6oH13kz7OuDB0LobA7TEn1SKDUeCjJL
Zm4BC6jnunAv3F/wby/6ZrzjsgdHlBds0UpxpdaYHVPaReedwX6Eh7HKgqc7zXwc
MH82BLiQ/WHW37IY9cKyG6Qc2kKzulSpb4LDNjfesh6jowEyIKG7v4u8sZ1XqZCY
9m5616CrtO9JIJhJHcF870vvCi2z0nultqnEaQnrXQfTNukZnEpafkmRoF04lUIQ
ZDaJs+90zNyHcyBpnAIPRHQVBW11IBrcjbcGijI0te/F7bg4pdfygjH1x4hDNylj
cYzmXqfX51KPVrJcbzsD
=HXoW
-----END PGP SIGNATURE-----

--nextPart6143549.d36OmDsybA--

