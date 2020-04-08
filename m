Return-Path: <srn@coolheads.com>
From: Steve Newcomb <srn@coolheads.com>
Subject: working openwrt ibss configuration?
Message-ID: <3d4b35cb-4a4a-13a3-90dc-bbdb26456145@coolheads.com>
Date: Wed, 8 Apr 2020 14:10:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Ben Greear suggested to me that I ask for help in figuring out how to 
configure an adhoc/ibss based mesh.  I haven't been able to find an 
example that's relevant.

(Well, I've been able to find an example on YouTube that dates from 
before 
https://github.com/openwrt-routing/packages/commit/54af5a209e0a0a75b5eb712c0ca8056e66de02c0 
in which Sven revolutionized option proto batadv.  It's not very helpful 
now, I think.)

My problem is that I have a bunch of wave-1 radios that, running under 
ath10k-ct (Ben Greear's firmware), can support mesh networking only in 
ibss mode (says Ben Greear).  I can use the non-CT firmware's 802.11s 
implementation, but it's unreliable. I'm looking for a way around my 
still-growing number of self-diagnosis-and-reboot hacks that are 
necessary with nodes running the non-CT firmware.

I'm hoping that someone on this list is running batman-adv with 
ibss/adhoc mode with a recent version of OpenWRT and will provide me 
their appropriately-redacted working OpenWrt config files 
(/etc/config/{network|wireless} as an example of something that is known 
to work.

Steve Newcomb
