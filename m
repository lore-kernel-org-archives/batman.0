Return-Path: <laurent@wifibot.com>
From: laurent <laurent@wifibot.com>
Message-ID: <b00b8bd2-68bc-54fd-4d1c-cd3f9655fac1@wifibot.com>
Date: Mon, 25 Dec 2017 18:36:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [B.A.T.M.A.N.] cannot recompile my openwrt image with last version
 of batman-adv 2017-4
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

I had an openwrt image with batman-adv 2017-0 that compile fine but when 
I have updated to 2017-4 I got this error (it is a warning but treated 
as an error):

I am able to compile alone the module in the build forlder:

/home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/linux-cns3xxx/batman-adv-2017.4/net/batman-adv/bat_iv_ogm.c:734:2: 
error: implicit declaration of function 'skb_put_data' 
[-Werror=implicit-function-declaration]
   skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
   ^
cc1: some warnings being treated as errors
make[5]: *** 
[/home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/linux-cns3xxx/batman-adv-2017.4/net/batman-adv/bat_iv_ogm.o] 
Error 1
make[4]: *** 
[_module_/home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/linux-cns3xxx/batman-adv-2017.4/net/batman-adv] 
Error 2
make[4]: Leaving directory 
`/home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/linux-cns3xxx/linux-4.4'
make[3]: *** 
[/home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/linux-cns3xxx/batman-adv-2017.4/.built] 
Error 2
make[3]: Leaving directory 
`/home/user/gateworks-openwrt/feeds/routing/batman-adv'
make[2]: *** [package/feeds/routing/batman-adv/compile] Error 2
make[2]: Leaving directory `/home/user/gateworks-openwrt'
make[1]: *** 
[/home/user/gateworks-openwrt/staging_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/stamp/.package_compile] 
Error 2
make[1]: Leaving directory `/home/user/gateworks-openwrt'
make: *** [world] Error 2

Thank you

Laurent

