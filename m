Return-Path: <dirkvanderwalt@gmail.com>
MIME-Version: 1.0
From: Dirk van der Walt <dirkvanderwalt@gmail.com>
Date: Fri, 15 Jul 2016 21:41:53 +0200
Message-ID: <CACgQMVKA+UMo7CJZdWkojWqrx4urrK5oUxzXS1wonUcEtdRDQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Mesh speed comparison between Atheros and MediaTek
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

Hi list,

This is not strictly a Batman question, but I figured that it would be
a good place to ask.

I've always in the past used Atheros based hardware for the mesh nodes
and the results have been stable and with acceptable speeds.

Recently in my search for cheap and open hardware I got a few MT7620
based devices from ZBT in China. I run standard OpenWrt / LEDE on
them.

One of the tests that I conducted was to do an Iperf test between two
nodes and compare the results, Atheros VS MediaTek

I use the nodes in mesh point mode for connectivity between the nodes
and then run Batman on top of it:

config wifi-iface 'zero'
    option ifname 'mesh0'
    option disabled '0'
    option encryption 'none'
    option device 'radio0'
    option mesh_fwding '0'
    option mesh_id '02_CA_FE_CA_00_03'
    option mesh_ttl '1'
    option mcast_rate '18000'
    option mode 'mesh'
    option network 'mesh'

The MediaTek based mesh gave me very disappointing speeds between
nodes. The speeds on the MediaTek when in AP mode was however very
good.

So my question is if the driver of the MT7620 does have performance
issues when running in mesh point mode?

If not, is there perhaps a setting that one can specify to get the
speed up to where it could be.

I get for instance 7Mbits/sec between two MT7620 nodes and with that
same node can get speeds above 30Mbits/s connecting to the radio's AP
running ap mode.

With the Atheros, however both modes produce more or less the same speeds.

I'm happy to provide my configs should you require more info on the
setup of the nodes etc.

Thanks
