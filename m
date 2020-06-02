Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Network stops passing traffic randomly
References: <20200525083512.832.13419@diktynna.open-mesh.org>
 <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
 <1970963.L7oaDoOIKM@sven-edge>
 <04932e2f-d727-46ce-ef68-2c79062cf196@coolheads.com>
 <41ed807d-5bbf-8cd0-53e8-0951c84b4889@candelatech.com>
 <1f7b4548-d4b1-2063-dd73-fa866d195efe@coolheads.com>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <c310a314-91a4-64b2-494f-f3d559de230e@coolheads.com>
Date: Tue, 2 Jun 2020 08:40:21 -0400
MIME-Version: 1.0
In-Reply-To: <1f7b4548-d4b1-2063-dd73-fa866d195efe@coolheads.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Reply-To: srn@coolheads.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Never mind.=A0 I shouldn't have asked, because=20
openwrt/dl/ath10k-ct-2020-03-25-3d173a47.tar.xz!ath10k-ct-2020-03-25-3d17=
3a47/README.txt=20
clearly states:

This is a copy of the drivers/net/wireless/ath/ath10k tree from
the Candela-Technologies (CT) 4.7, 4.9, and 4.13 kernels.

This package may be useful for people trying to use CT ath10k
firmware on LEDE/OpenWRT, or other custom-built kernels.

The ath10k driver has a lot of patches, most of which are to enable it to
work more effectively with the ath10k CT firmware:

http://www.candelatech.com/ath10k.php

To compile with some help:
./build_me.sh

To compile manually:
cd ath10k
cp make_all make_all.mine
chmod a+x make_all.mine
# Edit make_all.mine to point to your compiled kernel
# Copy ath/*.h files into ../
# This header file stuff is not obvious, sorry..but it helps us compile
# properly on LEDE/OpenWRT backports infrastructure.
./make_all.mine


For full kernel source that these drivers came from, see:

http://dmz2.candelatech.com/?p=3Dlinux-4.7.dev.y/.git;a=3Dsummary
git clone git://dmz2.candelatech.com/linux-4.7.dev.y

http://dmz2.candelatech.com/?p=3Dlinux-4.4.dev.y/.git;a=3Dsummary
git clone git://dmz2.candelatech.com/linux-4.4.dev.y

Please send bug reports to:=A0 greearb@candelatech.com


On 6/1/20 9:41 PM, Steve Newcomb wrote:
>
>
> On 5/28/20 5:28 PM, Ben Greear wrote:
>> I've tested DFS in STA/AP mode and that works fine on my=20
>> driver/firmware, possibly
>> due to us setting the regdom as a fwcfg option, I suppose.=20
> I wonder how I can set the regdom as fwcfg option?=A0 I don't know the=20
> procedure to try that.=A0 Do I need to cross-compile the firmware=20
> myself, rather than using the OpenWRT package?
