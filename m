Return-Path: <moritzwarning@web.de>
From: Moritz Warning <moritzwarning@web.de>
Subject: netlink error with openwrt-19.07 branch
Message-ID: <9e7c2d2d-0dab-f03d-1868-d8a3a59f781c@web.de>
Date: Sun, 4 Aug 2019 15:03:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
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

hi,

the OpenWrt branch openwrt-19.07 uses linux-4.14.134 and batman-adv 2019.2 (package release 4).

Compiling gives me this error:

home/user/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/batman-adv-2019.2/net/batman-adv/netlink.c:1346:4: error: 'const struct genl_ops' has no member named 'validate'
   .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
    ^~~~~~~~
/home/user/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/batman-adv-2019.2/net/batman-adv/netlink.c:1346:15: error: 'GENL_DONT_VALIDATE_STRICT' undeclared here (not in a function); did you mean 'MACSEC_VALIDATE_STRICT'?
   .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
               MACSEC_VALIDATE_STRICT
/home/user/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/batman-adv-2019.2/net/batman-adv/netlink.c:1346:43: error: 'GENL_DONT_VALIDATE_DUMP' undeclared here (not in a function); did you mean 'GENL_DONT_VALIDATE_STRICT'?
   .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
                                           ^~~~~~~~~~~~~~~~~~~~~~~
                                           GENL_DONT_VALIDATE_STRICT
/home/user/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/batman-adv-2019.2/net/batman-adv/netlink.c:1353:4: error: 'const struct genl_ops' has no member named 'validate'
   .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,


Is this a known error?
